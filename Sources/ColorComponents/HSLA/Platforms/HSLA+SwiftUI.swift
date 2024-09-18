#if canImport(SwiftUI) && canImport(Combine) // Combine check seems to be necessary
public import SwiftUI

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Color {
    /// Creates a new color using the given HSL components.
    /// - Parameter hsl: The HSL components.
    @inlinable
    public init<Value: BinaryFloatingPoint>(_ hsl: HSL<Value>) {
        self.init(HSB(hsl: hsl))
    }

    /// Creates a new color using the given HSLA components.
    /// - Parameter hsla: The HSLA components.
    @inlinable
    public init<Value: BinaryFloatingPoint>(_ hsla: HSLA<Value>) {
        self.init(HSBA(hsla: hsla))
    }

    /// Creates a new color using the given HSL components.
    /// - Parameter hsl: The HSL components.
    @inlinable
    public init<Value: BinaryInteger>(_ hsl: HSL<Value>) {
        self.init(HSL<Double>(hsl))
    }

    /// Creates a new color using the given HSLA components.
    /// - Parameter hsla: The HSLA components.
    @inlinable
    public init<Value: BinaryInteger>(_ hsla: HSLA<Value>) {
        self.init(HSLA<Double>(hsla))
    }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension HSL: View where Value: BinaryFloatingPoint {
    /// See `View.body`.
    @inlinable
    public var body: some View { Color(self) }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension HSLA: View where Value: BinaryFloatingPoint {
    /// See `View.body`.
    @inlinable
    public var body: some View { Color(self) }
}

#if canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst))
@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension HSL where Value: BinaryFloatingPoint {
    /// Creates new HSL components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    @inlinable
    public init(_ color: Color) {
        self.init(_PlatformColor(color))
    }

    /// Tries to create new HSL components that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    /// - SeeAlso: ``HSL/init(exactly:)``
    @inlinable
    public init?(exactly color: Color) {
        self.init(exactly: _PlatformColor(color))
    }
}

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension HSL where Value: BinaryInteger {
    /// Creates new HSL components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    @inlinable
    public init(_ color: Color) {
        self.init(_PlatformColor(color))
    }

    /// Tries to create new HSL components that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    /// - SeeAlso: ``HSL/init(exactly:)``
    @inlinable
    public init?(exactly color: Color) {
        self.init(exactly: _PlatformColor(color))
    }
}

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension HSLA where Value: BinaryFloatingPoint {
    /// Creates new HSLA components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    @inlinable
    public init(_ color: Color) {
        self.init(_PlatformColor(color))
    }

    /// Tries to create new HSLA components that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    /// - SeeAlso: ``HSLA/init(exactly:)``
    @inlinable
    public init?(exactly color: Color) {
        self.init(exactly: _PlatformColor(color))
    }
}

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension HSLA where Value: BinaryInteger {
    /// Creates new HSLA components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    @inlinable
    public init(_ color: Color) {
        self.init(_PlatformColor(color))
    }

    /// Tries to create new HSLA components that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    /// - SeeAlso: ``HSLA/init(exactly:)``
    @inlinable
    public init?(exactly color: Color) {
        self.init(exactly: _PlatformColor(color))
    }
}
#elseif canImport(CoreGraphics)
public import class CoreGraphics.CGColor

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension HSL where Value: BinaryFloatingPoint {
    /// Creates new HSL components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This only returns `nil` if `cgColor` on `color` is `nil`.
    @inlinable
    public init?(_ color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(cgColor)
    }

    /// Tries to create new HSL components that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This returns `nil` if `cgColor` on `color` is `nil`, or if the exact conversion fails.
    /// - SeeAlso: ``HSL/init(exactly:)``
    @inlinable
    public init?(exactly color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(exactly: cgColor)
    }
}

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension HSL where Value: BinaryInteger {
    /// Creates new HSL components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This only returns `nil` if `cgColor` on `color` is `nil`.
    @inlinable
    public init?(_ color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(cgColor)
    }

    /// Tries to create new HSL components that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This returns `nil` if `cgColor` on `color` is `nil`, or if the exact conversion fails.
    /// - SeeAlso: ``HSL/init(exactly:)``
    @inlinable
    public init?(exactly color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(exactly: cgColor)
    }
}

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension HSLA where Value: BinaryFloatingPoint {
    /// Creates new HSLA components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This only returns `nil` if `cgColor` on `color` is `nil`.
    @inlinable
    public init?(_ color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(cgColor)
    }

    /// Tries to create new HSL components that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This returns `nil` if `cgColor` on `color` is `nil`, or if the exact conversion fails.
    /// - SeeAlso: ``HSLA/init(exactly:)``
    @inlinable
    public init?(exactly color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(exactly: cgColor)
    }
}

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension HSLA where Value: BinaryInteger {
    /// Creates new HSLA components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This only returns `nil` if `cgColor` on `color` is `nil`.
    @inlinable
    public init?(_ color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(cgColor)
    }

    /// Tries to create new HSL components that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This returns `nil` if `cgColor` on `color` is `nil`, or if the exact conversion fails.
    /// - SeeAlso: ``HSLA/init(exactly:)``
    @inlinable
    public init?(exactly color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(exactly: cgColor)
    }
}
#endif
#endif
