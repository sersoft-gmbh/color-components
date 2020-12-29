#if canImport(UIKit)
import UIKit

@available(macOS, unavailable)
extension UIColor {
    @inlinable
    convenience init<Value: BinaryFloatingPoint>(_ hsb: HSB<Value>, alpha: Value) {
        self.init(hue: .init(hsb.hue), saturation: .init(hsb.saturation), brightness: .init(hsb.brightness), alpha: .init(alpha))
    }

    /// Creates a new color using the given HSB components.
    /// - Parameter hsb: The HSB components.
    @inlinable
    public convenience init<Value: BinaryFloatingPoint>(_ hsb: HSB<Value>) {
        self.init(hsb, alpha: 1)
    }

    /// Creates a new color using the given HSBA components.
    /// - Parameter bwa: The HSBA components.
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

@available(macOS, unavailable)
extension HSB where Value: BinaryFloatingPoint {
    /// Creates new HSB components from the given color.
    /// - Parameter uiColor: The color to read the components from.
    @inlinable
    public init(_ uiColor: UIColor) {
        self.init(uiColor._extractHSBA().0.hsb)
    }

    /// Tries to create new HSB components that exactly match the components of the given color.
    /// - Parameter uiColor: The color to read the components from.
    /// - SeeAlso: `HSB.init(exactly:)`
    @inlinable
    public init?(exactly uiColor: UIColor) {
        let (hsba, isExact) = uiColor._extractHSBA()
        guard isExact else { return nil }
        self.init(exactly: hsba.hsb)
    }
}

@available(macOS, unavailable)
extension HSBA where Value: BinaryFloatingPoint {
    /// Creates new HSBA components from the given color.
    /// - Parameter uiColor: The color to read the components from.
    @inlinable
    public init(_ uiColor: UIColor) {
        self.init(uiColor._extractHSBA().0)
    }

    /// Tries to create new HSBA components that exactly match the components of the given color.
    /// - Parameter uiColor: The color to read the components from.
    /// - SeeAlso: `HSBA.init(exactly:)`
    @inlinable
    public init?(exactly uiColor: UIColor) {
        let (hsba, isExact) = uiColor._extractHSBA()
        guard isExact else { return nil }
        self.init(exactly: hsba)
    }
}
#endif
