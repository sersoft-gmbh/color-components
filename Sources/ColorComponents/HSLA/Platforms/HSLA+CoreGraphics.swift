#if canImport(CoreGraphics)
public import CoreGraphics

extension HSL where Value: BinaryFloatingPoint {
    /// The `CGColor` that corresponds to these color components.
    @available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
    @inlinable
    public var cgColor: CGColor { RGB(hsl: self).cgColor }

    /// Creates new HSL components from the given color.
    /// - Parameter cgColor: The color to read the components from.
    /// - Note: This will convert the color to the `kCGColorSpaceGenericRGB` color space if necessary.
    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init(_ cgColor: CGColor) {
        self.init(rgb: RGB(cgColor))
    }

    /// Tries to create new HSL components that exactly
    /// match the components of the given color.
    /// - Parameter cgColor: The color to read the components from.
    /// - Note: This will convert the color to the `kCGColorSpaceGenericRGB` color space if necessary.
    /// - SeeAlso: ``HSL/init(exactly:)``
    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init?(exactly cgColor: CGColor) {
        guard let rgb = RGB<Value>(exactly: cgColor) else { return nil }
        self.init(rgb: rgb)
    }
}

extension HSL where Value: BinaryInteger {
    /// The `CGColor` that corresponds to these color components.
    @available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
    @inlinable
    public var cgColor: CGColor { HSL<CGFloat>(self).cgColor }

    /// Creates new HSL components from the given color.
    /// - Parameter cgColor: The color to read the components from.
    /// - Note: This will convert the color to the `kCGColorSpaceGenericRGB` color space if necessary.
    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init(_ cgColor: CGColor) {
        self.init(rgb: RGB(cgColor))
    }

    /// Tries to create new HSL components that exactly
    /// match the components of the given color.
    /// - Parameter cgColor: The color to read the components from.
    /// - Note: This will convert the color to the `kCGColorSpaceGenericRGB` color space if necessary.
    /// - SeeAlso: ``HSL/init(exactly:)``
    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init?(exactly cgColor: CGColor) {
        guard let rgb = RGB<Value>(exactly: cgColor) else { return nil }
        self.init(rgb: rgb)
    }
}

extension HSLA where Value: BinaryFloatingPoint {
    /// The `CGColor` that corresponds to these color components.
    @available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
    @inlinable
    public var cgColor: CGColor { RGBA(hsla: self).cgColor }

    /// Creates new HSLA components from the given color.
    /// - Parameter cgColor: The color to read the components from.
    /// - Note: This will convert the color to the `kCGColorSpaceGenericRGB` color space if necessary.
    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init(_ cgColor: CGColor) {
        self.init(rgba: RGBA(cgColor))
    }

    /// Tries to create new HSL components that exactly match the components of the given color.
    /// - Parameter cgColor: The color to read the components from.
    /// - Note: This will convert the color to the `kCGColorSpaceGenericRGB` color space if necessary.
    /// - SeeAlso: ``HSLA/init(exactly:)``
    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init?(exactly cgColor: CGColor) {
        guard let rgba = RGBA<Value>(exactly: cgColor) else { return nil }
        self.init(rgba: rgba)
    }
}

extension HSLA where Value: BinaryInteger {
    /// The `CGColor` that corresponds to these color components.
    @available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
    @inlinable
    public var cgColor: CGColor { HSLA<CGFloat>(self).cgColor }

    /// Creates new HSLA components from the given color.
    /// - Parameter cgColor: The color to read the components from.
    /// - Note: This will convert the color to the `kCGColorSpaceGenericRGB` color space if necessary.
    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init(_ cgColor: CGColor) {
        self.init(rgba: RGBA(cgColor))
    }

    /// Tries to create new HSL components that exactly match the components of the given color.
    /// - Parameter cgColor: The color to read the components from.
    /// - Note: This will convert the color to the `kCGColorSpaceGenericRGB` color space if necessary.
    /// - SeeAlso: ``HSLA/init(exactly:)``
    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init?(exactly cgColor: CGColor) {
        guard let rgba = RGBA<Value>(exactly: cgColor) else { return nil }
        self.init(rgba: rgba)
    }
}
#endif
