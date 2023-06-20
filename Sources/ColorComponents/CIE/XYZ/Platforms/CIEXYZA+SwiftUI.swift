#if arch(arm64) || arch(x86_64)
#if canImport(SwiftUI) && canImport(Combine) // Combine check seems to be necessary
import SwiftUI

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Color {
    @inlinable
    init<Value: BinaryFloatingPoint>(_ cieXYZ: CIE.XYZ<Value>, opacity: Value) {
        self.init(RGB<Value>(cieXYZ: cieXYZ), opacity: opacity)
    }

    /// Creates a new color using the given CIE.XYZ components.
    /// - Parameter cieXYZ: The CIE.XYZ components.
    @inlinable
    public init<Value: BinaryFloatingPoint>(_ cieXYZ: CIE.XYZ<Value>) {
        self.init(cieXYZ, opacity: 1)
    }

    /// Creates a new color using the given CIE.XYZA components.
    /// - Parameter cieXYZA: The CIE.XYZA components.
    @inlinable
    public init<Value: BinaryFloatingPoint>(_ cieXYZA: CIE.XYZA<Value>) {
        self.init(cieXYZA.xyz, opacity: cieXYZA.alpha)
    }

    /// Creates a new color using the given CIE.XYZ components.
    /// - Parameter cieXYZ: The CIE.XYZ components.
    @inlinable
    public init<Value: BinaryInteger>(_ cieXYZ: CIE.XYZ<Value>) {
        self.init(CIE.XYZ<Double>(cieXYZ))
    }

    /// Creates a new color using the given CIE.XYZA components.
    /// - Parameter cieXYZA: The CIE.XYZA components.
    @inlinable
    public init<Value: BinaryInteger>(_ cieXYZA: CIE.XYZA<Value>) {
        self.init(CIE.XYZA<Double>(cieXYZA))
    }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension CIE.XYZ: View where Value: BinaryFloatingPoint {
    /// See `View.body`.
    @inlinable
    public var body: some View { Color(self) }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension CIE.XYZA: View where Value: BinaryFloatingPoint {
    /// See `View.body`.
    @inlinable
    public var body: some View { Color(self) }
}

#if canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst))
@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension CIE.XYZ where Value: BinaryFloatingPoint {
    /// Creates new CIE.XYZ components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    @inlinable
    public init(_ color: Color) {
        self.init(_PlatformColor(color))
    }

    /// Tries to create new CIE.XYZ components that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    /// - SeeAlso: `CIE.XYZ.init(exactly:)`
    @inlinable
    public init?(exactly color: Color) {
        self.init(exactly: _PlatformColor(color))
    }
}

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension CIE.XYZ where Value: BinaryInteger {
    /// Creates new CIE.XYZ components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    @inlinable
    public init(_ color: Color) {
        self.init(_PlatformColor(color))
    }

    /// Tries to create new CIE.XYZ components that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    /// - SeeAlso: `CIE.XYZ.init(exactly:)`
    @inlinable
    public init?(exactly color: Color) {
        self.init(exactly: _PlatformColor(color))
    }
}

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension CIE.XYZA where Value: BinaryFloatingPoint {
    /// Creates new CIE.XYZA components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    @inlinable
    public init(_ color: Color) {
        self.init(_PlatformColor(color))
    }

    /// Tries to create new CIE.XYZA components that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    /// - SeeAlso: `CIE.XYZA.init(exactly:)`
    @inlinable
    public init?(exactly color: Color) {
        self.init(exactly: _PlatformColor(color))
    }
}

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension CIE.XYZA where Value: BinaryInteger {
    /// Creates new CIE.XYZA components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    @inlinable
    public init(_ color: Color) {
        self.init(_PlatformColor(color))
    }

    /// Tries to create new CIE.XYZA components that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    /// - SeeAlso: `CIE.XYZA.init(exactly:)`
    @inlinable
    public init?(exactly color: Color) {
        self.init(exactly: _PlatformColor(color))
    }
}
#elseif canImport(CoreGraphics)
import class CoreGraphics.CGColor

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension CIE.XYZ where Value: BinaryFloatingPoint {
    /// Creates new CIE.XYZ components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This only returns `nil` if `cgColor` on `color` is `nil`.
    @inlinable
    public init?(_ color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(cgColor)
    }

    /// Tries to create new CIE.XYZ components that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This returns `nil` if `cgColor` on `color` is `nil`, or if the exact conversion fails.
    /// - SeeAlso: `CIE.XYZ.init(exactly:)`
    @inlinable
    public init?(exactly color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(exactly: cgColor)
    }
}

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension CIE.XYZ where Value: BinaryInteger {
    /// Creates new CIE.XYZ components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This only returns `nil` if `cgColor` on `color` is `nil`.
    @inlinable
    public init?(_ color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(cgColor)
    }

    /// Tries to create new CIE.XYZ components that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This returns `nil` if `cgColor` on `color` is `nil`, or if the exact conversion fails.
    /// - SeeAlso: `CIE.XYZ.init(exactly:)`
    @inlinable
    public init?(exactly color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(exactly: cgColor)
    }
}

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension CIE.XYZA where Value: BinaryFloatingPoint {
    /// Creates new CIE.XYZA components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This only returns `nil` if `cgColor` on `color` is `nil`.
    @inlinable
    public init?(_ color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(cgColor)
    }

    /// Tries to create new CIE.XYZA components that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This returns `nil` if `cgColor` on `color` is `nil`, or if the exact conversion fails.
    /// - SeeAlso: `CIE.XYZA.init(exactly:)`
    @inlinable
    public init?(exactly color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(exactly: cgColor)
    }
}

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension CIE.XYZA where Value: BinaryInteger {
    /// Creates new CIE.XYZA components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This only returns `nil` if `cgColor` on `color` is `nil`.
    @inlinable
    public init?(_ color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(cgColor)
    }

    /// Tries to create new CIE.XYZA components that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This returns `nil` if `cgColor` on `color` is `nil`, or if the exact conversion fails.
    /// - SeeAlso: `CIE.XYZA.init(exactly:)`
    @inlinable
    public init?(exactly color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(exactly: cgColor)
    }
}
#endif
#endif
#endif
