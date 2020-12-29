#if canImport(SwiftUI) && canImport(Combine) // Combine check seems to be necessary
import SwiftUI

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Color {
    @inlinable
    init<Value: BinaryFloatingPoint>(_ rgb: RGB<Value>, opacity: Value) {
        self.init(red: .init(rgb.red), green: .init(rgb.green), blue: .init(rgb.blue), opacity: .init(opacity))
    }

    @inlinable
    public init<Value: BinaryFloatingPoint>(_ rgb: RGB<Value>) {
        self.init(rgb, opacity: 1)
    }

    @inlinable
    public init<Value: BinaryFloatingPoint>(_ rgba: RGBA<Value>) {
        self.init(rgba.rgb, opacity: rgba.alpha)
    }
}

#if canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst))
@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension RGB where Value: BinaryFloatingPoint {
    @inlinable
    public init(_ color: Color) {
        self.init(_PlatformColor(color))
    }

    @inlinable
    public init?(exactly color: Color) {
        self.init(exactly: _PlatformColor(color))
    }
}

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension RGBA where Value: BinaryFloatingPoint {
    @inlinable
    public init(_ color: Color) {
        self.init(_PlatformColor(color))
    }

    @inlinable
    public init?(exactly color: Color) {
        self.init(exactly: _PlatformColor(color))
    }
}
#elseif canImport(CoreGraphics)
import class CoreGraphics.CGColor
@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension RGB where Value: BinaryFloatingPoint {
    @inlinable
    public init?(_ color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(cgColor)
    }

    @inlinable
    public init?(exactly color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(exactly: cgColor)
    }
}

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension RGBA where Value: BinaryFloatingPoint {
    @inlinable
    public init?(_ color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(cgColor)
    }

    @inlinable
    public init?(exactly color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(exactly: cgColor)
    }
}
#endif
#endif
