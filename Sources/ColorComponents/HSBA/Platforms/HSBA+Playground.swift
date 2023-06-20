extension HSB: _BinaryIntegerColorComponentsPlaygroundSupport where Value: BinaryInteger {
#if canImport(UIKit) || canImport(AppKit)
    var _playgroundColor: _PlaygroundColor { .init(self) }
#elseif canImport(CoreGraphics)
    var _playgroundColor: _PlaygroundColor { cgColor }
#endif
}

extension HSB: _FloatingPointColorComponentsPlaygroundSupport where Value: BinaryFloatingPoint {
#if canImport(UIKit) || canImport(AppKit)
    var _playgroundColor: _PlaygroundColor { .init(self) }
#elseif canImport(CoreGraphics)
    var _playgroundColor: _PlaygroundColor { cgColor }
#endif
}

extension HSBA: _BinaryIntegerColorComponentsPlaygroundSupport where Value: BinaryInteger {
#if canImport(UIKit) || canImport(AppKit)
    var _playgroundColor: _PlaygroundColor { .init(self) }
#elseif canImport(CoreGraphics)
    var _playgroundColor: _PlaygroundColor { cgColor }
#endif
}

extension HSBA: _FloatingPointColorComponentsPlaygroundSupport where Value: BinaryFloatingPoint {
#if canImport(UIKit) || canImport(AppKit)
    var _playgroundColor: _PlaygroundColor { .init(self) }
#elseif canImport(CoreGraphics)
    var _playgroundColor: _PlaygroundColor { cgColor }
#endif
}
