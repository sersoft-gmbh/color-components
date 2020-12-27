# Swift Sysctl

[![GitHub release](https://img.shields.io/github/release/sersoft-gmbh/color-components.svg?style=flat)](https://github.com/sersoft-gmbh/color-components/releases/latest)
![Tests](https://github.com/sersoft-gmbh/color-components/workflows/Tests/badge.svg)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/cbb50391eb724c6ca5f4b251ff360c57)](https://www.codacy.com/gh/sersoft-gmbh/color-components/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=sersoft-gmbh/color-components&amp;utm_campaign=Badge_Grade)
[![codecov](https://codecov.io/gh/sersoft-gmbh/color-components/branch/main/graph/badge.svg?token=bCJR4QKdqc)](https://codecov.io/gh/sersoft-gmbh/color-components)
[![jazzy](https://raw.githubusercontent.com/sersoft-gmbh/color-components/gh-pages/badge.svg?sanitize=true)](https://sersoft-gmbh.github.io/color-components)

A color component calculation library written in Swift.

## Installation

Add the following dependency to your `Package.swift`:
```swift
.package(url: "https://github.com/sersoft-gmbh/color-components.git", from: "1.0.0"),
```

Or add it via Xcode (as of Xcode 11).

## Usage

There are currently three color component implementations included in `ColorComponents`:
-   `BW` & `BWA`
-   `HSB` & `HSBA`
-   `RGB` & `RGBA`

Each implementation is generic and supports both integer values (0 - 255) and floating point values (0.0 - 1.0). Also, each implementation allows converting between them.

If available, each implementation also provides conversion options from and to the platform native colors (e.g. `UIColor` on iOS, tvOS & watchOS and `NSColor` on macOS). `SwiftUI.Color` is also supported as of macOS 11, iOS 14, tvOS 14 and watchOS 7. Due to the lack of direct component accessors, `SwiftUI.Color` support goes through the aforementioned platform colors.

## Possible Features

While not yet integrated, the following features might provide added value and could make it into this package in the future:

-   CMYK color components.
-   Color space support.
-   More ways of converting between the components.

## Documentation

The API is documented using header doc. If you prefer to view the documentation as a webpage, there is an [online version](https://sersoft-gmbh.github.io/color-components) available for you.

## Contributing

If you find a bug / like to see a new feature in this package there are a few ways of helping out:

-   If you can fix the bug / implement the feature yourself please do and open a PR.
-   If you know how to code (which you probably do), please add a (failing) test and open a PR. We'll try to get your test green ASAP.
-   If you can do neither, then open an issue. While this might be the easiest way, it will likely take the longest for the bug to be fixed / feature to be implemented.

## License

See [LICENSE](./LICENSE) file.
