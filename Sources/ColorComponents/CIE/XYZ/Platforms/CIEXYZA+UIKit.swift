#if canImport(UIKit)
public import UIKit

@available(macOS, unavailable)
extension UIColor {
    @inlinable
    convenience init<Value: BinaryFloatingPoint>(_ cieXYZ: CIE.XYZ<Value>, alpha: Value) {
        self.init(RGB<Value>(cieXYZ: cieXYZ), alpha: alpha)
    }

    /// Creates a new color using the given CIE.XYZ components.
    /// - Parameter cieXYZ: The CIE.XYZ components.
    @inlinable
    public convenience init<Value: BinaryFloatingPoint>(_ cieXYZ: CIE.XYZ<Value>) {
        self.init(cieXYZ, alpha: 1)
    }

    /// Creates a new color using the given CIE.XYZA components.
    /// - Parameter cieXYZA: The CIE.XYZA components.
    @inlinable
    public convenience init<Value: BinaryFloatingPoint>(_ cieXYZA: CIE.XYZA<Value>) {
        self.init(cieXYZA.xyz, alpha: cieXYZA.alpha)
    }

    /// Creates a new color using the given CIE.XYZ components.
    /// - Parameter cieXYZ: The CIE.XYZ components.
    @inlinable
    public convenience init<Value: BinaryInteger>(_ cieXYZ: CIE.XYZ<Value>) {
        self.init(CIE.XYZ<CGFloat>(cieXYZ))
    }

    /// Creates a new color using the given CIE.XYZA components.
    /// - Parameter cieXYZA: The CIE.XYZA components.
    @inlinable
    public convenience init<Value: BinaryInteger>(_ cieXYZA: CIE.XYZA<Value>) {
        self.init(CIE.XYZA<CGFloat>(cieXYZA))
    }

    @usableFromInline
    func _extractCIEXYZA() -> (CIE.XYZA<CGFloat>, isExact: Bool) {
        let (rgba, isExact) = _extractRGBA()
        return (.init(rgba: rgba), isExact)
    }
}

@available(macOS, unavailable)
extension CIE.XYZ where Value: BinaryFloatingPoint {
    /// Creates new CIE.XYZ components from the given color.
    /// - Parameter uiColor: The color to read the components from.
    @inlinable
    public init(_ uiColor: UIColor) {
        self.init(uiColor._extractCIEXYZA().0.xyz)
    }

    /// Tries to create new CIE.XYZ components that exactly match the components of the given color.
    /// - Parameter uiColor: The color to read the components from.
    /// - SeeAlso: ``CIE/XYZ/init(exactly:)``
    @inlinable
    public init?(exactly uiColor: UIColor) {
        let (cieXYZA, isExact) = uiColor._extractCIEXYZA()
        guard isExact else { return nil }
        self.init(exactly: cieXYZA.xyz)
    }
}

@available(macOS, unavailable)
extension CIE.XYZ where Value: BinaryInteger {
    /// Creates new CIE.XYZ components from the given color.
    /// - Parameter uiColor: The color to read the components from.
    @inlinable
    public init(_ uiColor: UIColor) {
        self.init(uiColor._extractCIEXYZA().0.xyz)
    }

    /// Tries to create new CIE.XYZ components that exactly match the components of the given color.
    /// - Parameter uiColor: The color to read the components from.
    /// - SeeAlso: ``CIE/XYZ/init(exactly:)``
    @inlinable
    public init?(exactly uiColor: UIColor) {
        let (cieXYZA, isExact) = uiColor._extractCIEXYZA()
        guard isExact else { return nil }
        self.init(exactly: cieXYZA.xyz)
    }
}

@available(macOS, unavailable)
extension CIE.XYZA where Value: BinaryFloatingPoint {
    /// Creates new CIE.XYZA components from the given color.
    /// - Parameter uiColor: The color to read the components from.
    @inlinable
    public init(_ uiColor: UIColor) {
        self.init(uiColor._extractCIEXYZA().0)
    }

    /// Tries to create new CIE.XYZA components that exactly match the components of the given color.
    /// - Parameter uiColor: The color to read the components from.
    /// - SeeAlso: ``CIE/XYZA/init(exactly:)``
    @inlinable
    public init?(exactly uiColor: UIColor) {
        let (cieXYZA, isExact) = uiColor._extractCIEXYZA()
        guard isExact else { return nil }
        self.init(exactly: cieXYZA)
    }
}

@available(macOS, unavailable)
extension CIE.XYZA where Value: BinaryInteger {
    /// Creates new CIE.XYZA components from the given color.
    /// - Parameter uiColor: The color to read the components from.
    @inlinable
    public init(_ uiColor: UIColor) {
        self.init(uiColor._extractCIEXYZA().0)
    }

    /// Tries to create new CIE.XYZA components that exactly match the components of the given color.
    /// - Parameter uiColor: The color to read the components from.
    /// - SeeAlso: ``CIE/XYZA/init(exactly:)``
    @inlinable
    public init?(exactly uiColor: UIColor) {
        let (cieXYZA, isExact) = uiColor._extractCIEXYZA()
        guard isExact else { return nil }
        self.init(exactly: cieXYZA)
    }
}
#endif
