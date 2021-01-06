#if canImport(UIKit)
import UIKit

@available(macOS, unavailable)
extension UIColor {
    @inlinable
    convenience init<Value: BinaryFloatingPoint>(_ rgb: RGB<Value>, alpha: Value) {
        self.init(red: .init(rgb.red), green: .init(rgb.green), blue: .init(rgb.blue), alpha: .init(alpha))
    }

    /// Creates a new color using the given RGB components.
    /// - Parameter rgb: The RGB components.
    @inlinable
    public convenience init<Value: BinaryFloatingPoint>(_ rgb: RGB<Value>) {
        self.init(rgb, alpha: 1)
    }

    /// Creates a new color using the given RGBA components.
    /// - Parameter rgba: The RGBA components.
    @inlinable
    public convenience init<Value: BinaryFloatingPoint>(_ rgba: RGBA<Value>) {
        self.init(rgba.rgb, alpha: rgba.alpha)
    }

    /// Creates a new color using the given RGB components.
    /// - Parameter rgb: The RGB components.
    @inlinable
    public convenience init<Value: BinaryInteger>(_ rgb: RGB<Value>) {
        self.init(RGB<CGFloat>(rgb))
    }

    /// Creates a new color using the given RGBA components.
    /// - Parameter rgba: The RGBA components.
    @inlinable
    public convenience init<Value: BinaryInteger>(_ rgba: RGBA<Value>) {
        self.init(RGBA<CGFloat>(rgba))
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
    /// Creates new RGB components from the given color.
    /// - Parameter uiColor: The color to read the components from.
    @inlinable
    public init(_ uiColor: UIColor) {
        self.init(uiColor._extractRGBA().0.rgb)
    }

    /// Tries to create new RGB components that exactly match the components of the given color.
    /// - Parameter uiColor: The color to read the components from.
    /// - SeeAlso: `RGB.init(exactly:)`
    @inlinable
    public init?(exactly uiColor: UIColor) {
        let (rgba, isExact) = uiColor._extractRGBA()
        guard isExact else { return nil }
        self.init(exactly: rgba.rgb)
    }
}

@available(macOS, unavailable)
extension RGB where Value: BinaryInteger {
    /// Creates new RGB components from the given color.
    /// - Parameter uiColor: The color to read the components from.
    @inlinable
    public init(_ uiColor: UIColor) {
        self.init(uiColor._extractRGBA().0.rgb)
    }

    /// Tries to create new RGB components that exactly match the components of the given color.
    /// - Parameter uiColor: The color to read the components from.
    /// - SeeAlso: `RGB.init(exactly:)`
    @inlinable
    public init?(exactly uiColor: UIColor) {
        let (rgba, isExact) = uiColor._extractRGBA()
        guard isExact else { return nil }
        self.init(exactly: rgba.rgb)
    }
}

@available(macOS, unavailable)
extension RGBA where Value: BinaryFloatingPoint {
    /// Creates new RGBA components from the given color.
    /// - Parameter uiColor: The color to read the components from.
    @inlinable
    public init(_ uiColor: UIColor) {
        self.init(uiColor._extractRGBA().0)
    }

    /// Tries to create new RGBA components that exactly match the components of the given color.
    /// - Parameter uiColor: The color to read the components from.
    /// - SeeAlso: `RGBA.init(exactly:)`
    @inlinable
    public init?(exactly uiColor: UIColor) {
        let (rgba, isExact) = uiColor._extractRGBA()
        guard isExact else { return nil }
        self.init(exactly: rgba)
    }
}

@available(macOS, unavailable)
extension RGBA where Value: BinaryInteger {
    /// Creates new RGBA components from the given color.
    /// - Parameter uiColor: The color to read the components from.
    @inlinable
    public init(_ uiColor: UIColor) {
        self.init(uiColor._extractRGBA().0)
    }

    /// Tries to create new RGBA components that exactly match the components of the given color.
    /// - Parameter uiColor: The color to read the components from.
    /// - SeeAlso: `RGBA.init(exactly:)`
    @inlinable
    public init?(exactly uiColor: UIColor) {
        let (rgba, isExact) = uiColor._extractRGBA()
        guard isExact else { return nil }
        self.init(exactly: rgba)
    }
}
#endif
