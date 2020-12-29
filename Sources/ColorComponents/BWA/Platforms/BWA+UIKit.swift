#if canImport(UIKit)
import UIKit

@available(macOS, unavailable)
extension UIColor {
    @inlinable
    convenience init<Value: BinaryFloatingPoint>(_ bw: BW<Value>, alpha: Value) {
        self.init(white: .init(bw.white), alpha: .init(alpha))
    }

    @inlinable
    public convenience init<Value: BinaryFloatingPoint>(_ bw: BW<Value>) {
        self.init(bw, alpha: 1)
    }

    @inlinable
    public convenience init<Value: BinaryFloatingPoint>(_ bwa: BWA<Value>) {
        self.init(bwa.bw, alpha: bwa.alpha)
    }

    @usableFromInline
    func _extractBWA() -> (BWA<CGFloat>, isExact: Bool) {
        var bwa = BWA<CGFloat>(white: 0, alpha: 1)
        let isExact = getWhite(&bwa.bw.white, alpha: &bwa.alpha)
        return (bwa, isExact)
    }
}

@available(macOS, unavailable)
extension BW where Value: BinaryFloatingPoint {
    @inlinable
    public init(_ uiColor: UIColor) {
        self.init(uiColor._extractBWA().0.bw)
    }

    @inlinable
    public init?(exactly uiColor: UIColor) {
        let (bwa, isExact) = uiColor._extractBWA()
        guard isExact else { return nil }
        self.init(exactly: bwa.bw)
    }
}

@available(macOS, unavailable)
extension BWA where Value: BinaryFloatingPoint {
    @inlinable
    public init(_ uiColor: UIColor) {
        self.init(uiColor._extractBWA().0)
    }

    @inlinable
    public init?(exactly uiColor: UIColor) {
        let (bwa, isExact) = uiColor._extractBWA()
        guard isExact else { return nil }
        self.init(exactly: bwa)
    }
}
#endif
