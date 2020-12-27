#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

extension NSColor {
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
    func _extractBWA() -> BWA<CGFloat> {
        var bwa = BWA<CGFloat>(white: 0, alpha: 1)
        getWhite(&bwa.bw.white, alpha: &bwa.alpha)
        return bwa
    }
}

extension BW where Value: BinaryFloatingPoint {
    @inlinable
    public init(_ nsColor: NSColor) {
        self.init(nsColor._extractBWA().bw)
    }

    @inlinable
    public init?(exactly nsColor: NSColor) {
        self.init(nsColor._extractBWA().bw)
    }
}

extension BWA where Value: BinaryFloatingPoint {
    @inlinable
    public init(_ nsColor: NSColor) {
        self.init(nsColor._extractBWA())
    }

    @inlinable
    public init?(exactly nsColor: NSColor) {
        self.init(nsColor._extractBWA())
    }
}
#endif
