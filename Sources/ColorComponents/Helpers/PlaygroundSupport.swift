//#if canImport(UIKit) || canImport(AppKit)
//typealias _PlaygroundColor = _PlatformColor
//#elseif canImport(CoreGraphics)
//typealias _PlaygroundColor = CGColor
//#else
//enum __PlaygroundColor {}
//typealias _PlaygroundColor = Optional<__PlaygroundColor>
//#endif
//
//protocol _BinaryIntegerColorComponentsPlaygroundSupport {
//    var _playgroundColor: _PlatformColor { get }
//}
//
//protocol _FloatingPointColorComponentsPlaygroundSupport {
//    var _playgroundColor: _PlatformColor { get }
//}
//
//#if !(canImport(UIKit) || canImport(AppKit)) && !canImport(CoreGraphics)
//extension _BinaryIntegerColorComponentsPlaygroundSupport {
//    var _playgroundColor: _PlatformColor { nil }
//}
//
//extension _FloatingPointColorComponentsPlaygroundSupport {
//    var _playgroundColor: _PlatformColor { nil }
//}
//#endif
