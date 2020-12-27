#if canImport(CoreGraphics)
import CoreGraphics

extension RGB where Value: BinaryFloatingPoint {
    @available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
    @inlinable
    public var cgColor: CGColor {
        CGColor(red: .init(red), green: .init(green), blue: .init(blue), alpha: 1)
    }

    @usableFromInline
    init?(_cgColor cgColor: CGColor, exact: Bool, alpha: UnsafeMutablePointer<CGFloat>? = nil) {
        let colorToReadFrom: CGColor?
        if #available(macOS 10.11, iOS 9, tvOS 9, watchOS 3, *) {
            let colorSpaceName: CFString
            if #available(macOS 10.12, iOS 10, tvOS 10, watchOS 4, *) {
                colorSpaceName = CGColorSpace.extendedSRGB
            } else {
                colorSpaceName = CGColorSpace.sRGB
            }
            colorToReadFrom = CGColorSpace(name: colorSpaceName).flatMap {
                cgColor.converted(to: $0, intent: .defaultIntent, options: nil)
            }
        } else {
            colorToReadFrom = cgColor.colorSpace?.name == CGColorSpace.sRGB ? cgColor : nil
        }

        guard let grayColor = colorToReadFrom,
              let components = grayColor.components,
              (3...4).contains(grayColor.numberOfComponents)
        else { return nil }
        alpha?.pointee = grayColor.alpha
        if exact {
            guard let rComp = Value(exactly: components[0]),
                  let gComp = Value(exactly: components[1]),
                  let bComp = Value(exactly: components[2])
            else { return nil }
            self.init(red: rComp, green: gComp, blue: bComp)
        } else {
            self.init(red: Value(components[0]),
                      green: Value(components[1]),
                      blue: Value(components[2]))
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

extension RGBA where Value: BinaryFloatingPoint {
    @available(macOS 10.5, iOS 13, tvOS 13, watchOS 6, *)
    @inlinable
    public var cgColor: CGColor {
        CGColor(red: .init(rgb.red), green: .init(rgb.green), blue: .init(rgb.blue), alpha: .init(alpha))
    }

    @inlinable
    public init?(_ cgColor: CGColor) {
        var alpha: CGFloat = 0
        guard let rgb = RGB<Value>(_cgColor: cgColor, exact: false, alpha: &alpha) else { return nil }
        self.init(rgb: rgb, alpha: .init(alpha))
    }

    @inlinable
    public init?(exactly cgColor: CGColor) {
        var alpha: CGFloat = 0
        guard let rgb = RGB<Value>(_cgColor: cgColor, exact: true, alpha: &alpha),
              let exactAlpha = Value(exactly: alpha)
        else { return nil }
        self.init(rgb: rgb, alpha: exactAlpha)
    }
}
#endif
