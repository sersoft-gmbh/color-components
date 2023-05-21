#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension NSColorSpace {
    /// The default color space used by `HSL` and `HSLA` to create `NSColor`s when no color space was specified.
    /// This is currently equivalent to `NSColorSpace.colorComponentsDefaultRGB`.
    public static var colorComponentsDefaultHSL: NSColorSpace { .colorComponentsDefaultRGB }
}

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension NSColor {
    /// Creates a new color using the given HSL components and color space.
    /// - Parameters:
    ///   - hsl: The HSL components.
    ///   - colorSpace: The color space to use. Defaults to `NSColorSpace.colorComponentsDefaultHSL`.
    @inlinable
    public convenience init<Value: BinaryFloatingPoint>(_ hsl: HSL<Value>,
                                                        colorSpace: NSColorSpace = .colorComponentsDefaultHSL) {
        self.init(HSB(hsl: hsl), colorSpace: colorSpace)
    }

    /// Creates a new color using the given HSLA components and color space.
    /// - Parameters:
    ///   - hsba: The HSLA components.
    ///   - colorSpace: The color space to use. Defaults to `NSColorSpace.colorComponentsDefaultHSL`.
    @inlinable
    public convenience init<Value: BinaryFloatingPoint>(_ hsla: HSLA<Value>,
                                                        colorSpace: NSColorSpace = .colorComponentsDefaultHSL) {
        self.init(HSBA(hsla: hsla), colorSpace: colorSpace)
    }

    /// Creates a new color using the given HSL components and color space.
    /// - Parameters:
    ///   - hsb: The HSL components.
    ///   - colorSpace: The color space to use. Defaults to `NSColorSpace.colorComponentsDefaultHSL`.
    @inlinable
    public convenience init<Value: BinaryInteger>(_ hsl: HSL<Value>,
                                                  colorSpace: NSColorSpace = .colorComponentsDefaultHSL) {
        self.init(HSL<CGFloat>(hsl), colorSpace: colorSpace)
    }

    /// Creates a new color using the given HSLA components and color space.
    /// - Parameters:
    ///   - hsba: The HSLA components.
    ///   - colorSpace: The color space to use. Defaults to `NSColorSpace.colorComponentsDefaultHSL`.
    @inlinable
    public convenience init<Value: BinaryInteger>(_ hsla: HSLA<Value>,
                                                  colorSpace: NSColorSpace = .colorComponentsDefaultHSL) {
        self.init(HSLA<CGFloat>(hsla), colorSpace: colorSpace)
    }

    @usableFromInline
    func _extractHSLA() -> HSLA<CGFloat> {
        HSLA(hsba: _extractHSBA())
    }
}

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension HSL where Value: BinaryFloatingPoint {
    /// Creates new HSL components from the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to `NSColorSpace.colorComponentsDefaultHSL`
    ///         if it is not in a known HSL color space (which is the same as for RGB).
    @inlinable
    public init(_ nsColor: NSColor) {
        self.init(nsColor._extractHSLA().hsl)
    }

    /// Tries to create new HSL components that exactly match the components of the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to `NSColorSpace.colorComponentsDefaultHSL`
    ///         if it is not in a known HSL color space (which is the same as for RGB).
    /// - SeeAlso: `HSL.init(exactly:)`
    @inlinable
    public init?(exactly nsColor: NSColor) {
        self.init(exactly: nsColor._extractHSLA().hsl)
    }
}

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension HSL where Value: BinaryInteger {
    /// Creates new HSL components from the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to `NSColorSpace.colorComponentsDefaultHSL`
    ///         if it is not in a known HSL color space (which is the same as for RGB).
    @inlinable
    public init(_ nsColor: NSColor) {
        self.init(nsColor._extractHSLA().hsl)
    }

    /// Tries to create new HSL components that exactly match the components of the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to `NSColorSpace.colorComponentsDefaultHSL`
    ///         if it is not in a known HSL color space (which is the same as for RGB).
    /// - SeeAlso: `HSB.init(exactly:)`
    @inlinable
    public init?(exactly nsColor: NSColor) {
        self.init(exactly: nsColor._extractHSLA().hsl)
    }
}

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension HSLA where Value: BinaryFloatingPoint {
    /// Creates new HSLA components from the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to `NSColorSpace.colorComponentsDefaultHSL`
    ///         if it is not in a known HSL color space (which is the same as for RGB).
    @inlinable
    public init(_ nsColor: NSColor) {
        self.init(nsColor._extractHSLA())
    }

    /// Tries to create new HSLA components that exactly match the components of the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to `NSColorSpace.colorComponentsDefaultHSL`
    ///         if it is not in a known HSL color space (which is the same as for RGB).
    /// - SeeAlso: `HSLA.init(exactly:)`
    @inlinable
    public init?(exactly nsColor: NSColor) {
        self.init(exactly: nsColor._extractHSLA())
    }
}

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension HSLA where Value: BinaryInteger {
    /// Creates new HSLA components from the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to `NSColorSpace.colorComponentsDefaultHSL`
    ///         if it is not in a known HSL color space (which is the same as for RGB).
    @inlinable
    public init(_ nsColor: NSColor) {
        self.init(nsColor._extractHSLA())
    }

    /// Tries to create new HSLA components that exactly match the components of the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to `NSColorSpace.colorComponentsDefaultHSL`
    ///         if it is not in a known HSL color space (which is the same as for RGB).
    /// - SeeAlso: `HSLA.init(exactly:)`
    @inlinable
    public init?(exactly nsColor: NSColor) {
        self.init(exactly: nsColor._extractHSLA())
    }
}
#endif
