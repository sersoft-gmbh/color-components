#if arch(arm64) || arch(x86_64)
#if canImport(SwiftUI) && canImport(Combine) // Combine check seems to be necessary
public import SwiftUI

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Color {
    @inlinable
    init<Value: BinaryFloatingPoint>(_ hsb: HSB<Value>, opacity: Value) {
        self.init(hue: .init(hsb.hue),
                  saturation: .init(hsb.saturation),
                  brightness: .init(hsb.brightness),
                  opacity: .init(opacity))
    }

    /// Creates a new color using the given HSB components.
    /// - Parameter hsb: The HSB components.
    @inlinable
    public init<Value: BinaryFloatingPoint>(_ hsb: HSB<Value>) {
        self.init(hsb, opacity: 1)
    }

    /// Creates a new color using the given HSBA components.
    /// - Parameter hsba: The HSBA components.
    @inlinable
    public init<Value: BinaryFloatingPoint>(_ hsba: HSBA<Value>) {
        self.init(hsba.hsb, opacity: hsba.alpha)
    }

    /// Creates a new color using the given HSB components.
    /// - Parameter hsb: The HSB components.
    @inlinable
    public init<Value: BinaryInteger>(_ hsb: HSB<Value>) {
        self.init(HSB<Double>(hsb))
    }

    /// Creates a new color using the given HSBA components.
    /// - Parameter hsba: The HSBA components.
    @inlinable
    public init<Value: BinaryInteger>(_ hsba: HSBA<Value>) {
        self.init(HSBA<Double>(hsba))
    }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension HSB: View where Value: BinaryFloatingPoint {
    /// See `View.body`.
    @inlinable
    public var body: some View { Color(self) }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension HSBA: View where Value: BinaryFloatingPoint {
    /// See `View.body`.
    @inlinable
    public var body: some View { Color(self) }
}

#if canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst))
@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension HSB where Value: BinaryFloatingPoint {
    /// Creates new HSB components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    @inlinable
    public init(_ color: Color) {
        self.init(_PlatformColor(color))
    }

    /// Tries to create new HSB components that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    /// - SeeAlso: ``HSB/init(exactly:)``
    @inlinable
    public init?(exactly color: Color) {
        self.init(exactly: _PlatformColor(color))
    }
}

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension HSB where Value: BinaryInteger {
    /// Creates new HSB components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    @inlinable
    public init(_ color: Color) {
        self.init(_PlatformColor(color))
    }

    /// Tries to create new HSB components that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    /// - SeeAlso: ``HSB/init(exactly:)``
    @inlinable
    public init?(exactly color: Color) {
        self.init(exactly: _PlatformColor(color))
    }
}

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension HSBA where Value: BinaryFloatingPoint {
    /// Creates new HSBA components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    @inlinable
    public init(_ color: Color) {
        self.init(_PlatformColor(color))
    }

    /// Tries to create new HSBA components that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    /// - SeeAlso: ``HSBA/init(exactly:)``
    @inlinable
    public init?(exactly color: Color) {
        self.init(exactly: _PlatformColor(color))
    }
}

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension HSBA where Value: BinaryInteger {
    /// Creates new HSBA components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    @inlinable
    public init(_ color: Color) {
        self.init(_PlatformColor(color))
    }

    /// Tries to create new HSBA components that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    /// - SeeAlso: ``HSBA/init(exactly:)``
    @inlinable
    public init?(exactly color: Color) {
        self.init(exactly: _PlatformColor(color))
    }
}
#elseif canImport(CoreGraphics)
public import class CoreGraphics.CGColor

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension HSB where Value: BinaryFloatingPoint {
    /// Creates new HSB components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This only returns `nil` if `cgColor` on `color` is `nil`.
    @inlinable
    public init?(_ color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(cgColor)
    }

    /// Tries to create new HSB components that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This returns `nil` if `cgColor` on `color` is `nil`, or if the exact conversion fails.
    /// - SeeAlso: ``HSB/init(exactly:)``
    @inlinable
    public init?(exactly color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(exactly: cgColor)
    }
}

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension HSB where Value: BinaryInteger {
    /// Creates new HSB components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This only returns `nil` if `cgColor` on `color` is `nil`.
    @inlinable
    public init?(_ color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(cgColor)
    }

    /// Tries to create new HSB components that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This returns `nil` if `cgColor` on `color` is `nil`, or if the exact conversion fails.
    /// - SeeAlso: ``HSB/init(exactly:)``
    @inlinable
    public init?(exactly color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(exactly: cgColor)
    }
}

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension HSBA where Value: BinaryFloatingPoint {
    /// Creates new HSBA components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This only returns `nil` if `cgColor` on `color` is `nil`.
    @inlinable
    public init?(_ color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(cgColor)
    }

    /// Tries to create new HSB components that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This returns `nil` if `cgColor` on `color` is `nil`, or if the exact conversion fails.
    /// - SeeAlso: ``HSBA/init(exactly:)``
    @inlinable
    public init?(exactly color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(exactly: cgColor)
    }
}

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension HSBA where Value: BinaryInteger {
    /// Creates new HSBA components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This only returns `nil` if `cgColor` on `color` is `nil`.
    @inlinable
    public init?(_ color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(cgColor)
    }

    /// Tries to create new HSB components that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This returns `nil` if `cgColor` on `color` is `nil`, or if the exact conversion fails.
    /// - SeeAlso: ``HSBA/init(exactly:)``
    @inlinable
    public init?(exactly color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(exactly: cgColor)
    }
}
#endif
#endif
#endif
