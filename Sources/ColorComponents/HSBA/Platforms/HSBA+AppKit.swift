#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension NSColorSpace {
    public static var colorComponentsDefaultHSB: NSColorSpace { .colorComponentsDefaultRGB }
}

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension NSColor {
    @usableFromInline
    convenience init<Value: BinaryFloatingPoint>(_ hsb: HSB<Value>, alpha: Value, colorSpace: NSColorSpace) {
        if #available(macOS 10.12, *) {
            self.init(colorSpace: colorSpace,
                      hue: .init(hsb.hue),
                      saturation: .init(hsb.saturation),
                      brightness: .init(hsb.brightness),
                      alpha: .init(alpha))
        } else {
            self.init(RGB(hsb: hsb), alpha: alpha, colorSpace: colorSpace)
        }
    }

    @inlinable
    public convenience init<Value: BinaryFloatingPoint>(_ hsb: HSB<Value>,
                                                        colorSpace: NSColorSpace = .colorComponentsDefaultHSB) {
        self.init(hsb, alpha: 1, colorSpace: colorSpace)
    }

    @inlinable
    public convenience init<Value: BinaryFloatingPoint>(_ hsba: HSBA<Value>,
                                                        colorSpace: NSColorSpace = .colorComponentsDefaultHSB) {
        self.init(hsba.hsb, alpha: hsba.alpha, colorSpace: colorSpace)
    }

    @usableFromInline
    func _extractHSBA() -> HSBA<CGFloat> {
        var hsba = HSBA<CGFloat>(hue: 0, saturation: 0, brightness: 0, alpha: 1)
        _convertedToRGB().getHue(&hsba.hsb.hue,
                                 saturation: &hsba.hsb.saturation,
                                 brightness: &hsba.hsb.brightness,
                                 alpha: &hsba.alpha)
        return hsba
    }
}

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension HSB where Value: BinaryFloatingPoint {
    @inlinable
    public init(_ nsColor: NSColor) {
        self.init(nsColor._extractHSBA().hsb)
    }

    @inlinable
    public init?(exactly nsColor: NSColor) {
        self.init(exactly: nsColor._extractHSBA().hsb)
    }
}

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension HSBA where Value: BinaryFloatingPoint {
    @inlinable
    public init(_ nsColor: NSColor) {
        self.init(nsColor._extractHSBA())
    }

    @inlinable
    public init?(exactly nsColor: NSColor) {
        self.init(exactly: nsColor._extractHSBA())
    }
}
#endif
