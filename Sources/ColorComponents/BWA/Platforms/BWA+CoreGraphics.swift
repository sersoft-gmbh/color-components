#if canImport(CoreGraphics)
import CoreGraphics

@available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
extension CGColor {
    @usableFromInline
    func _extractBW(alpha: UnsafeMutablePointer<CGFloat>? = nil) -> BW<CGFloat> {
        let color = _requireColorSpace(named: CGColorSpace.genericGray)
        let components = color._requireCompontens(in: 1...2)
        if let alpha = alpha {
            alpha.pointee = color.alpha
        }
        return .init(white: components[0])
    }

    @inlinable
    func _extractBWA() -> BWA<CGFloat> {
        var alpha: CGFloat = 1
        let bw = _extractBW(alpha: &alpha)
        return .init(bw: bw, alpha: alpha)
    }
}

extension BW where Value: BinaryFloatingPoint {
    /// The `CGColor` that corresponds to these color components.
    @available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
    @inlinable
    public var cgColor: CGColor {
        CGColor(gray: .init(white), alpha: 1)
    }


    /// Creates new black/white components from the given color.
    /// - Parameter cgColor: The color to read the components from.
    /// - Note: This will convert the color to the `kCGColorSpaceGenericGray` color space if necessary.
    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init(_ cgColor: CGColor) {
        self.init(cgColor._extractBW())
    }

    /// Tries to create new black/white components that exactly
    /// match the components of the given color.
    /// - Parameter cgColor: The color to read the components from.
    /// - Note: This will convert the color to the `kCGColorSpaceGenericGray` color space if necessary.
    /// - SeeAlso: `BW.init(exactly:)`
    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init?(exactly cgColor: CGColor) {
        self.init(exactly: cgColor._extractBW())
    }
}

extension BW where Value: BinaryInteger {
    /// The `CGColor` that corresponds to these color components.
    @available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
    @inlinable
    public var cgColor: CGColor {
        BW<CGFloat>(self).cgColor
    }


    /// Creates new black/white components from the given color.
    /// - Parameter cgColor: The color to read the components from.
    /// - Note: This will convert the color to the `kCGColorSpaceGenericGray` color space if necessary.
    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init(_ cgColor: CGColor) {
        self.init(cgColor._extractBW())
    }

    /// Tries to create new black/white components that exactly
    /// match the components of the given color.
    /// - Parameter cgColor: The color to read the components from.
    /// - Note: This will convert the color to the `kCGColorSpaceGenericGray` color space if necessary.
    /// - SeeAlso: `BW.init(exactly:)`
    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init?(exactly cgColor: CGColor) {
        self.init(exactly: cgColor._extractBW())
    }
}

extension BWA where Value: BinaryFloatingPoint {
    /// The `CGColor` that corresponds to these color components.
    @available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
    @inlinable
    public var cgColor: CGColor {
        CGColor(gray: .init(bw.white), alpha: .init(alpha))
    }


    /// Creates new black/white components with alpha channel from the given color.
    /// - Parameter cgColor: The color to read the components from.
    /// - Note: This will convert the color to the `kCGColorSpaceGenericGray` color space if necessary.
    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init(_ cgColor: CGColor) {
        self.init(cgColor._extractBWA())
    }

    /// Tries to create new black/white components with alpha channel that exactly
    /// match the components of the given color.
    /// - Parameter cgColor: The color to read the components from.
    /// - Note: This will convert the color to the `kCGColorSpaceGenericGray` color space if necessary.
    /// - SeeAlso: `BWA.init(exactly:)`
    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init?(exactly cgColor: CGColor) {
        self.init(exactly: cgColor._extractBWA())
    }
}

extension BWA where Value: BinaryInteger {
    /// The `CGColor` that corresponds to these color components.
    @available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
    @inlinable
    public var cgColor: CGColor {
        BWA<CGFloat>(self).cgColor
    }


    /// Creates new black/white components with alpha channel from the given color.
    /// - Parameter cgColor: The color to read the components from.
    /// - Note: This will convert the color to the `kCGColorSpaceGenericGray` color space if necessary.
    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init(_ cgColor: CGColor) {
        self.init(cgColor._extractBWA())
    }

    /// Tries to create new black/white components with alpha channel that exactly
    /// match the components of the given color.
    /// - Parameter cgColor: The color to read the components from.
    /// - Note: This will convert the color to the `kCGColorSpaceGenericGray` color space if necessary.
    /// - SeeAlso: `BWA.init(exactly:)`
    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init?(exactly cgColor: CGColor) {
        self.init(exactly: cgColor._extractBWA())
    }
}
#endif
