# View Inheritance Reference

## Reference Template

Use the self-contained template below as a starting point, then adapt it to the closest existing class in the target module.

Template class names are sample names only. Replace them with the user's requested class name.

## Target Directory and Namespace

Before creating files, determine the target directory and namespace from the user's request and the local project structure.

- In `dali-ui-components`, public handles generally live under `dali-ui-components/public-api/...`; impl classes may live under `integration-api`, `provider-api`, or `internal` depending on whether the class is provider-facing, extension-facing, or component-private. Follow the closest current class rather than assuming one namespace.
- In `dali-ui-foundation`, follow the closest existing class. `ViewImpl` itself lives under `public-api/views/view-impl.h`, while derived implementation classes may live under `provider-api`, `integration-api`, `extension-api`, or `internal` depending on their audience.
- In application or extension projects, do not assume the `public-api`, `provider-api`, `integration-api`, or `internal` directory structure exists.
- If the target directory, API level, or namespace is unclear, ask the user before creating files.

## Self-contained Template

### Handle Header

```cpp
#pragma once

#include <dali-ui-foundation/public-api/dali-ui-common.h>
#include <dali-ui-foundation/public-api/views/view.h>

namespace Dali
{
namespace Ui
{
namespace Integration DALI_INTERNAL
{
class ProductCardViewImpl;
}

class DALI_UI_API ProductCardView : public View
{
public:
  ProductCardView();
  ~ProductCardView();

  static ProductCardView New();
  static ProductCardView DownCast(BaseHandle handle);

  ProductCardView(const ProductCardView& view);
  ProductCardView(ProductCardView&& rhs) noexcept;
  ProductCardView& operator=(const ProductCardView& handle);
  ProductCardView& operator=(ProductCardView&& rhs) noexcept;

  DALI_UI_VIEW_WITH(ProductCardView)

  void DoSomething();

public: // Not intended for application developers
  /// @cond internal
  DALI_INTERNAL ProductCardView(Integration::ProductCardViewImpl& implementation);
  explicit DALI_INTERNAL ProductCardView(Dali::Internal::CustomActor* internal);
  /// @endcond
};

} // namespace Ui
} // namespace Dali
```

### Handle Source

```cpp
#include <dali-ui-components/public-api/product-card-view.h>

#include <dali-ui-components/integration-api/product-card-view-impl.h>

namespace Dali
{
namespace Ui
{

namespace
{
inline Integration::ProductCardViewImpl& GetImpl(ProductCardView& view)
{
  DALI_ASSERT_ALWAYS(view);
  return static_cast<Integration::ProductCardViewImpl&>(view.GetImplementation());
}

inline const Integration::ProductCardViewImpl& GetImpl(const ProductCardView& view)
{
  DALI_ASSERT_ALWAYS(view);
  return static_cast<const Integration::ProductCardViewImpl&>(view.GetImplementation());
}
} // anonymous namespace

ProductCardView::ProductCardView()
{
}

ProductCardView::~ProductCardView()
{
}

ProductCardView ProductCardView::New()
{
  return Integration::ProductCardViewImpl::New();
}

ProductCardView ProductCardView::DownCast(BaseHandle handle)
{
  return Ui::View::DownCast<ProductCardView, Integration::ProductCardViewImpl>(handle);
}

ProductCardView::ProductCardView(const ProductCardView& view)
: View(view)
{
}

ProductCardView::ProductCardView(ProductCardView&& rhs) noexcept = default;

ProductCardView& ProductCardView::operator=(const ProductCardView& handle)
{
  if(&handle != this)
  {
    View::operator=(handle);
  }
  return *this;
}

ProductCardView& ProductCardView::operator=(ProductCardView&& rhs) noexcept = default;

void ProductCardView::DoSomething()
{
  GetImpl(*this).DoSomething();
}

ProductCardView::ProductCardView(Integration::ProductCardViewImpl& implementation)
: View(implementation)
{
}

ProductCardView::ProductCardView(Dali::Internal::CustomActor* internal)
: View(internal)
{
  VerifyCustomActorPointer<Integration::ProductCardViewImpl>(internal);
}

} // namespace Ui
} // namespace Dali
```

### Impl Header

```cpp
#pragma once

#include <dali-ui-components/public-api/product-card-view.h>
#include <dali-ui-foundation/public-api/views/view-impl.h>

namespace Dali
{
namespace Ui
{
namespace Integration
{

class DALI_UI_API ProductCardViewImpl : public ViewImpl
{
public:
  static Ui::ProductCardView New();

  void DoSomething();

protected:
  ProductCardViewImpl();
  ~ProductCardViewImpl() override;

  void OnInitialize() override;

private:
  ProductCardViewImpl(const ProductCardViewImpl&) = delete;
  ProductCardViewImpl(ProductCardViewImpl&&) = delete;
  ProductCardViewImpl& operator=(const ProductCardViewImpl&) = delete;
  ProductCardViewImpl& operator=(ProductCardViewImpl&&) = delete;
};

} // namespace Integration
} // namespace Ui
} // namespace Dali
```

### Impl Source

