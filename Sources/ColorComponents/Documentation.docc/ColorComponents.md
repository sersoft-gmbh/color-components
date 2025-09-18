# ``ColorComponents``

Easily deal with various representations of colors.


## Installation

Add the following dependency to your `Package.swift`:
```swift
.package(url: "https://github.com/sersoft-gmbh/color-components.git", from: "1.0.0"),
```

Or add it via Xcode (as of Xcode 11).

## Usage

These color component implementations are currently included in `ColorComponents`:
-   ``BW`` & ``BWA``
-   ``HSB`` & ``HSBA`` (with aliases for ``HSV`` & ``HSVA``)
-   ``HSL`` & ``HSLA``
-   ``RGB`` & ``RGBA``
-   ``CIE/XYZ`` & ``CIE/XYZA``

Each implementation is generic and supports both integer values (0 - 255) and floating point values (0.0 - 1.0). Also, conversions between components have been implemented. Some conversions have to go through other components, though.

If available, each implementation also provides conversion options from and to the platform native colors (e.g. `UIColor` on iOS, tvOS & watchOS and `NSColor` on macOS). `SwiftUI.Color` is also supported as of macOS 11, iOS 14, tvOS 14 and watchOS 7. Due to the lack of direct component accessors, `SwiftUI.Color` support goes through the aforementioned platform colors.
