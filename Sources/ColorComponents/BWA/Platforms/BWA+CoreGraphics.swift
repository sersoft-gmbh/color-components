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
    @available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
    @inlinable
    public var cgColor: CGColor {
        CGColor(gray: .init(white), alpha: 1)
    }

    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init(_ cgColor: CGColor) {
        self.init(cgColor._extractBW())
    }

    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init?(exactly cgColor: CGColor) {
        self.init(exactly: cgColor._extractBW())
    }
}

extension BWA where Value: BinaryFloatingPoint {
    @available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
    @inlinable
    public var cgColor: CGColor {
        CGColor(gray: .init(bw.white), alpha: .init(alpha))
    }

    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init(_ cgColor: CGColor) {
        self.init(cgColor._extractBWA())
    }

    @available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
    @inlinable
    public init?(exactly cgColor: CGColor) {
        self.init(exactly: cgColor._extractBWA())
    }
}
#endif
