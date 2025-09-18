extension Bool {
    static var coreGraphicsAvailable: Self {
#if canImport(CoreGraphics)
        true
#else
        false
#endif
    }

    static var appKitAvailable: Self {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
        true
#else
        false
#endif
    }

    static var uiKitAvailable: Self {
#if canImport(UIKit)
        true
#else
        false
#endif
    }

    static var swiftUIAvailable: Self {
#if canImport(SwiftUI)
        true
#else
        false
#endif
    }

    static var platformColorAvailable: Self {
#if canImport(CoreGraphics) || canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst))
        true
#else
        false
#endif
    }
}
