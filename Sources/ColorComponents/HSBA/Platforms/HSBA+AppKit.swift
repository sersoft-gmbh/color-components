// The compiler check is needed due to a bug in Swift 6.0. Remove this as of 6.1.
#if compiler(>=6.0) && canImport(AppKit) && !targetEnvironment(macCatalyst)
public import AppKit

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension NSColorSpace {
    /// The default color space used by ``HSB`` and ``HSBA`` to create `NSColor`s when no color space was specified.
    /// This is currently equivalent to ``NSColorSpace/colorComponentsDefaultRGB``.
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

    /// Creates a new color using the given HSB components and color space.
    /// - Parameters:
    ///   - hsb: The HSB components.
    ///   - colorSpace: The color space to use. Defaults to ``NSColorSpace/colorComponentsDefaultHSB``.
    @inlinable
    public convenience init<Value: BinaryFloatingPoint>(_ hsb: HSB<Value>,
                                                        colorSpace: NSColorSpace = .colorComponentsDefaultHSB) {
        self.init(hsb, alpha: 1, colorSpace: colorSpace)
    }

    /// Creates a new color using the given HSBA components and color space.
    /// - Parameters:
    ///   - hsba: The HSBA components.
    ///   - colorSpace: The color space to use. Defaults to ``NSColorSpace/colorComponentsDefaultHSB``.
    @inlinable
    public convenience init<Value: BinaryFloatingPoint>(_ hsba: HSBA<Value>,
                                                        colorSpace: NSColorSpace = .colorComponentsDefaultHSB) {
        self.init(hsba.hsb, alpha: hsba.alpha, colorSpace: colorSpace)
    }

    /// Creates a new color using the given HSB components and color space.
    /// - Parameters:
    ///   - hsb: The HSB components.
    ///   - colorSpace: The color space to use. Defaults to ``NSColorSpace/colorComponentsDefaultHSB``.
    @inlinable
    public convenience init<Value: BinaryInteger>(_ hsb: HSB<Value>,
                                                  colorSpace: NSColorSpace = .colorComponentsDefaultHSB) {
        self.init(HSB<CGFloat>(hsb), colorSpace: colorSpace)
    }

    /// Creates a new color using the given HSBA components and color space.
    /// - Parameters:
    ///   - hsba: The HSBA components.
    ///   - colorSpace: The color space to use. Defaults to ``NSColorSpace/colorComponentsDefaultHSB``.
    @inlinable
    public convenience init<Value: BinaryInteger>(_ hsba: HSBA<Value>,
                                                  colorSpace: NSColorSpace = .colorComponentsDefaultHSB) {
        self.init(HSBA<CGFloat>(hsba), colorSpace: colorSpace)
    }

    @usableFromInline
    func _extractHSBA() -> HSBA<CGFloat> {
        var hsba = HSBA<CGFloat>(hue: 0, saturation: 0, brightness: 0, alpha: 1)
#if compiler(>=6.2)
        unsafe _convertedToRGB().getHue(&hsba.hsb.hue,
                                        saturation: &hsba.hsb.saturation,
                                        brightness: &hsba.hsb.brightness,
                                        alpha: &hsba.alpha)
#else
        _convertedToRGB().getHue(&hsba.hsb.hue,
                                 saturation: &hsba.hsb.saturation,
                                 brightness: &hsba.hsb.brightness,
                                 alpha: &hsba.alpha)
#endif
        return hsba
    }
}

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension HSB where Value: BinaryFloatingPoint {
    /// Creates new HSB components from the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to ``NSColorSpace/colorComponentsDefaultHSB``
    ///         if it is not in a known HSB color space (which is the same as for RGB).
    @inlinable
    public init(_ nsColor: NSColor) {
        self.init(nsColor._extractHSBA().hsb)
    }

    /// Tries to create new HSB components that exactly match the components of the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to ``NSColorSpace/colorComponentsDefaultHSB``
    ///         if it is not in a known HSB color space (which is the same as for RGB).
    /// - SeeAlso: ``HSB/init(exactly:)``
    @inlinable
    public init?(exactly nsColor: NSColor) {
        self.init(exactly: nsColor._extractHSBA().hsb)
    }
}

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension HSB where Value: BinaryInteger {
    /// Creates new HSB components from the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to ``NSColorSpace/colorComponentsDefaultHSB``
    ///         if it is not in a known HSB color space (which is the same as for RGB).
    @inlinable
    public init(_ nsColor: NSColor) {
        self.init(nsColor._extractHSBA().hsb)
    }

    /// Tries to create new HSB components that exactly match the components of the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to ``NSColorSpace/colorComponentsDefaultHSB``
    ///         if it is not in a known HSB color space (which is the same as for RGB).
    /// - SeeAlso: ``HSB/init(exactly:)``
    @inlinable
    public init?(exactly nsColor: NSColor) {
        self.init(exactly: nsColor._extractHSBA().hsb)
    }
}

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension HSBA where Value: BinaryFloatingPoint {
    /// Creates new HSBA components from the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to ``NSColorSpace/colorComponentsDefaultHSB``
    ///         if it is not in a known HSB color space (which is the same as for RGB).
    @inlinable
    public init(_ nsColor: NSColor) {
        self.init(nsColor._extractHSBA())
    }

    /// Tries to create new HSBA components that exactly match the components of the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to ``NSColorSpace/colorComponentsDefaultHSB``
    ///         if it is not in a known HSB color space (which is the same as for RGB).
    /// - SeeAlso: ``HSBA/init(exactly:)``
    @inlinable
    public init?(exactly nsColor: NSColor) {
        self.init(exactly: nsColor._extractHSBA())
    }
}

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension HSBA where Value: BinaryInteger {
    /// Creates new HSBA components from the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to ``NSColorSpace/colorComponentsDefaultHSB``
    ///         if it is not in a known HSB color space (which is the same as for RGB).
    @inlinable
    public init(_ nsColor: NSColor) {
        self.init(nsColor._extractHSBA())
    }

    /// Tries to create new HSBA components that exactly match the components of the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to ``NSColorSpace/colorComponentsDefaultHSB``
    ///         if it is not in a known HSB color space (which is the same as for RGB).
    /// - SeeAlso: ``HSBA/init(exactly:)``
    @inlinable
    public init?(exactly nsColor: NSColor) {
        self.init(exactly: nsColor._extractHSBA())
    }
}
#endif
