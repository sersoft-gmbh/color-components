#if canImport(UIKit)
import UIKit

extension UIColor {
    @inlinable
    convenience init<Value: BinaryFloatingPoint>(_ hsb: HSB<Value>, alpha: Value) {
        self.init(hue: .init(hsb.hue), saturation: .init(hsb.saturation), brightness: .init(hsb.brightness), alpha: .init(alpha))
    }

    @inlinable
    public convenience init<Value: BinaryFloatingPoint>(_ hsb: HSB<Value>) {
        self.init(hsb, alpha: 1)
    }

    @inlinable
    public convenience init<Value: BinaryFloatingPoint>(_ hsba: HSBA<Value>) {
        self.init(hsba.hsb, alpha: hsba.alpha)
    }

    @usableFromInline
    func _extractHSBA() -> (HSBA<CGFloat>, isExact: Bool) {
        var hsba = HSBA<CGFloat>(hue: 0, saturation: 0, brightness: 0, alpha: 1)
        let isExact = getHue(&hsba.hsb.hue,
                             saturation: &hsba.hsb.saturation,
                             brightness: &hsba.hsb.brightness,
                             alpha: &hsba.alpha)
        return (hsba, isExact)
    }
}

extension HSB where Value: BinaryFloatingPoint {
    @inlinable
    public init(_ uiColor: UIColor) {
        self.init(uiColor._extractHSBA().0.hsb)
    }

    @inlinable
    public init?(exactly uiColor: UIColor) {
        let (hsba, isExact) = uiColor._extractHSBA()
        guard isExact else { return nil }
        self.init(hsba.hsb)
    }
}

extension HSBA where Value: BinaryFloatingPoint {
    @inlinable
    public init(_ uiColor: UIColor) {
        self.init(uiColor._extractHSBA().0)
    }

    @inlinable
    public init?(exactly uiColor: UIColor) {
        let (hsba, isExact) = uiColor._extractHSBA()
        guard isExact else { return nil }
        self.init(hsba)
    }
}
#endif
