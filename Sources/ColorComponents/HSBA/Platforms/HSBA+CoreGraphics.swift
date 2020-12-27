#if canImport(CoreGraphics)
import CoreGraphics

extension HSB where Value: BinaryFloatingPoint {
    @available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
    @inlinable
    public var cgColor: CGColor { RGB<Value>(hsb: self).cgColor }

    @inlinable
    public init?(_ cgColor: CGColor) {
        guard let rgb = RGB<Value>(cgColor) else { return nil }
        self.init(rgb: rgb)
    }

    @inlinable
    public init?(exactly cgColor: CGColor) {
        guard let rgb = RGB<Value>(exactly: cgColor) else { return nil }
        self.init(rgb: rgb)
    }
}

extension HSBA where Value: BinaryFloatingPoint {
    @available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
    @inlinable
    public var cgColor: CGColor { RGBA<Value>(hsba: self).cgColor }

    @inlinable
    public init?(_ cgColor: CGColor) {
        guard let rgba = RGBA<Value>(cgColor) else { return nil }
        self.init(rgba: rgba)
    }

    @inlinable
    public init?(exactly cgColor: CGColor) {
        guard let rgba = RGBA<Value>(exactly: cgColor) else { return nil }
        self.init(rgba: rgba)
    }
}
#endif
