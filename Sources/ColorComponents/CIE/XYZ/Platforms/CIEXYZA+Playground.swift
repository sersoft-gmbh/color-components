extension CIE.XYZ: _BinaryIntegerColorComponentsPlaygroundSupport where Value: BinaryInteger {
#if canImport(UIKit) || canImport(AppKit)
    var _playgroundColor: _PlaygroundColor { .init(self) }
#elseif canImport(CoreGraphics)
    var _playgroundColor: _PlaygroundColor { cgColor }
#endif
}

extension CIE.XYZ: _FloatingPointColorComponentsPlaygroundSupport where Value: BinaryFloatingPoint {
#if canImport(UIKit) || canImport(AppKit)
    var _playgroundColor: _PlaygroundColor { .init(self) }
#elseif canImport(CoreGraphics)
    var _playgroundColor: _PlaygroundColor { cgColor }
#endif
}

extension CIE.XYZA: _BinaryIntegerColorComponentsPlaygroundSupport where Value: BinaryInteger {
#if canImport(UIKit) || canImport(AppKit)
    var _playgroundColor: _PlaygroundColor { .init(self) }
#elseif canImport(CoreGraphics)
    var _playgroundColor: _PlaygroundColor { cgColor }
#endif
}

extension CIE.XYZA: _FloatingPointColorComponentsPlaygroundSupport where Value: BinaryFloatingPoint {
#if canImport(UIKit) || canImport(AppKit)
    var _playgroundColor: _PlaygroundColor { .init(self) }
#elseif canImport(CoreGraphics)
    var _playgroundColor: _PlaygroundColor { cgColor }
#endif
}
