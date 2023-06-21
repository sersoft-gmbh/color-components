#if canImport(UIKit) || canImport(AppKit)
typealias _PlaygroundColor = _PlatformColor
#elseif canImport(CoreGraphics)
typealias _PlaygroundColor = CGColor
#else
typealias _PlaygroundColor = Optional<Never>
#endif

protocol _BinaryIntegerColorComponentsPlaygroundSupport {
    var _playgroundColor: _PlaygroundColor { get }
}

protocol _FloatingPointColorComponentsPlaygroundSupport {
    var _playgroundColor: _PlaygroundColor { get }
}

#if !(canImport(UIKit) || canImport(AppKit)) && !canImport(CoreGraphics)
extension _BinaryIntegerColorComponentsPlaygroundSupport {
    var _playgroundColor: _PlaygroundColor { nil }
}

extension _FloatingPointColorComponentsPlaygroundSupport {
    var _playgroundColor: _PlaygroundColor { nil }
}
#endif
