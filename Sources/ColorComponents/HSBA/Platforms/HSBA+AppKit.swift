#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

extension NSColor {
    @inlinable
    convenience init<Value: BinaryFloatingPoint>(_ hsb: HSB<Value>, alpha: Value) {
        self.init(hue: .init(hsb.hue), saturation: .init(hsb.saturation), brightness: .init(hsb.brightness), alpha: .init(alpha))
    }

    @inlinable
    public convenience init<Value: BinaryFloatingPoint>(_ hsb: HSB<Value>) {
        self.init(hsb, alpha: 1)
    }

    @inlinable
    public convenience init<Value: BinaryFloatingPoint>(_ hsba: HSBA<Value>) {
        self.init(hsba.hsb, alpha: hsba.alpha)
    }

    @usableFromInline
    func _extractHSBA() -> HSBA<CGFloat> {
        var hsba = HSBA<CGFloat>(hue: 0, saturation: 0, brightness: 0, alpha: 1)
        getHue(&hsba.hsb.hue,
               saturation: &hsba.hsb.saturation,
               brightness: &hsba.hsb.brightness,
               alpha: &hsba.alpha)
        return hsba
    }
}

extension HSB where Value: BinaryFloatingPoint {
    @inlinable
    public init(_ nsColor: NSColor) {
        self.init(nsColor._extractHSBA().hsb)
    }

    @inlinable
    public init?(exactly nsColor: NSColor) {
        self.init(nsColor._extractHSBA().hsb)
    }
}

extension HSBA where Value: BinaryFloatingPoint {
    @inlinable
    public init(_ nsColor: NSColor) {
        self.init(nsColor._extractHSBA())
    }

    @inlinable
    public init?(exactly nsColor: NSColor) {
        self.init(nsColor._extractHSBA())
    }
}
#endif
