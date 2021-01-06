#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension NSColorSpace {
    /// The default color space used by `BW` and `BWA` to create `NSColor`s when no color space was specified.
    /// This is currently equivalent to `NSColorSpace.deviceGray`.
    public static var colorComponentsDefaultGray: NSColorSpace { .deviceGray }
}

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension NSColor {
    @inlinable
    convenience init<Value: BinaryFloatingPoint>(_ bw: BW<Value>, alpha: Value, colorSpace: NSColorSpace) {
        self.init(colorSpace: colorSpace, components: [.init(bw.white), .init(alpha)])
    }

    /// Creates a new color using the given black/white components and color space.
    /// - Parameters:
    ///   - bw: The black/white components.
    ///   - colorSpace: The color space to use. Defaults to `NSColorSpace.colorComponentsDefaultGray`.
    @inlinable
    public convenience init<Value: BinaryFloatingPoint>(_ bw: BW<Value>, colorSpace: NSColorSpace = .colorComponentsDefaultGray) {
        self.init(bw, alpha: 1, colorSpace: colorSpace)
    }

    /// Creates a new color using the given black/white components with alpha channel and color space.
    /// - Parameters:
    ///   - bwa: The black/white components with alpha channel.
    ///   - colorSpace: The color space to use. Defaults to `NSColorSpace.colorComponentsDefaultGray`.
    @inlinable
    public convenience init<Value: BinaryFloatingPoint>(_ bwa: BWA<Value>, colorSpace: NSColorSpace = .colorComponentsDefaultGray) {
        self.init(bwa.bw, alpha: bwa.alpha, colorSpace: colorSpace)
    }

    /// Creates a new color using the given black/white components and color space.
    /// - Parameters:
    ///   - bw: The black/white components.
    ///   - colorSpace: The color space to use. Defaults to `NSColorSpace.colorComponentsDefaultGray`.
    @inlinable
    public convenience init<Value: BinaryInteger>(_ bw: BW<Value>, colorSpace: NSColorSpace = .colorComponentsDefaultGray) {
        self.init(BW<CGFloat>(bw), colorSpace: colorSpace)
    }

    /// Creates a new color using the given black/white components with alpha channel and color space.
    /// - Parameters:
    ///   - bwa: The black/white components with alpha channel.
    ///   - colorSpace: The color space to use. Defaults to `NSColorSpace.colorComponentsDefaultGray`.
    @inlinable
    public convenience init<Value: BinaryInteger>(_ bwa: BWA<Value>, colorSpace: NSColorSpace = .colorComponentsDefaultGray) {
        self.init(BWA<CGFloat>(bwa), colorSpace: colorSpace)
    }

    @usableFromInline
    func _extractBWA() -> BWA<CGFloat> {
        var allowedColorSpaces: Set<NSColorSpace> = [.genericGray, .deviceGray, .genericGamma22Gray]
        if #available(macOS 10.12, *) {
            allowedColorSpaces.insert(.extendedGenericGamma22Gray)
        }
        var bwa = BWA<CGFloat>(white: 0, alpha: 1)
        _requireColorSpace(in: allowedColorSpaces, convertingTo: .colorComponentsDefaultGray)
            .getWhite(&bwa.bw.white, alpha: &bwa.alpha)
        return bwa
    }
}

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension BW where Value: BinaryFloatingPoint {
    /// Creates new black/white components from the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to `NSColorSpace.colorComponentsDefaultGray`
    ///         if it is not in a known gray color space.
    @inlinable
    public init(_ nsColor: NSColor) {
        self.init(nsColor._extractBWA().bw)
    }

    /// Tries to create new black/white components that exactly
    /// match the components of the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to `NSColorSpace.colorComponentsDefaultGray`
    ///         if it is not in a known gray color space.
    /// - SeeAlso: `BW.init(exactly:)`
    @inlinable
    public init?(exactly nsColor: NSColor) {
        self.init(exactly: nsColor._extractBWA().bw)
    }
}

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension BW where Value: BinaryInteger {
    /// Creates new black/white components from the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to `NSColorSpace.colorComponentsDefaultGray`
    ///         if it is not in a known gray color space.
    @inlinable
    public init(_ nsColor: NSColor) {
        self.init(nsColor._extractBWA().bw)
    }

    /// Tries to create new black/white components that exactly
    /// match the components of the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to `NSColorSpace.colorComponentsDefaultGray`
    ///         if it is not in a known gray color space.
    /// - SeeAlso: `BW.init(exactly:)`
    @inlinable
    public init?(exactly nsColor: NSColor) {
        self.init(exactly: nsColor._extractBWA().bw)
    }
}

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension BWA where Value: BinaryFloatingPoint {
    /// Creates new black/white components with alpha channel from the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to `NSColorSpace.colorComponentsDefaultGray`
    ///         if it is not in a known gray color space.
    @inlinable
    public init(_ nsColor: NSColor) {
        self.init(nsColor._extractBWA())
    }

    /// Tries to create new black/white components with alpha channel
    /// that exactly match the components of the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to `NSColorSpace.colorComponentsDefaultGray`
    ///         if it is not in a known gray color space.
    /// - SeeAlso: `BWA.init(exactly:)`
    @inlinable
    public init?(exactly nsColor: NSColor) {
        self.init(exactly: nsColor._extractBWA())
    }
}

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension BWA where Value: BinaryInteger {
    /// Creates new black/white components with alpha channel from the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to `NSColorSpace.colorComponentsDefaultGray`
    ///         if it is not in a known gray color space.
    @inlinable
    public init(_ nsColor: NSColor) {
        self.init(nsColor._extractBWA())
    }

    /// Tries to create new black/white components with alpha channel
    /// that exactly match the components of the given color.
    /// - Parameter nsColor: The color to read the components from.
    /// - Note: This will convert the color to `NSColorSpace.colorComponentsDefaultGray`
    ///         if it is not in a known gray color space.
    /// - SeeAlso: `BWA.init(exactly:)`
    @inlinable
    public init?(exactly nsColor: NSColor) {
        self.init(exactly: nsColor._extractBWA())
    }
}
#endif
