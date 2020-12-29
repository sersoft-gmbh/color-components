#if canImport(CoreGraphics)
import CoreGraphics

@available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
extension CGColor {
    @usableFromInline
    func _extractRGB(alpha: UnsafeMutablePointer<CGFloat>? = nil) -> RGB<CGFloat> {
        let color = _requireColorSpace(named: CGColorSpace.genericRGB)
        let components = color._requireCompontens(in: 3...4)
        if let alpha = alpha {
            alpha.pointee = color.alpha
        }
        return .init(red: components[0], green: components[1], blue: components[2])
    }

    @inlinable
    func _extractRGBA() -> RGBA<CGFloat> {
        var alpha: CGFloat = 1
        let rgb = _extractRGB(alpha: &alpha)
        return .init(rgb: rgb, alpha: alpha)
    }
}

extension RGB where Value: BinaryFloatingPoint {
    @available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
    @inlinable
    public var cgColor: CGColor {
        CGColor(red: .init(red), green: .init(green), blue: .init(blue), alpha: 1)
    }

    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init(_ cgColor: CGColor) {
        self.init(cgColor._extractRGB())
    }

    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init?(exactly cgColor: CGColor) {
        self.init(exactly: cgColor._extractRGB())
    }
}

extension RGBA where Value: BinaryFloatingPoint {
    @available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
    @inlinable
    public var cgColor: CGColor {
        CGColor(red: .init(rgb.red), green: .init(rgb.green), blue: .init(rgb.blue), alpha: .init(alpha))
    }

    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init(_ cgColor: CGColor) {
        self.init(cgColor._extractRGBA())
    }

    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init?(exactly cgColor: CGColor) {
        self.init(exactly: cgColor._extractRGBA())
    }
}
#endif
