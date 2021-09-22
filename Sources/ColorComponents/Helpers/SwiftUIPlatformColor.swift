#if arch(arm64) || arch(x86_64)
#if canImport(SwiftUI) && canImport(Combine) // Combine check seems to be necessary
#if canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst))
#if canImport(UIKit)
import class UIKit.UIColor
@usableFromInline
typealias _PlatformColor = UIColor
#elseif (canImport(AppKit) && !targetEnvironment(macCatalyst))
import class AppKit.NSColor
@usableFromInline
typealias _PlatformColor = NSColor
#else
#error("Unsupported platform") // <- should be unreachable
#endif
#endif
#endif
#endif
