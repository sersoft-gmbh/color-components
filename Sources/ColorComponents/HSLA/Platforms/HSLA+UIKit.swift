#if canImport(UIKit)
public import UIKit

@available(macOS, unavailable)
extension UIColor {
    /// Creates a new color using the given HSL components.
    /// - Parameter hsl: The HSL components.
    @inlinable
    public convenience init<Value: BinaryFloatingPoint>(_ hsl: HSL<Value>) {
        self.init(HSB(hsl: hsl))
    }

    /// Creates a new color using the given HSLA components.
    /// - Parameter bwa: The HSLA components.
    @inlinable
    public convenience init<Value: BinaryFloatingPoint>(_ hsla: HSLA<Value>) {
        self.init(HSBA(hsla: hsla))
    }

    /// Creates a new color using the given HSL components.
    /// - Parameter hsl: The HSL components.
    @inlinable
    public convenience init<Value: BinaryInteger>(_ hsl: HSL<Value>) {
        self.init(HSL<CGFloat>(hsl))
    }

    /// Creates a new color using the given HSLA components.
    /// - Parameter bwa: The HSLA components.
    @inlinable
    public convenience init<Value: BinaryInteger>(_ hsla: HSLA<Value>) {
        self.init(HSLA<CGFloat>(hsla))
    }

    @usableFromInline
    func _extractHSLA() -> (HSLA<CGFloat>, isExact: Bool) {
        let (hsba, isExact) = _extractHSBA()
        return (HSLA(hsba: hsba), isExact)
    }
}

@available(macOS, unavailable)
extension HSL where Value: BinaryFloatingPoint {
    /// Creates new HSL components from the given color.
    /// - Parameter uiColor: The color to read the components from.
    @inlinable
    public init(_ uiColor: UIColor) {
        self.init(uiColor._extractHSLA().0.hsl)
    }

    /// Tries to create new HSL components that exactly match the components of the given color.
    /// - Parameter uiColor: The color to read the components from.
    /// - SeeAlso: ``HSL/init(exactly:)``
    @inlinable
    public init?(exactly uiColor: UIColor) {
        let (hsla, isExact) = uiColor._extractHSLA()
        guard isExact else { return nil }
        self.init(exactly: hsla.hsl)
    }
}

@available(macOS, unavailable)
extension HSL where Value: BinaryInteger {
    /// Creates new HSL components from the given color.
    /// - Parameter uiColor: The color to read the components from.
    @inlinable
    public init(_ uiColor: UIColor) {
        self.init(uiColor._extractHSLA().0.hsl)
    }

    /// Tries to create new HSL components that exactly match the components of the given color.
    /// - Parameter uiColor: The color to read the components from.
    /// - SeeAlso: ``HSL/init(exactly:)``
    @inlinable
    public init?(exactly uiColor: UIColor) {
        let (hsla, isExact) = uiColor._extractHSLA()
        guard isExact else { return nil }
        self.init(exactly: hsla.hsl)
    }
}

@available(macOS, unavailable)
extension HSLA where Value: BinaryFloatingPoint {
    /// Creates new HSLA components from the given color.
    /// - Parameter uiColor: The color to read the components from.
    @inlinable
    public init(_ uiColor: UIColor) {
        self.init(uiColor._extractHSLA().0)
    }

    /// Tries to create new HSLA components that exactly match the components of the given color.
    /// - Parameter uiColor: The color to read the components from.
    /// - SeeAlso: ``HSLA/init(exactly:)``
    @inlinable
    public init?(exactly uiColor: UIColor) {
        let (hsla, isExact) = uiColor._extractHSLA()
        guard isExact else { return nil }
        self.init(exactly: hsla)
    }
}

@available(macOS, unavailable)
extension HSLA where Value: BinaryInteger {
    /// Creates new HSLA components from the given color.
    /// - Parameter uiColor: The color to read the components from.
    @inlinable
    public init(_ uiColor: UIColor) {
        self.init(uiColor._extractHSLA().0)
    }

    /// Tries to create new HSLA components that exactly match the components of the given color.
    /// - Parameter uiColor: The color to read the components from.
    /// - SeeAlso: ``HSLA/init(exactly:)``
    @inlinable
    public init?(exactly uiColor: UIColor) {
        let (hsla, isExact) = uiColor._extractHSLA()
        guard isExact else { return nil }
        self.init(exactly: hsla)
    }
}
#endif
