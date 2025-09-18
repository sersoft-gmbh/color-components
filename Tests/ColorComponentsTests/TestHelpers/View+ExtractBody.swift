#if canImport(SwiftUI)
import Testing
import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {
    func extractBody<Expected: View>(as type: Expected.Type = Expected.self) -> Expected? {
        let viewBody = body
        // Xcode as of version 16 erases all `some` return types to their `@_typeErasure` type (if any).
        // There is a build setting for projects (SWIFT_ENABLE_OPAQUE_TYPE_ERASURE=NO), but that's not possible for SPM packages.
        // However, we can "unpack" the `AnyView` for these builds. Worst case scenario: We don't check the view body.
        // Kudos to Joe Groff for digging up the build setting: https://f.duriansoftware.com/@joe/113170928606701687
#if Xcode
        if let expectedTypeBody = viewBody as? Expected {
            return expectedTypeBody
        }
#if swift(>=6.2)
        if #available(macOS 26, iOS 26, tvOS 26, watchOS 26, visionOS 26, *),
           let debugReplaceableView = viewBody as? DebugReplaceableView,
           let actualView = Mirror(reflecting: debugReplaceableView).descendant("storage", "view") {
            return actualView as? Expected
        }
#endif
        if let anyBody = viewBody as? AnyView,
           let actualView = Mirror(reflecting: anyBody).descendant("storage", "view") {
            return actualView as? Expected
        }
        return nil
#else
        return viewBody as? Expected
#endif
    }
}
#endif
