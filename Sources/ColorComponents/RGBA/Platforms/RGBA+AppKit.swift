#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension NSColorSpace {
    public static var colorComponentsDefaultRGB: NSColorSpace { .deviceRGB }
}

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension NSColor {
    @inlinable
    convenience init<Value: BinaryFloatingPoint>(_ rgb: RGB<Value>, alpha: Value, colorSpace: NSColorSpace) {
        self.init(colorSpace: colorSpace, components: [
            .init(rgb.red),
            .init(rgb.green),
            .init(rgb.blue),
            .init(alpha),
        ])
    }

    @inlinable
    public convenience init<Value: BinaryFloatingPoint>(_ rgb: RGB<Value>,
                                                        colorSpace: NSColorSpace = .colorComponentsDefaultRGB) {
        self.init(rgb, alpha: 1, colorSpace: colorSpace)
    }

    @inlinable
    public convenience init<Value: BinaryFloatingPoint>(_ rgba: RGBA<Value>,
                                                        colorSpace: NSColorSpace = .colorComponentsDefaultRGB) {
        self.init(rgba.rgb, alpha: rgba.alpha, colorSpace: colorSpace)
    }

    func _convertedToRGB() -> NSColor {
        var allowedColorSpaces: Set<NSColorSpace> = [.genericRGB, .deviceRGB, .adobeRGB1998, .sRGB]
        if #available(macOS 10.12, *) {
            allowedColorSpaces.insert(.extendedSRGB)
        }
        return _requireColorSpace(in: allowedColorSpaces, convertingTo: .colorComponentsDefaultRGB)
    }

    @usableFromInline
    func _extractRGBA() -> RGBA<CGFloat> {
        var rgba = RGBA<CGFloat>(red: 0, green: 0, blue: 0, alpha: 1)
        _convertedToRGB().getRed(&rgba.rgb.red,
                                 green: &rgba.rgb.green,
                                 blue: &rgba.rgb.blue,
                                 alpha: &rgba.alpha)
        return rgba
    }
}

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension RGB where Value: BinaryFloatingPoint {
    @inlinable
    public init(_ nsColor: NSColor) {
        self.init(nsColor._extractRGBA().rgb)
    }

    @inlinable
    public init?(exactly nsColor: NSColor) {
        self.init(exactly: nsColor._extractRGBA().rgb)
    }
}

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension RGBA where Value: BinaryFloatingPoint {
    @inlinable
    public init(_ nsColor: NSColor) {
        self.init(nsColor._extractRGBA())
    }

    @inlinable
    public init?(exactly nsColor: NSColor) {
        self.init(exactly: nsColor._extractRGBA())
    }
}
#endif
