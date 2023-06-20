extension RGB: _BinaryIntegerColorComponentsPlaygroundSupport where Value: BinaryInteger {
#if canImport(UIKit) || canImport(AppKit)
    var _playgroundColor: _PlaygroundColor { .init(self) }
#elseif canImport(CoreGraphics)
    var _playgroundColor: _PlaygroundColor { cgColor }
#endif
}

extension RGB: _FloatingPointColorComponentsPlaygroundSupport where Value: BinaryFloatingPoint {
#if canImport(UIKit) || canImport(AppKit)
    var _playgroundColor: _PlaygroundColor { .init(self) }
#elseif canImport(CoreGraphics)
    var _playgroundColor: _PlaygroundColor { cgColor }
#endif
}

extension RGBA: _BinaryIntegerColorComponentsPlaygroundSupport where Value: BinaryInteger {
#if canImport(UIKit) || canImport(AppKit)
    var _playgroundColor: _PlaygroundColor { .init(self) }
#elseif canImport(CoreGraphics)
    var _playgroundColor: _PlaygroundColor { cgColor }
#endif
}

extension RGBA: _FloatingPointColorComponentsPlaygroundSupport where Value: BinaryFloatingPoint {
#if canImport(UIKit) || canImport(AppKit)
    var _playgroundColor: _PlaygroundColor { .init(self) }
#elseif canImport(CoreGraphics)
    var _playgroundColor: _PlaygroundColor { cgColor }
#endif
}
