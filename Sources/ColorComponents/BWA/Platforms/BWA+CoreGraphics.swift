#if canImport(CoreGraphics)
import CoreGraphics

extension BW where Value: BinaryFloatingPoint {
    @available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
    @inlinable
    public var cgColor: CGColor {
        CGColor(gray: .init(white), alpha: 1)
    }

    @usableFromInline
    init?(_cgColor cgColor: CGColor, exact: Bool, alpha: UnsafeMutablePointer<CGFloat>? = nil) {
        let colorToReadFrom: CGColor?
        if #available(macOS 10.11, iOS 9, tvOS 9, watchOS 3, *) {
            let colorSpaceName: CFString
            if #available(macOS 10.12, iOS 10, tvOS 10, watchOS 4, *) {
                colorSpaceName = CGColorSpace.linearGray
            } else {
                colorSpaceName = CGColorSpace.genericGrayGamma2_2
            }
            colorToReadFrom = CGColorSpace(name: colorSpaceName).flatMap {
                cgColor.converted(to: $0, intent: .defaultIntent, options: nil)
            }
        } else {
            colorToReadFrom = cgColor.colorSpace?.name == CGColorSpace.genericGrayGamma2_2 ? cgColor : nil
        }

        guard let grayColor = colorToReadFrom,
              let components = grayColor.components,
              (1...2).contains(grayColor.numberOfComponents)
        else { return nil }
        alpha?.pointee = grayColor.alpha
        if exact {
            guard let wComp = Value(exactly: components[0]) else { return nil }
            self.init(white: wComp)
        } else {
            self.init(white: Value(components[0]))
        }
    }

    @inlinable
    public init?(_ cgColor: CGColor) {
        self.init(_cgColor: cgColor, exact: false)
    }

    @inlinable
    public init?(exactly cgColor: CGColor) {
        self.init(_cgColor: cgColor, exact: true)
    }
}

extension BWA where Value: BinaryFloatingPoint {
    @available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
    @inlinable
    public var cgColor: CGColor {
        CGColor(gray: .init(bw.white), alpha: .init(alpha))
    }

    @inlinable
    public init?(_ cgColor: CGColor) {
        var alpha: CGFloat = 0
        guard let bw = BW<Value>(_cgColor: cgColor, exact: false, alpha: &alpha) else { return nil }
        self.init(bw: bw, alpha: .init(alpha))
    }

    @inlinable
    public init?(exactly cgColor: CGColor) {
        var alpha: CGFloat = 0
        guard let bw = BW<Value>(_cgColor: cgColor, exact: true, alpha: &alpha),
              let exactAlpha = Value(exactly: alpha)
        else { return nil }
        self.init(bw: bw, alpha: exactAlpha)
    }
}
#endif
