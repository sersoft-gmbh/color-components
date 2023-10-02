#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension NSColorSpace {
    /// The default color space used by ``RGB`` and ``RGBA`` to create `NSColor`s when no color space was specified.
    /// This is currently equivalent to `NSColorSpace.deviceRGB`.
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

    /// Creates a new color using the given RGB components and color space.
    /// - Parameters:
    ///   - rgb: The RGB components.
    ///   - colorSpace: The color space to use. Defaults to ``NSColorSpace/colorComponentsDefaultRGB``.
    @inlinable
    public convenience init<Value: BinaryFloatingPoint>(_ rgb: RGB<Value>,
                                                        colorSpace: NSColorSpace = .colorComponentsDefaultRGB) {
        self.init(rgb, alpha: 1, colorSpace: colorSpace)
    }

    /// Creates a new color using the given RGBA components and color space.
    /// - Parameters:
    ///   - rgba: The RGBA components.
    ///   - colorSpace: The color space to use. Defaults to ``NSColorSpace/colorComponentsDefaultRGB``.
    @inlinable
    public convenience init<Value: BinaryFloatingPoint>(_ rgba: RGBA<Value>,
                                                        colorSpace: NSColorSpace = .colorComponentsDefaultRGB) {
        self.init(rgba.rgb, alpha: rgba.alpha, colorSpace: colorSpace)
    }

    /// Creates a new color using the given RGB components and color space.
    /// - Parameters:
    ///   - rgb: The RGB components.
    ///   - colorSpace: The color space to use. Defaults to ``NSColorSpace/colorComponentsDefaultRGB``.
    @inlinable
    public convenience init<Value: BinaryInteger>(_ rgb: RGB<Value>,
                                                  colorSpace: NSColorSpace = .colorComponentsDefaultRGB) {
        self.init(RGB<CGFloat>(rgb), colorSpace: colorSpace)
    }

    /// Creates a new color using the given RGBA components and color space.
    /// - Parameters:
    ///   - rgba: The RGBA components.
    ///   - colorSpace: The color space to use. Defaults to ``NSColorSpace/colorComponentsDefaultRGB``.
    @inlinable
    public convenience init<Value: BinaryInteger>(_ rgba: RGBA<Value>,
                                                  colorSpace: NSColorSpace = .colorComponentsDefaultRGB) {
        self.init(RGBA<CGFloat>(rgba), colorSpace: colorSpace)
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
    /// Creates new RGB components from the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to ``NSColorSpace/colorComponentsDefaultRGB``
    ///         if it is not in a known RGB color space.
    @inlinable
    public init(_ nsColor: NSColor) {
        self.init(nsColor._extractRGBA().rgb)
    }

    /// Tries to create new RGB components that exactly match the components of the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to ``NSColorSpace/colorComponentsDefaultRGB``
    ///         if it is not in a known RGB color space.
    /// - SeeAlso: ``RGB/init(exactly:)``
    @inlinable
    public init?(exactly nsColor: NSColor) {
        self.init(exactly: nsColor._extractRGBA().rgb)
    }
}

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension RGB where Value: BinaryInteger {
    /// Creates new RGB components from the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to ``NSColorSpace/colorComponentsDefaultRGB``
    ///         if it is not in a known RGB color space.
    @inlinable
    public init(_ nsColor: NSColor) {
        self.init(nsColor._extractRGBA().rgb)
    }

    /// Tries to create new RGB components that exactly match the components of the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to ``NSColorSpace/colorComponentsDefaultRGB``
    ///         if it is not in a known RGB color space.
    /// - SeeAlso: ``RGB/init(exactly:)``
    @inlinable
    public init?(exactly nsColor: NSColor) {
        self.init(exactly: nsColor._extractRGBA().rgb)
    }
}

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension RGBA where Value: BinaryFloatingPoint {
    /// Creates new RGBA components from the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to ``NSColorSpace/colorComponentsDefaultRGB``
    ///         if it is not in a known RGB color space.
    @inlinable
    public init(_ nsColor: NSColor) {
        self.init(nsColor._extractRGBA())
    }

    /// Tries to create new RGBA components that exactly match the components of the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to ``NSColorSpace/colorComponentsDefaultRGB``
    ///         if it is not in a known RGB color space.
    /// - SeeAlso: ``RGBA/init(exactly:)``
    @inlinable
    public init?(exactly nsColor: NSColor) {
        self.init(exactly: nsColor._extractRGBA())
    }
}

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension RGBA where Value: BinaryInteger {
    /// Creates new RGBA components from the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to ``NSColorSpace/colorComponentsDefaultRGB``
    ///         if it is not in a known RGB color space.
    @inlinable
    public init(_ nsColor: NSColor) {
        self.init(nsColor._extractRGBA())
    }

    /// Tries to create new RGBA components that exactly match the components of the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to ``NSColorSpace/colorComponentsDefaultRGB``
    ///         if it is not in a known RGB color space.
    /// - SeeAlso: ``RGBA/init(exactly:)``
    @inlinable
    public init?(exactly nsColor: NSColor) {
        self.init(exactly: nsColor._extractRGBA())
    }
}
#endif
