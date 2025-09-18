#if canImport(CoreGraphics)
public import CoreGraphics

@available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
extension CGColor {
    @usableFromInline
    func _extractCIEXYZ(alpha: UnsafeMutablePointer<CGFloat>? = nil) -> CIE.XYZ<CGFloat> {
        let color = _requireColorSpace(named: CGColorSpace.genericXYZ)
        let components = color._requireCompontens(in: 3...4)
#if hasFeature(StrictMemorySafety)
        if let alpha = unsafe alpha {
            unsafe alpha.pointee = color.alpha
        }
#else
        if let alpha {
            alpha.pointee = color.alpha
        }
#endif
        return .init(x: components[0], y: components[1], z: components[2])
    }

    @inlinable
    func _extractCIEXYZA() -> CIE.XYZA<CGFloat> {
        var alpha: CGFloat = 1
#if hasFeature(StrictMemorySafety)
        let xyz = unsafe _extractCIEXYZ(alpha: &alpha)
#else
        let xyz = _extractCIEXYZ(alpha: &alpha)
#endif
        return .init(xyz: xyz, alpha: alpha)
    }
}

@available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
extension CGColor {
    @usableFromInline
    static func _makeXYZA(x: CGFloat, y: CGFloat, z: CGFloat, alpha: CGFloat = 1) -> CGColor {
        if #available(macOS 11, *) {
#if hasFeature(StrictMemorySafety)
            return unsafe ._makeRequired(in: CGColorSpace.genericXYZ, components: [x, y, z, alpha])
#else
            return ._makeRequired(in: CGColorSpace.genericXYZ, components: [x, y, z, alpha])
#endif
        } else {
            return RGBA(cieXYZA: .init(x: x, y: y, z: z, alpha: alpha)).cgColor
        }
    }
}

extension CIE.XYZ where Value: BinaryFloatingPoint {
    /// The `CGColor` that corresponds to these color components.
    @available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
    @inlinable
    public var cgColor: CGColor {
        ._makeXYZA(x: .init(x), y: .init(y), z: .init(z))
    }

    /// Creates new CIE.XYZ components from the given color.
    /// - Parameter cgColor: The color to read the components from.
    /// - Note: This will convert the color to the `kCGColorSpaceGenericXYZ` color space if necessary.
    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init(_ cgColor: CGColor) {
        self.init(cgColor._extractCIEXYZ())
    }

    /// Tries to create new CIE.XYZ components that exactly
    /// match the components of the given color.
    /// - Parameter cgColor: The color to read the components from.
    /// - Note: This will convert the color to the `kCGColorSpaceGenericXYZ` color space if necessary.
    /// - SeeAlso: ``CIE/XYZ/init(exactly:)``
    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init?(exactly cgColor: CGColor) {
        self.init(exactly: cgColor._extractCIEXYZ())
    }
}

extension CIE.XYZ where Value: BinaryInteger {
    /// The `CGColor` that corresponds to these color components.
    @available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
    @inlinable
    public var cgColor: CGColor {
        CIE.XYZ<CGFloat>(self).cgColor
    }

    /// Creates new CIE.XYZ components from the given color.
    /// - Parameter cgColor: The color to read the components from.
    /// - Note: This will convert the color to the `kCGColorSpaceGenericXYZ` color space if necessary.
    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init(_ cgColor: CGColor) {
        self.init(cgColor._extractCIEXYZ())
    }

    /// Tries to create new CIE.XYZ components that exactly
    /// match the components of the given color.
    /// - Parameter cgColor: The color to read the components from.
    /// - Note: This will convert the color to the `kCGColorSpaceGenericXYZ` color space if necessary.
    /// - SeeAlso: ``CIE/XYZ/init(exactly:)``
    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init?(exactly cgColor: CGColor) {
        self.init(exactly: cgColor._extractCIEXYZ())
    }
}

extension CIE.XYZA where Value: BinaryFloatingPoint {
    /// The `CGColor` that corresponds to these color components.
    @available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
    @inlinable
    public var cgColor: CGColor {
        ._makeXYZA(x: .init(xyz.x), y: .init(xyz.y), z: .init(xyz.z), alpha: .init(alpha))
    }

    /// Creates new CIE.XYZA components from the given color.
    /// - Parameter cgColor: The color to read the components from.
    /// - Note: This will convert the color to the `kCGColorSpaceGenericXYZ` color space if necessary.
    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init(_ cgColor: CGColor) {
        self.init(cgColor._extractCIEXYZA())
    }

    /// Tries to create new CIE.XYZA components that exactly match the components of the given color.
    /// - Parameter cgColor: The color to read the components from.
    /// - Note: This will convert the color to the `kCGColorSpaceGenericXYZ` color space if necessary.
    /// - SeeAlso: ``RGBA/init(exactly:)``
    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init?(exactly cgColor: CGColor) {
        self.init(exactly: cgColor._extractCIEXYZA())
    }
}

extension CIE.XYZA where Value: BinaryInteger {
    /// The `CGColor` that corresponds to these color components.
    @available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
    @inlinable
    public var cgColor: CGColor {
        CIE.XYZA<CGFloat>(self).cgColor
    }

    /// Creates new CIE.XYZA components from the given color.
    /// - Parameter cgColor: The color to read the components from.
    /// - Note: This will convert the color to the `kCGColorSpaceGenericXYZ` color space if necessary.
    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init(_ cgColor: CGColor) {
        self.init(cgColor._extractCIEXYZA())
    }

    /// Tries to create new CIE.XYZA components that exactly match the components of the given color.
    /// - Parameter cgColor: The color to read the components from.
    /// - Note: This will convert the color to the `kCGColorSpaceGenericXYZ` color space if necessary.
    /// - SeeAlso: ``CIE/XYZA/init(exactly:)``
    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init?(exactly cgColor: CGColor) {
        self.init(exactly: cgColor._extractCIEXYZA())
    }
}
#endif
