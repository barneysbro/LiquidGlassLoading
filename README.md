# LiquidGlassLoading

A tiny SwiftUI/UIKit loading HUD with a glass-style background.

- SwiftUI view API
- UIKit presenter API
- Loading, success, and error styles
- Uses `UIGlassEffect` on iOS 26+
- Falls back to `UIBlurEffect` on older iOS versions

## Requirements

- iOS 15+
- Swift 5.9+

## Installation

Add this package in Xcode:

```text
https://github.com/barneysbro/LiquidGlassLoading
```

## SwiftUI Usage

```swift
import LiquidGlassLoading

LiquidGlassLoadingView(title: "Loading...")

LiquidGlassLoadingView(title: "Done", style: .success)
LiquidGlassLoadingView(title: "Failed", style: .error)
```

## UIKit Usage

```swift
import LiquidGlassLoading

LiquidGlassHUD.showLoading(in: view, title: "Loading...")
LiquidGlassHUD.dismiss(from: view)

LiquidGlassHUD.showSuccess(in: view, title: "Done")
LiquidGlassHUD.showError(in: view, title: "Failed")
```

## License

MIT
