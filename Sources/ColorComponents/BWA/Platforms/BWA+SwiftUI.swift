#if arch(arm64) || arch(x86_64)
#if canImport(SwiftUI) && canImport(Combine) // Combine check seems to be necessary
import SwiftUI

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Color {
    @inlinable
    init<Value: BinaryFloatingPoint>(_ bw: BW<Value>, opacity: Value) {
        self.init(white: .init(bw.white), opacity: .init(opacity))
    }

    /// Creates a new color using the given black/white components.
    /// - Parameter bw: The black/white components.
    @inlinable
    public init<Value: BinaryFloatingPoint>(_ bw: BW<Value>) {
        self.init(bw, opacity: 1)
    }

    /// Creates a new color using the given black/white components with alpha channel.
    /// - Parameter bwa: The black/white components with alpha channel.
    @inlinable
    public init<Value: BinaryFloatingPoint>(_ bwa: BWA<Value>) {
        self.init(bwa.bw, opacity: bwa.alpha)
    }

    /// Creates a new color using the given black/white components.
    /// - Parameter bw: The black/white components.
    @inlinable
    public init<Value: BinaryInteger>(_ bw: BW<Value>) {
        self.init(BW<Double>(bw))
    }

    /// Creates a new color using the given black/white components with alpha channel.
    /// - Parameter bwa: The black/white components with alpha channel.
    @inlinable
    public init<Value: BinaryInteger>(_ bwa: BWA<Value>) {
        self.init(BWA<Double>(bwa))
    }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension BW: View where Value: BinaryFloatingPoint {
    @inlinable
    public var body: some View { Color(self) }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension BWA: View where Value: BinaryFloatingPoint {
    @inlinable
    public var body: some View { Color(self) }
}

#if canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst))
@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension BW where Value: BinaryFloatingPoint {
    /// Creates new black/white components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    @inlinable
    public init(_ color: Color) {
        self.init(_PlatformColor(color))
    }

    /// Tries to create new black/white components that exactly
    /// match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    /// - SeeAlso: ``BW/init(exactly:)``
    @inlinable
    public init?(exactly color: Color) {
        self.init(exactly: _PlatformColor(color))
    }
}

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension BW where Value: BinaryInteger {
    /// Creates new black/white components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    @inlinable
    public init(_ color: Color) {
        self.init(_PlatformColor(color))
    }

    /// Tries to create new black/white components that exactly
    /// match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    /// - SeeAlso: ``BW/init(exactly:)``
    @inlinable
    public init?(exactly color: Color) {
        self.init(exactly: _PlatformColor(color))
    }
}

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension BWA where Value: BinaryFloatingPoint {
    /// Creates new black/white components with alpha channel from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    @inlinable
    public init(_ color: Color) {
        self.init(_PlatformColor(color))
    }

    /// Tries to create new black/white components with alpha channel
    /// that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    /// - SeeAlso: ``BWA/init(exactly:)``
    @inlinable
    public init?(exactly color: Color) {
        self.init(exactly: _PlatformColor(color))
    }
}

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension BWA where Value: BinaryInteger {
    /// Creates new black/white components with alpha channel from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    @inlinable
    public init(_ color: Color) {
        self.init(_PlatformColor(color))
    }

    /// Tries to create new black/white components with alpha channel
    /// that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through the platform native color (`NSColor` or `UIColor`)
    ///         due to the lack of component accessors on `SwiftUI.Color`.
    /// - SeeAlso: ``BWA/init(exactly:)``
    @inlinable
    public init?(exactly color: Color) {
        self.init(exactly: _PlatformColor(color))
    }
}
#elseif canImport(CoreGraphics)
import class CoreGraphics.CGColor

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension BW where Value: BinaryFloatingPoint {
    /// Creates new black/white components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This only returns `nil` if `cgColor` on `color` is `nil`.
    @inlinable
    public init?(_ color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(cgColor)
    }

    /// Tries to create new black/white components that exactly
    /// match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This returns `nil` if `cgColor` on `color` is `nil`, or if the exact conversion fails.
    /// - SeeAlso: ``BW/init(exactly:)``
    @inlinable
    public init?(exactly color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(exactly: cgColor)
    }
}

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension BW where Value: BinaryInteger {
    /// Creates new black/white components from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This only returns `nil` if `cgColor` on `color` is `nil`.
    @inlinable
    public init?(_ color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(cgColor)
    }

    /// Tries to create new black/white components that exactly
    /// match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This returns `nil` if `cgColor` on `color` is `nil`, or if the exact conversion fails.
    /// - SeeAlso: ``BW/init(exactly:)``
    @inlinable
    public init?(exactly color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(exactly: cgColor)
    }
}

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension BWA where Value: BinaryFloatingPoint {
    /// Creates new black/white components with alpha channel from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This only returns `nil` if `cgColor` on `color` is `nil`.
    @inlinable
    public init?(_ color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(cgColor)
    }

    /// Tries to create new black/white components with alpha channel
    /// that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This returns `nil` if `cgColor` on `color` is `nil`, or if the exact conversion fails.
    /// - SeeAlso: ``BWA/init(exactly:)``
    @inlinable
    public init?(exactly color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(exactly: cgColor)
    }
}

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
extension BWA where Value: BinaryInteger {
    /// Creates new black/white components with alpha channel from the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This only returns `nil` if `cgColor` on `color` is `nil`.
    @inlinable
    public init?(_ color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(cgColor)
    }

    /// Tries to create new black/white components with alpha channel
    /// that exactly match the components of the given color.
    /// - Parameter color: The color to read the components from.
    /// - Note: This currently goes through `CGColor` due to the lack of component accessors on `SwiftUI.Color`.
    /// - Note: This returns `nil` if `cgColor` on `color` is `nil`, or if the exact conversion fails.
    /// - SeeAlso: ``BWA/init(exactly:)``
    @inlinable
    public init?(exactly color: Color) {
        guard let cgColor = color.cgColor else { return nil }
        self.init(exactly: cgColor)
    }
}
#endif
#endif
#endif
