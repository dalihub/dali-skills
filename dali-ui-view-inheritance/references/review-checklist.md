# Review Checklist

Use this checklist before finishing a View inheritance task.

- The handle class inherits from `Dali::Ui::View`.
- The impl class inherits from `Dali::Ui::ViewImpl` or the correct exposed local impl base, including `Provider::*Impl` where the closest component pattern uses provider-api.
- Public/provider-facing classes use `DALI_UI_API` following local patterns.
- The handle class has no data members.
- The handle destructor is non-virtual.
- State and logic are stored in the impl class.
- `New()` follows the closest local pattern, usually public handle `New()` delegating to `Impl::New()`.
- `Impl::New()` creates the impl, creates the handle, calls `Initialize()`, and returns the handle when following current component patterns.
- `DownCast()` uses `View::DownCast<Handle, Impl>()` unless the closest local class uses a special dynamic-cast pattern.
- `GetImpl()` helpers exist where forwarding methods need impl access.
- Impl code uses `Self()` when it needs a handle.
- DALi type registration is present with the correct base impl class.
- The type registration `Create()` follows the closest local pattern, often returning `BaseHandle()` for current components.
- `OnInitialize()` calls the base implementation, such as `ViewImpl::OnInitialize()`, before subclass-specific initialization.
- The handle class includes `DALI_UI_VIEW_WITH(Handle)`.
- The code does not use obsolete `DALI_UI_CHAIN_VIEW_METHODS`.
- File names match the local project naming style.
- Public API changes follow ABI rules.
- Includes and namespaces match local patterns.
- The implementation follows the self-contained View inheritance reference and the closest existing local example.
- The task is direct `View` inheritance. If the user asks to inherit from `Label`, `ImageView`, or another View-derived class, recommend data attachment instead.
