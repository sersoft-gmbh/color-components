#if canImport(SwiftUI) && canImport(Combine) // Combine check seems to be necessary
import SwiftUI

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Color {
    @inlinable
    init<Value: BinaryFloatingPoint>(_ bw: BW<Value>, opacity: Value) {
        self.init(white: .init(bw.white), opacity: .init(opacity))
    }

    @inlinable
    public init<Value: BinaryFloatingPoint>(_ bw: BW<Value>) {
        self.init(bw, opacity: 1)
    }

    @inlinable
    public init<Value: BinaryFloatingPoint>(_ bwa: BWA<Value>) {
        self.init(bwa.bw, opacity: bwa.alpha)
    }
}

#if canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst))
@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension BW where Value: BinaryFloatingPoint {
    @inlinable
    public init(_ color: Color) {
        self.init(PlatformColor(color))
    }

    @inlinable
    public init?(exactly color: Color) {
        self.init(exactly: PlatformColor(color))
    }
}

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension BWA where Value: BinaryFloatingPoint {
    @inlinable
    public init(_ color: Color) {
        self.init(PlatformColor(color))
    }

    @inlinable
    public init?(exactly color: Color) {
        self.init(exactly: PlatformColor(color))
    }
}
#elseif canImport(CoreGraphics)
import class CoreGraphics.CGColor
@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension BW where Value: BinaryFloatingPoint {
    @inlinable
    public init?(_ color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(cgColor)
    }

    @inlinable
    public init?(exactly color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(exactly: cgColor)
    }
}

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension BWA where Value: BinaryFloatingPoint {
    @inlinable
    public init?(_ color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(cgColor)
    }

    @inlinable
    public init?(exactly color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(exactly: cgColor)
    }
}
#endif
#endif
