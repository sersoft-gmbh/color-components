extension HSL: _BinaryIntegerColorComponentsPlaygroundSupport where Value: BinaryInteger {
#if canImport(UIKit) || canImport(AppKit)
    var _playgroundColor: _PlaygroundColor { .init(self) }
#elseif canImport(CoreGraphics)
    var _playgroundColor: _PlaygroundColor { cgColor }
#endif
}

extension HSL: _FloatingPointColorComponentsPlaygroundSupport where Value: BinaryFloatingPoint {
#if canImport(UIKit) || canImport(AppKit)
    var _playgroundColor: _PlaygroundColor { .init(self) }
#elseif canImport(CoreGraphics)
    var _playgroundColor: _PlaygroundColor { cgColor }
#endif
}

extension HSLA: _BinaryIntegerColorComponentsPlaygroundSupport where Value: BinaryInteger {
#if canImport(UIKit) || canImport(AppKit)
    var _playgroundColor: _PlaygroundColor { .init(self) }
#elseif canImport(CoreGraphics)
    var _playgroundColor: _PlaygroundColor { cgColor }
#endif
}

extension HSLA: _FloatingPointColorComponentsPlaygroundSupport where Value: BinaryFloatingPoint {
#if canImport(UIKit) || canImport(AppKit)
    var _playgroundColor: _PlaygroundColor { .init(self) }
#elseif canImport(CoreGraphics)
    var _playgroundColor: _PlaygroundColor { cgColor }
#endif
}
