#if canImport(SwiftUI) && canImport(Combine) // Combine check seems to be necessary
import SwiftUI

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Color {
    @inlinable
    init<Value: BinaryFloatingPoint>(_ hsb: HSB<Value>, opacity: Value) {
        self.init(hue: .init(hsb.hue), saturation: .init(hsb.saturation), brightness: .init(hsb.brightness), opacity: .init(opacity))
    }

    @inlinable
    public init<Value: BinaryFloatingPoint>(_ hsb: HSB<Value>) {
        self.init(hsb, opacity: 1)
    }

    @inlinable
    public init<Value: BinaryFloatingPoint>(_ hsba: HSBA<Value>) {
        self.init(hsba.hsb, opacity: hsba.alpha)
    }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension HSB where Value: BinaryFloatingPoint {
    @inlinable
    public var color: Color {
        Color(hue: .init(hue), saturation: .init(saturation), brightness: .init(brightness), opacity: 1)
    }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension HSBA where Value: BinaryFloatingPoint {
    @inlinable
    public var color: Color {
        Color(hue: .init(hsb.hue),
              saturation: .init(hsb.saturation),
              brightness: .init(hsb.brightness),
              opacity: .init(alpha))
    }
}

#if canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst))
@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension HSB where Value: BinaryFloatingPoint {
    @inlinable
    public init(_ color: Color) {
        self.init(PlatformColor(color))
    }

    @inlinable
    public init?(exactly color: Color) {
        self.init(exactly: PlatformColor(color))
    }
}

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension HSBA where Value: BinaryFloatingPoint {
    @inlinable
    public init(_ color: Color) {
        self.init(PlatformColor(color))
    }

    @inlinable
    public init?(exactly color: Color) {
        self.init(exactly: PlatformColor(color))
    }
}
#elseif canImport(CoreGraphics)
import class CoreGraphics.CGColor
@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension HSB where Value: BinaryFloatingPoint {
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
extension HSBA where Value: BinaryFloatingPoint {
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
