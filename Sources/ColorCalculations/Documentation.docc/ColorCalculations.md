# ``ColorCalculations``

Calculate colors of images.

## Installation

Add the following dependency to your `Package.swift`:
```swift
.package(url: "https://github.com/sersoft-gmbh/color-components.git", from: "1.0.0"),
```

Or add it via Xcode (as of Xcode 11).

## Usage

Currently, the main type is the ``ImageColorsCalculator``.
With it, you can for example calculate the most prominent color using ``ImageColorsCalculator/mostProminentColor(as:in:distanceAs:pixelLimit:colorLimit:)`` or an average color using ``ImageColorsCalculator/averageColor(in:)``. 
