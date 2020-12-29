#if canImport(CoreGraphics)
import CoreGraphics

extension HSB where Value: BinaryFloatingPoint {
    @available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
    @inlinable
    public var cgColor: CGColor { RGB(hsb: self).cgColor }

    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init(_ cgColor: CGColor) {
        self.init(rgb: RGB(cgColor))
    }

    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init?(exactly cgColor: CGColor) {
        guard let rgb = RGB<Value>(exactly: cgColor) else { return nil }
        self.init(rgb: rgb)
    }
}

extension HSBA where Value: BinaryFloatingPoint {
    @available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
    @inlinable
    public var cgColor: CGColor { RGBA(hsba: self).cgColor }

    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init(_ cgColor: CGColor) {
        self.init(rgba: RGBA(cgColor))
    }

    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init?(exactly cgColor: CGColor) {
        guard let rgba = RGBA<Value>(exactly: cgColor) else { return nil }
        self.init(rgba: rgba)
    }
}
#endif
