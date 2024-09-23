#if arch(arm64) || arch(x86_64)
#if canImport(SwiftUI) && canImport(Combine) // Combine check seems to be necessary
public import SwiftUI

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Color {
    @inlinable
    init<Value: BinaryFloatingPoint>(_ rgb: RGB<Value>, opacity: Value) {
        self.init(red: .init(rgb.red), green: .init(rgb.green), blue: .init(rgb.blue), opacity: .init(opacity))
    }

    /// Creates a new color using the given RGB components.
    /// - Parameter rgb: The RGB components.
    @inlinable
    public init<Value: BinaryFloatingPoint>(_ rgb: RGB<Value>) {
        self.init(rgb, opacity: 1)
    }

    /// Creates a new color using the given RGBA components.
    /// - Parameter rgba: The RGBA components.
    @inlinable
    public init<Value: BinaryFloatingPoint>(_ rgba: RGBA<Value>) {
        self.init(rgba.rgb, opacity: rgba.alpha)
    }

    /// Creates a new color using the given RGB components.
    /// - Parameter rgb: The RGB components.
    @inlinable
    public init<Value: BinaryInteger>(_ rgb: RGB<Value>) {
        self.init(RGB<Double>(rgb))
    }

    /// Creates a new color using the given RGBA components.
    /// - Parameter rgba: The RGBA components.
    @inlinable
    public init<Value: BinaryInteger>(_ rgba: RGBA<Value>) {
        self.init(RGBA<Double>(rgba))
    }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension RGB: View where Value: BinaryFloatingPoint {
    @inlinable
    public var body: some View { Color(self) }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension RGBA: View where Value: BinaryFloatingPoint {
    @inlinable
    public var body: some View { Color(self) }
}

#if canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst))
@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension RGB where Value: BinaryFloatingPoint {
    /// Creates new RGB components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    @inlinable
    public init(_ color: Color) {
        self.init(_PlatformColor(color))
    }

    /// Tries to create new RGB components that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    /// - SeeAlso: ``RGB/init(exactly:)``
    @inlinable
    public init?(exactly color: Color) {
        self.init(exactly: _PlatformColor(color))
    }
}

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension RGB where Value: BinaryInteger {
    /// Creates new RGB components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    @inlinable
    public init(_ color: Color) {
        self.init(_PlatformColor(color))
    }

    /// Tries to create new RGB components that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    /// - SeeAlso: ``RGB/init(exactly:)``
    @inlinable
    public init?(exactly color: Color) {
        self.init(exactly: _PlatformColor(color))
    }
}

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension RGBA where Value: BinaryFloatingPoint {
    /// Creates new RGBA components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    @inlinable
    public init(_ color: Color) {
        self.init(_PlatformColor(color))
    }

    /// Tries to create new RGBA components that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    /// - SeeAlso: ``RGBA/init(exactly:)``
    @inlinable
    public init?(exactly color: Color) {
        self.init(exactly: _PlatformColor(color))
    }
}

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension RGBA where Value: BinaryInteger {
    /// Creates new RGBA components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    @inlinable
    public init(_ color: Color) {
        self.init(_PlatformColor(color))
    }

    /// Tries to create new RGBA components that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    /// - SeeAlso: ``RGBA/init(exactly:)``
    @inlinable
    public init?(exactly color: Color) {
        self.init(exactly: _PlatformColor(color))
    }
}
#elseif canImport(CoreGraphics)
public import class CoreGraphics.CGColor

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension RGB where Value: BinaryFloatingPoint {
    /// Creates new RGB components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This only returns `nil` if `cgColor` on `color` is `nil`.
    @inlinable
    public init?(_ color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(cgColor)
    }

    /// Tries to create new RGB components that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This returns `nil` if `cgColor` on `color` is `nil`, or if the exact conversion fails.
    /// - SeeAlso: ``RGB/init(exactly:)``
    @inlinable
    public init?(exactly color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(exactly: cgColor)
    }
}

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension RGB where Value: BinaryInteger {
    /// Creates new RGB components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This only returns `nil` if `cgColor` on `color` is `nil`.
    @inlinable
    public init?(_ color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(cgColor)
    }

    /// Tries to create new RGB components that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This returns `nil` if `cgColor` on `color` is `nil`, or if the exact conversion fails.
    /// - SeeAlso: ``RGB/init(exactly:)``
    @inlinable
    public init?(exactly color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(exactly: cgColor)
    }
}

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension RGBA where Value: BinaryFloatingPoint {
    /// Creates new RGBA components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This only returns `nil` if `cgColor` on `color` is `nil`.
    @inlinable
    public init?(_ color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(cgColor)
    }

    /// Tries to create new RGBA components that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This returns `nil` if `cgColor` on `color` is `nil`, or if the exact conversion fails.
    /// - SeeAlso: ``RGBA/init(exactly:)``
    @inlinable
    public init?(exactly color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(exactly: cgColor)
    }
}

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension RGBA where Value: BinaryInteger {
    /// Creates new RGBA components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This only returns `nil` if `cgColor` on `color` is `nil`.
    @inlinable
    public init?(_ color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(cgColor)
    }

    /// Tries to create new RGBA components that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This returns `nil` if `cgColor` on `color` is `nil`, or if the exact conversion fails.
    /// - SeeAlso: ``RGBA/init(exactly:)``
    @inlinable
    public init?(exactly color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(exactly: cgColor)
    }
}
#endif
#endif
#endif
