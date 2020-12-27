#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

extension NSColor {
    @inlinable
    convenience init<Value: BinaryFloatingPoint>(_ rgb: RGB<Value>, alpha: Value) {
        self.init(red: .init(rgb.red), green: .init(rgb.green), blue: .init(rgb.blue), alpha: .init(alpha))
    }

    @inlinable
    public convenience init<Value: BinaryFloatingPoint>(_ rgb: RGB<Value>) {
        self.init(rgb, alpha: 1)
    }

    @inlinable
    public convenience init<Value: BinaryFloatingPoint>(_ rgba: RGBA<Value>) {
        self.init(rgba.rgb, alpha: rgba.alpha)
    }

    @usableFromInline
    func _extractRGBA() -> RGBA<CGFloat> {
        var rgba = RGBA<CGFloat>(red: 0, green: 0, blue: 0, alpha: 1)
        getRed(&rgba.rgb.red, green: &rgba.rgb.green, blue: &rgba.rgb.blue, alpha: &rgba.alpha)
        return rgba
    }
}

extension RGB where Value: BinaryFloatingPoint {
    @inlinable
    public init(_ nsColor: NSColor) {
        self.init(nsColor._extractRGBA().rgb)
    }

    @inlinable
    public init?(exactly nsColor: NSColor) {
        self.init(nsColor._extractRGBA().rgb)
    }
}

extension RGBA where Value: BinaryFloatingPoint {
    @inlinable
    public init(_ nsColor: NSColor) {
        self.init(nsColor._extractRGBA())
    }

    @inlinable
    public init?(exactly nsColor: NSColor) {
        self.init(nsColor._extractRGBA())
    }
}
#endif
