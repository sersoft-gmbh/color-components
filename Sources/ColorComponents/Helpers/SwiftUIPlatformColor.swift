#if canImport(SwiftUI)
//public import SwiftUI

#if canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst))
#if canImport(UIKit)
public import class UIKit.UIColor
@usableFromInline
typealias _PlatformColor = UIColor
#elseif (canImport(AppKit) && !targetEnvironment(macCatalyst))
public import class AppKit.NSColor
@usableFromInline
typealias _PlatformColor = NSColor
#else
#error("Unsupported platform") // <- should be unreachable
#endif

//@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
//extension Color {
//    @inlinable
//    init(platformColor: _PlatformColor) {
//        if #available(macOS 12, iOS 15, tvOS 15, watchOS 8, *) {
//#if canImport(UIKit)
//            self.init(uiColor: platformColor)
//#elseif (canImport(AppKit) && !targetEnvironment(macCatalyst))
//            self.init(nsColor: platformColor)
//#endif
//        } else {
//            self.init(platformColor)
//        }
//    }
//}
#endif

//#if canImport(CoreGraphics)
//public import CoreGraphics
//
//@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
//extension Color {
//    @inlinable
//    init(_cgColor: CGColor) {
//        if #available(macOS 12, iOS 15.0, tvOS 15, watchOS 8, *) {
//            self.init(cgColor: _cgColor)
//        } else {
//            self.init(_cgColor)
//        }
//    }
//}
//#endif

#endif
