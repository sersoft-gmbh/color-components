#if canImport(SwiftUI) && canImport(Combine) // Combine check seems to be necessary
#if canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst))
#if canImport(UIKit)
import class UIKit.UIColor
@usableFromInline
typealias PlatformColor = UIColor
#elseif (canImport(AppKit) && !targetEnvironment(macCatalyst))
import class AppKit.NSColor
@usableFromInline
typealias PlatformColor = NSColor
#else
#error("Unsupported platform")
#endif
#endif
#endif
