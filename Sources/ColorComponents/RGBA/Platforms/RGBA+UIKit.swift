#if canImport(UIKit)
import UIKit

@available(macOS, unavailable)
extension UIColor {
    @inlinable
    convenience init<Value: BinaryFloatingPoint>(_ rgb: RGB<Value>, alpha: Value) {
        self.init(red: .init(rgb.red), green: .init(rgb.green), blue: .init(rgb.blue), alpha: .init(alpha))
    }

    @inlinable
    public convenience init<Value: BinaryFloatingPoint>(_ rgb: RGB<Value>) {
        self.init(rgb, alpha: 1)
    }

    @inlinable
    public convenience init<Value: BinaryFloatingPoint>(_ rgba: RGBA<Value>) {
        self.init(rgba.rgb, alpha: rgba.alpha)
    }

    @usableFromInline
    func _extractRGBA() -> (RGBA<CGFloat>, isExact: Bool) {
        var rgba = RGBA<CGFloat>(red: 0, green: 0, blue: 0, alpha: 1)
        let isExact = getRed(&rgba.rgb.red,
                             green: &rgba.rgb.green,
                             blue: &rgba.rgb.blue,
                             alpha: &rgba.alpha)
        return (rgba, isExact)
    }
}

@available(macOS, unavailable)
extension RGB where Value: BinaryFloatingPoint {
    @inlinable
    public init(_ uiColor: UIColor) {
        self.init(uiColor._extractRGBA().0.rgb)
    }

    @inlinable
    public init?(exactly uiColor: UIColor) {
        let (rgba, isExact) = uiColor._extractRGBA()
        guard isExact else { return nil }
        self.init(exactly: rgba.rgb)
    }
}

@available(macOS, unavailable)
extension RGBA where Value: BinaryFloatingPoint {
    @inlinable
    public init(_ uiColor: UIColor) {
        self.init(uiColor._extractRGBA().0)
    }

    @inlinable
    public init?(exactly uiColor: UIColor) {
        let (rgba, isExact) = uiColor._extractRGBA()
        guard isExact else { return nil }
        self.init(exactly: rgba)
    }
}
#endif
