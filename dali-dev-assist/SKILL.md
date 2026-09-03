---
name: dali-dev-assist
description: Use this skill when helping with DALi, dali-core, dali-adaptor, or dali-ui code, API usage, samples, guide examples, debugging, or documentation-sensitive implementation. It requires DALi facts to be grounded only in retrieved DALi RAG MCP evidence, not model memory.
x-updated: "2026-09-03T05:41:22Z"
---

# DALi Dev Assist

Use this skill for DALi development help: writing or reviewing code, fixing API usage, adapting samples, explaining behavior, or producing guide/sample snippets for `dali-core`, `dali-adaptor`, or `dali-ui`.

## Core Rule

For DALi-specific facts, retrieved DALi RAG MCP evidence is the source of truth.

Do not rely on model memory for:

- class, method, enum, property, signal, typedef, namespace, include, or overload existence
- receiver type compatibility
- enum value ownership
- property constant ownership
- callback signatures
- app-facing idioms
- guide or sample behavior

If DALi RAG MCP evidence is unavailable or incomplete, say what could not be verified and avoid inventing DALi APIs.

General C++ knowledge may be used, but every DALi API claim must be backed by retrieved evidence.

## Workflow

1. Classify the request.
   - `app-code`: app/UI code, guide examples, or sample-like usage
   - `platform-code`: adaptor, integration, backend, lifecycle, windowing, input, rendering, or internal/platform work
   - `debug-fix`: compilation error, runtime issue, API mismatch, or code review
   - `docs-sample`: generated guide, tutorial, README, or sample code

2. Query DALi RAG MCP before answering any API-sensitive part.
   - Search exact symbols, methods, enum values, property names, signal names, and error text from the user request.
   - Search likely owning classes and namespaces.
   - Search `dali-ui/samples` and existing guide documents when the user asks for example-style code.
   - Search headers first when checking API shape; search implementation files when behavior matters.

3. Build a compact evidence pack in your working context.
   - API declarations: symbol, signature, owner, namespace, header path
   - Property and enum owners: exact owner and value
   - Signal/callback shape: typedef or connect method signature
   - Sample/guide usage: path and short relevant snippet summary
   - Confidence gaps: missing declarations, ambiguous overloads, or conflicting evidence

4. Answer or edit using only the evidence pack for DALi facts.
   - Prefer the smallest code change that satisfies the request.
   - For app-facing UI code, default to `dali-ui` idioms and `Dali::Ui::View`-based examples when evidence supports them.
   - Use `dali-core` and `dali-adaptor` as setup/background for app-code unless retrieved evidence or the user request indicates they are the target surface.
   - For platform-code, use the surface indicated by evidence and the user's target, but still verify every DALi API through RAG.

5. Verify before finalizing.
   - Receiver method exists on the inferred receiver type.
   - Static methods are called statically; member methods are called on valid instances.
   - Assignment target is compatible with return type.
   - Argument count, argument type, and overload shape match retrieved declarations.
   - Enum owner and enum value both exist.
   - Property constants use the exact retrieved owner.
   - Signal callback signatures match retrieved signal typedefs.
   - Code does not depend on guessed namespaces or inferred overloads.

## Retrieval Policy

Use `mcp__Tizen-MCP__tizen_rag_search` to search DALi source code, headers, samples, and documentation.

Suggested query sequence:

- For a new code example:
  1. primary feature/class name
  2. relevant factory, setter/getter, signal, enum, and property names
  3. matching `dali-ui/samples` usage
  4. matching guide document usage

- For a compile/API error:
  1. exact error text
  2. receiver type and method name
  3. candidate owner class headers
  4. enum/property/signal owner declarations

- For code review:
  1. every DALi scoped symbol in the changed code
  2. every receiver-method pair
  3. every enum/property value
  4. nearby sample or guide idioms

Prefer evidence in this order:

1. Exact public or target-surface header declaration
2. Implementation source that confirms behavior
3. Repository sample usage
4. Existing guide documentation
5. Tests/UTCs as supporting evidence

When evidence conflicts, prefer headers for API shape and implementation/tests for runtime behavior. Mention the conflict briefly if it affects the answer.

## Code Policy

For app-code and docs-sample requests:

- Prefer `dali-ui` app-facing APIs.
- Prefer `Dali::Ui::View` object-model examples over raw `Dali::Actor` examples when evidence supports the View API.
- Prefer typed setters/getters over raw `SetProperty`/`GetProperty` when equivalent typed APIs exist in retrieved evidence.
- Use raw property APIs only when they are the documented or retrieved idiom for that task.
- Keep examples compact and compilable-looking.
- Adapt sample code to the user's situation; do not paste large samples unless requested.

For all DALi code:

- Do not invent APIs, overloads, enum values, property owners, signal names, or include paths.
- Do not write unresolved placeholders as if they were real APIs.
- Do not use no-op `(void)name;` lines solely to silence warnings in example code.
- Do not silently switch surfaces. If the evidence is platform/internal but the user asked for app code, explain the mismatch.

## If RAG Is Missing

If no DALi RAG MCP tool is available, or retrieval fails:

- Do not present DALi API details as factual.
- Ask for the MCP/tool availability to be fixed, or offer a non-DALi-specific C++ explanation.
- If local repository files are explicitly provided and the user allows direct source inspection, treat direct file reads as evidence for that local task, but still label the evidence source.

## Response Style

Be direct and evidence-grounded.

When giving code, include only the necessary explanation. Mention the key evidence sources by path or symbol when useful, especially for non-obvious API choices.
