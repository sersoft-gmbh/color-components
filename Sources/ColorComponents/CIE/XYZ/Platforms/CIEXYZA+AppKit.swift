#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension NSColorSpace {
    /// The default color space used by `CIE.XYZ` and `CIE.XYZA` to create `NSColor`s when no color space was specified.
    /// This is currently equivalent to `NSColorSpace.colorComponentsDefaultRGB`.
    public static var colorComponentsDefaultCIEXYZ: NSColorSpace { .colorComponentsDefaultRGB }
}

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension NSColor {
    @inlinable
    convenience init<Value: BinaryFloatingPoint>(_ cieXYZ: CIE.XYZ<Value>, alpha: Value, colorSpace: NSColorSpace) {
        self.init(RGB(cieXYZ: cieXYZ), alpha: alpha, colorSpace: colorSpace)
    }

    /// Creates a new color using the given CIE.XYZ components and color space.
    /// - Parameters:
    ///   - cieXYZ: The CIE.XYZ components.
    ///   - colorSpace: The color space to use. Defaults to `NSColorSpace.colorComponentsDefaultCIEXYZ`.
    @inlinable
    public convenience init<Value: BinaryFloatingPoint>(_ cieXYZ: CIE.XYZ<Value>,
                                                        colorSpace: NSColorSpace = .colorComponentsDefaultCIEXYZ) {
        self.init(cieXYZ, alpha: 1, colorSpace: colorSpace)
    }

    /// Creates a new color using the given CIE.XYZA components and color space.
    /// - Parameters:
    ///   - cieXYZA: The CIE.XYZA components.
    ///   - colorSpace: The color space to use. Defaults to `NSColorSpace.colorComponentsDefaultCIEXYZ`.
    @inlinable
    public convenience init<Value: BinaryFloatingPoint>(_ cieXYZA: CIE.XYZA<Value>,
                                                        colorSpace: NSColorSpace = .colorComponentsDefaultCIEXYZ) {
        self.init(cieXYZA.xyz, alpha: cieXYZA.alpha, colorSpace: colorSpace)
    }

    /// Creates a new color using the given CIE.XYZ components and color space.
    /// - Parameters:
    ///   - cieXYZ: The CIE.XYZ components.
    ///   - colorSpace: The color space to use. Defaults to `NSColorSpace.colorComponentsDefaultCIEXYZ`.
    @inlinable
    public convenience init<Value: BinaryInteger>(_ cieXYZ: CIE.XYZ<Value>,
                                                  colorSpace: NSColorSpace = .colorComponentsDefaultCIEXYZ) {
        self.init(CIE.XYZ<CGFloat>(cieXYZ), colorSpace: colorSpace)
    }

    /// Creates a new color using the given CIE.XYZA components and color space.
    /// - Parameters:
    ///   - cieXYZA: The CIE.XYZA components.
    ///   - colorSpace: The color space to use. Defaults to `NSColorSpace.colorComponentsDefaultCIEXYZ`.
    @inlinable
    public convenience init<Value: BinaryInteger>(_ cieXYZA: CIE.XYZA<Value>,
                                                  colorSpace: NSColorSpace = .colorComponentsDefaultCIEXYZ) {
        self.init(CIE.XYZA<CGFloat>(cieXYZA), colorSpace: colorSpace)
    }

    func _convertedToCIEXYZ() -> NSColor {
        _convertedToRGB()
    }

    @usableFromInline
    func _extractCIEXYZA() -> CIE.XYZA<CGFloat> {
        .init(rgba: _extractRGBA())
    }
}

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension CIE.XYZ where Value: BinaryFloatingPoint {
    /// Creates new CIE.XYZ components from the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to `NSColorSpace.colorComponentsDefaultCIEXYZ`
    ///         if it is not in a known CIE.XYZ color space.
    @inlinable
    public init(_ nsColor: NSColor) {
        self.init(nsColor._extractCIEXYZA().xyz)
    }

    /// Tries to create new CIE.XYZ components that exactly match the components of the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to `NSColorSpace.colorComponentsDefaultCIEXYZ`
    ///         if it is not in a known CIE.XYZ color space.
    /// - SeeAlso: `CIE.XYZ.init(exactly:)`
    @inlinable
    public init?(exactly nsColor: NSColor) {
        self.init(exactly: nsColor._extractCIEXYZA().xyz)
    }
}

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension CIE.XYZ where Value: BinaryInteger {
    /// Creates new CIE.XYZ components from the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to `NSColorSpace.colorComponentsDefaultCIEXYZ`
    ///         if it is not in a known CIE.XYZ color space.
    @inlinable
    public init(_ nsColor: NSColor) {
        self.init(nsColor._extractCIEXYZA().xyz)
    }

    /// Tries to create new CIE.XYZ components that exactly match the components of the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to `NSColorSpace.colorComponentsDefaultCIEXYZ`
    ///         if it is not in a known CIE.XYZ color space.
    /// - SeeAlso: `RGB.init(exactly:)`
    @inlinable
    public init?(exactly nsColor: NSColor) {
        self.init(exactly: nsColor._extractCIEXYZA().xyz)
    }
}

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension CIE.XYZA where Value: BinaryFloatingPoint {
    /// Creates new CIE.XYZA components from the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to `NSColorSpace.colorComponentsDefaultCIEXYZ`
    ///         if it is not in a known CIE.XYZA color space.
    @inlinable
    public init(_ nsColor: NSColor) {
        self.init(nsColor._extractCIEXYZA())
    }

    /// Tries to create new CIE.XYZA components that exactly match the components of the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to `NSColorSpace.colorComponentsDefaultCIEXYZ`
    ///         if it is not in a known CIE.XYZ color space.
    /// - SeeAlso: `CIE.XYZA.init(exactly:)`
    @inlinable
    public init?(exactly nsColor: NSColor) {
        self.init(exactly: nsColor._extractCIEXYZA())
    }
}

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension CIE.XYZA where Value: BinaryInteger {
    /// Creates new CIE.XYZA components from the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to `NSColorSpace.colorComponentsDefaultCIEXYZ`
    ///         if it is not in a known CIE.XYZ color space.
    @inlinable
    public init(_ nsColor: NSColor) {
        self.init(nsColor._extractCIEXYZA())
    }

    /// Tries to create new CIE.XYZA components that exactly match the components of the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to `NSColorSpace.colorComponentsDefaultCIEXYZ`
    ///         if it is not in a known CIE.XYZ color space.
    /// - SeeAlso: `CIE.XYZA.init(exactly:)`
    @inlinable
    public init?(exactly nsColor: NSColor) {
        self.init(exactly: nsColor._extractCIEXYZA())
    }
}
#endif
