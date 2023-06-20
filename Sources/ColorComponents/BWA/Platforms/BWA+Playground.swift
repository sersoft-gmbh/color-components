extension BW: _BinaryIntegerColorComponentsPlaygroundSupport where Value: BinaryInteger {
#if canImport(UIKit) || canImport(AppKit)
    var _playgroundColor: _PlaygroundColor { .init(self) }
#elseif canImport(CoreGraphics)
    var _playgroundColor: _PlaygroundColor { cgColor }
#endif
}

extension BW: _FloatingPointColorComponentsPlaygroundSupport where Value: BinaryFloatingPoint {
#if canImport(UIKit) || canImport(AppKit)
    var _playgroundColor: _PlaygroundColor { .init(self) }
#elseif canImport(CoreGraphics)
    var _playgroundColor: _PlaygroundColor { cgColor }
#endif
}

extension BWA: _BinaryIntegerColorComponentsPlaygroundSupport where Value: BinaryInteger {
#if canImport(UIKit) || canImport(AppKit)
    var _playgroundColor: _PlaygroundColor { .init(self) }
#elseif canImport(CoreGraphics)
    var _playgroundColor: _PlaygroundColor { cgColor }
#endif
}

extension BWA: _FloatingPointColorComponentsPlaygroundSupport where Value: BinaryFloatingPoint {
#if canImport(UIKit) || canImport(AppKit)
    var _playgroundColor: _PlaygroundColor { .init(self) }
#elseif canImport(CoreGraphics)
    var _playgroundColor: _PlaygroundColor { cgColor }
#endif
}