```cpp
#include <dali-ui-components/integration-api/product-card-view-impl.h>

#include <dali/devel-api/object/type-registry-helper.h>
#include <dali/devel-api/object/type-registry.h>

namespace Dali
{
namespace Ui
{
namespace Integration
{
namespace
{
BaseHandle Create()
{
  return BaseHandle();
}

DALI_TYPE_REGISTRATION_BEGIN(ProductCardViewImpl, ViewImpl, Create)
DALI_TYPE_REGISTRATION_END()
} // anonymous namespace

Ui::ProductCardView ProductCardViewImpl::New()
{
  IntrusivePtr<ProductCardViewImpl> impl = new ProductCardViewImpl();
  Ui::ProductCardView handle = Ui::ProductCardView(*impl);
  impl->Initialize();
  return handle;
}

ProductCardViewImpl::ProductCardViewImpl()
: ViewImpl()
{
}

ProductCardViewImpl::~ProductCardViewImpl()
{
}

void ProductCardViewImpl::OnInitialize()
{
  ViewImpl::OnInitialize();
}

void ProductCardViewImpl::DoSomething()
{
  Ui::ProductCardView handle = Ui::ProductCardView::DownCast(Self());
  handle.SetBackgroundColor(Ui::UiColor(0x00FFFF));
}

} // namespace Integration
} // namespace Ui
} // namespace Dali
```

## Required Pattern

The handle class inherits from `Dali::Ui::View` and exports with `DALI_UI_API` when it is part of DALi UI public/provider-facing API.

```cpp
class DALI_UI_API ProductCardView : public View
{
public:
  static ProductCardView New();
  static ProductCardView DownCast(BaseHandle handle);

  ~ProductCardView(); // non-virtual
};
```

The impl class inherits from `Dali::Ui::ViewImpl`. For current `dali-ui-components` patterns, its `New()` commonly returns the public handle, not an impl pointer.

```cpp
class DALI_UI_API ProductCardViewImpl : public ViewImpl
{
public:
  static Ui::ProductCardView New();

protected:
  ~ProductCardViewImpl() override;
};
```

## Typed Extension Hook

When a new handle class derives from `View`, include `DALI_UI_VIEW_WITH(Handle)` in the handle class.

This macro declares a typed `With()` helper used by current `dali-ui` View-derived handles. It is not a fluent setter-chain macro and it does not make inherited `View` setters return the derived handle type.

```cpp
ProductCardView card = ProductCardView::New();
card.With([](ProductCardView& view) {
  view.DoSomething();
});
```

Do not use the older `DALI_UI_CHAIN_VIEW_METHODS` name; it is not present in the current `dali-ui` tree.

## Inheritance Boundary

This skill is for direct inheritance from `Dali::Ui::View`.

`ViewImpl` is a special exception because it is the intended base for new View-derived implementations. Some existing controls, such as `Label` and `ImageView`, expose impl classes for framework/provider use, but they are not app-developer public inheritance points and should not be treated as normal external base classes.

If the user asks to inherit from `Label`, `ImageView`, or another View-derived class, explain this boundary and recommend data attachment instead. If a separate data-attachment skill is available, use that skill for the task.

## Handle to Impl

Use `GetImpl()` helpers where handle forwarding methods need implementation access. Put helpers in the public source file or in the impl header according to the closest local pattern.

```cpp
inline Integration::ProductCardViewImpl& GetImpl(ProductCardView& view)
{
  DALI_ASSERT_ALWAYS(view);
  return static_cast<Integration::ProductCardViewImpl&>(view.GetImplementation());
}
```

Use `View::DownCast<Handle, Impl>()` for DownCast when the local class uses the standard helper.

```cpp
ProductCardView ProductCardView::DownCast(BaseHandle handle)
{
  return Ui::View::DownCast<ProductCardView, Integration::ProductCardViewImpl>(handle);
}
```

If the closest existing class uses a hand-written dynamic-cast DownCast for a special inheritance hierarchy, follow that local pattern.

## Creation

For current DALi UI component classes, follow this `New()` flow unless the local class pattern differs:

1. Public handle `New()` delegates to `Impl::New()`.
2. `Impl::New()` creates the impl with `new Impl()` and stores it in an `IntrusivePtr`.
3. `Impl::New()` creates the public handle from the impl.
4. `Impl::New()` calls `impl->Initialize()`.
5. `Impl::New()` returns the public handle.

## Type Registration

Register the new type in the impl source file or the source file used by the local pattern.

```cpp
namespace
{
BaseHandle Create()
{
  return BaseHandle();
}

DALI_TYPE_REGISTRATION_BEGIN(ProductCardViewImpl, ViewImpl, Create)
DALI_TYPE_REGISTRATION_END()
}
```

Use the correct registered base class. For direct `ViewImpl` subclasses, use `ViewImpl`. For subclasses of another exposed impl, use that impl base.

Many current component implementations return an empty `BaseHandle()` from `Create()` and expose construction through their explicit `New()` factory. If the closest existing class returns a real handle from `Create()`, follow that class.

## Self()

Inside impl code, call `Self()` when a DALi handle is needed, then downcast if required.

```cpp
Ui::ProductCardView view = Ui::ProductCardView::DownCast(Self());
```
