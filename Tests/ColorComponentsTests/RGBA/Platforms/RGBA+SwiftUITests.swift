#if canImport(SwiftUI) && canImport(Combine)
import XCTest
import SwiftUI
import ColorComponents

final class RGBA_SwiftUITests: XCTestCase {
    func testColorCreation() throws {
        guard #available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
        else { try skipUnavailableAPI() }

        let rgb = RGB<CGFloat>(red: 0.5, green: 0.25, blue: 0.75)
        let rgba = RGBA(rgb: rgb, alpha: 0.25)

        XCTAssertEqual(Color(rgb), Color(red: 0.5, green: 0.25, blue: 0.75, opacity: 1))
        XCTAssertEqual(Color(rgba), Color(red: 0.5, green: 0.25, blue: 0.75, opacity: 0.25))
    }

    func testCreationFromColor() throws {
        guard #available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
        else { try skipUnavailableAPI() }

        let color = Color(red: 0.5, green: 0.25, blue: 0.75, opacity: 0.25)

        #if canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst))
        let rgb = RGB<CGFloat>(color)
        let rgba = RGBA<CGFloat>(color)
        #elseif canImport(CoreGraphics)
        let rgb = try XCTUnwrap(RGB<CGFloat>(color))
        let rgba = try XCTUnwrap(RGBA<CGFloat>(color))
        #else
        try apiUnavailable()
        #endif

        XCTAssertEqual(rgb.red, 0.5, accuracy: .ulpOfOne)
        XCTAssertEqual(rgba.red, 0.5, accuracy: .ulpOfOne)
        XCTAssertEqual(rgb.green, 0.25, accuracy: .ulpOfOne)
        XCTAssertEqual(rgba.green, 0.25, accuracy: .ulpOfOne)
        XCTAssertEqual(rgb.blue, 0.75, accuracy: .ulpOfOne)
        XCTAssertEqual(rgba.blue, 0.75, accuracy: .ulpOfOne)
        XCTAssertEqual(rgba.alpha, 0.25)
        XCTAssertNil(RGB<InexactFloat>(exactly: Color(white: 1)))
        XCTAssertNil(RGBA<InexactFloat>(exactly: Color(white: 1)))
    }
}
#endif
