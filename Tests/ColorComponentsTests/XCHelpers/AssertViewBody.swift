#if canImport(SwiftUI)
import XCTest
import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@MainActor
func XCTAssertBody<V: View, Expected: View & Equatable>(
    of view: V,
    equals body: @autoclosure () throws -> Expected,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath, line: UInt = #line)
{
    let viewBody = view.body
    // Xcode as of version 16 erases all `some` return types to their `@_typeErasure` type (if any).
    // There is a build setting for projects (SWIFT_ENABLE_OPAQUE_TYPE_ERASURE=NO), but that's not possible for SPM packages.
    // However, we can "unpack" the any view for these builds. Worst case scenario: We don't check the view body.
    // Kudos to Joe Groff for digging up the build setting: https://f.duriansoftware.com/@joe/113170928606701687
#if Xcode && swift(>=6.0)
    XCTAssert(type(of: viewBody) == Expected.self || type(of: viewBody) == AnyView.self, "\(type(of: viewBody)) != \(Expected.self) || \(AnyView.self): \(message())",
              file: file, line: line)
    if let expectedTypeBody = viewBody as? Expected {
        XCTAssertEqual(expectedTypeBody, try body(), message(), file: file, line: line)
    } else if let anyBody = viewBody as? AnyView,
              let actualView = Mirror(reflecting: anyBody).descendant("storage", "view") {
        XCTAssertEqual(actualView as? Expected, try body(), message(), file: file, line: line)
    }
#else
    XCTAssert(type(of: viewBody) == Expected.self, "\(type(of: viewBody)) != \(Expected.self): \(message())", file: file, line: line)
    XCTAssertEqual(viewBody as? Expected, try body(), message(), file: file, line: line)
#endif
}
#endif
