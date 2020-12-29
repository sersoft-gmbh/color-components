#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension NSColorSpace {
    public static var colorComponentsDefaultGray: NSColorSpace { .deviceGray }
}

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension NSColor {
    @inlinable
    convenience init<Value: BinaryFloatingPoint>(_ bw: BW<Value>, alpha: Value, colorSpace: NSColorSpace) {
        self.init(colorSpace: colorSpace, components: [.init(bw.white), .init(alpha)])
    }

    @inlinable
    public convenience init<Value: BinaryFloatingPoint>(_ bw: BW<Value>, colorSpace: NSColorSpace = .colorComponentsDefaultGray) {
        self.init(bw, alpha: 1, colorSpace: colorSpace)
    }

    @inlinable
    public convenience init<Value: BinaryFloatingPoint>(_ bwa: BWA<Value>, colorSpace: NSColorSpace = .colorComponentsDefaultGray) {
        self.init(bwa.bw, alpha: bwa.alpha, colorSpace: colorSpace)
    }

    @usableFromInline
    func _extractBWA() -> BWA<CGFloat> {
        var allowedColorSpaces: Set<NSColorSpace> = [.genericGray, .deviceGray, .genericGamma22Gray]
        if #available(macOS 10.12, *) {
            allowedColorSpaces.insert(.extendedGenericGamma22Gray)
        }
        var bwa = BWA<CGFloat>(white: 0, alpha: 1)
        _requireColorSpace(in: allowedColorSpaces, convertingTo: .colorComponentsDefaultGray)
            .getWhite(&bwa.bw.white, alpha: &bwa.alpha)
        return bwa
    }
}

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension BW where Value: BinaryFloatingPoint {
    @inlinable
    public init(_ nsColor: NSColor) {
        self.init(nsColor._extractBWA().bw)
    }

    @inlinable
    public init?(exactly nsColor: NSColor) {
        self.init(exactly: nsColor._extractBWA().bw)
    }
}

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension BWA where Value: BinaryFloatingPoint {
    @inlinable
    public init(_ nsColor: NSColor) {
        self.init(nsColor._extractBWA())
    }

    @inlinable
    public init?(exactly nsColor: NSColor) {
        self.init(exactly: nsColor._extractBWA())
    }
}
#endif
