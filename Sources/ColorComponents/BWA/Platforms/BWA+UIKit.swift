#if canImport(UIKit)
public import UIKit

@available(macOS, unavailable)
extension UIColor {
    @inlinable
    convenience init<Value: BinaryFloatingPoint>(_ bw: BW<Value>, alpha: Value) {
        self.init(white: .init(bw.white), alpha: .init(alpha))
    }

    /// Creates a new color using the given black/white components.
    /// - Parameter bw: The black/white components.
    @inlinable
    public convenience init<Value: BinaryFloatingPoint>(_ bw: BW<Value>) {
        self.init(bw, alpha: 1)
    }

    /// Creates a new color using the given black/white components with alpha channel.
    /// - Parameter bwa: The black/white components with alpha channel.
    @inlinable
    public convenience init<Value: BinaryFloatingPoint>(_ bwa: BWA<Value>) {
        self.init(bwa.bw, alpha: bwa.alpha)
    }

    /// Creates a new color using the given black/white components.
    /// - Parameter bw: The black/white components.
    @inlinable
    public convenience init<Value: BinaryInteger>(_ bw: BW<Value>) {
        self.init(BW<CGFloat>(bw))
    }

    /// Creates a new color using the given black/white components with alpha channel.
    /// - Parameter bwa: The black/white components with alpha channel.
    @inlinable
    public convenience init<Value: BinaryInteger>(_ bwa: BWA<Value>) {
        self.init(BWA<CGFloat>(bwa))
    }

    @usableFromInline
    func _extractBWA() -> (BWA<CGFloat>, isExact: Bool) {
        var bwa = BWA<CGFloat>(white: 0, alpha: 1)
#if hasFeature(StrictMemorySafety)
        let isExact = unsafe getWhite(&bwa.bw.white, alpha: &bwa.alpha)
#else
        let isExact = getWhite(&bwa.bw.white, alpha: &bwa.alpha)
#endif
        return (bwa, isExact)
    }
}

@available(macOS, unavailable)
extension BW where Value: BinaryFloatingPoint {
    /// Creates new black/white components from the given color.
    /// - Parameter uiColor: The color to read the components from.
    @inlinable
    public init(_ uiColor: UIColor) {
        self.init(uiColor._extractBWA().0.bw)
    }

    /// Tries to create new black/white components that exactly
    /// match the components of the given color.
    /// - Parameter uiColor: The color to read the components from.
    /// - SeeAlso: ``BW/init(exactly:)``
    @inlinable
    public init?(exactly uiColor: UIColor) {
        let (bwa, isExact) = uiColor._extractBWA()
        guard isExact else { return nil }
        self.init(exactly: bwa.bw)
    }
}

@available(macOS, unavailable)
extension BW where Value: BinaryInteger {
    /// Creates new black/white components from the given color.
    /// - Parameter uiColor: The color to read the components from.
    @inlinable
    public init(_ uiColor: UIColor) {
        self.init(uiColor._extractBWA().0.bw)
    }

    /// Tries to create new black/white components that exactly
    /// match the components of the given color.
    /// - Parameter uiColor: The color to read the components from.
    /// - SeeAlso: ``BW/init(exactly:)``
    @inlinable
    public init?(exactly uiColor: UIColor) {
        let (bwa, isExact) = uiColor._extractBWA()
        guard isExact else { return nil }
        self.init(exactly: bwa.bw)
    }
}

@available(macOS, unavailable)
extension BWA where Value: BinaryFloatingPoint {
    /// Creates new black/white components with alpha channel from the given color.
    /// - Parameter uiColor: The color to read the components from.
    @inlinable
    public init(_ uiColor: UIColor) {
        self.init(uiColor._extractBWA().0)
    }

    /// Tries to create new black/white components with alpha channel
    /// that exactly match the components of the given color.
    /// - Parameter uiColor: The color to read the components from.
    /// - SeeAlso: ``BWA/init(exactly:)``
    @inlinable
    public init?(exactly uiColor: UIColor) {
        let (bwa, isExact) = uiColor._extractBWA()
        guard isExact else { return nil }
        self.init(exactly: bwa)
    }
}

@available(macOS, unavailable)
extension BWA where Value: BinaryInteger {
    /// Creates new black/white components with alpha channel from the given color.
    /// - Parameter uiColor: The color to read the components from.
    @inlinable
    public init(_ uiColor: UIColor) {
        self.init(uiColor._extractBWA().0)
    }

    /// Tries to create new black/white components with alpha channel
    /// that exactly match the components of the given color.
    /// - Parameter uiColor: The color to read the components from.
    /// - SeeAlso: ``BWA/init(exactly:)``
    @inlinable
    public init?(exactly uiColor: UIColor) {
        let (bwa, isExact) = uiColor._extractBWA()
        guard isExact else { return nil }
        self.init(exactly: bwa)
    }
}
#endif
