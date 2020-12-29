#if canImport(SwiftUI) && canImport(Combine)
import XCTest
import SwiftUI
import ColorComponents

final class HSBA_SwiftUITests: XCTestCase {
    func testColorCreation() throws {
        guard #available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
        else { try skipUnavailableAPI() }

        let hsb = HSB<CGFloat>(hue: 0.5, saturation: 0.25, brightness: 0.75)
        let hsba = HSBA(hsb: hsb, alpha: 0.25)

        XCTAssertEqual(Color(hsb), Color(hue: 0.5, saturation: 0.25, brightness: 0.75, opacity: 1))
        XCTAssertEqual(Color(hsba), Color(hue: 0.5, saturation: 0.25, brightness: 0.75, opacity: 0.25))
    }

    func testCreationFromColor() throws {
        guard #available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
        else { try skipUnavailableAPI() }

        let color = Color(hue: 0.5, saturation: 0.25, brightness: 0.75, opacity: 0.25)

        #if canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst))
        let hsb = HSB<CGFloat>(color)
        let hsba = HSBA<CGFloat>(color)
        #elseif canImport(CoreGraphics)
        let hsb = try XCTUnwrap(HSB<CGFloat>(color))
        let hsba = try XCTUnwrap(HSBA<CGFloat>(color))
        #else
        try apiUnavailable()
        #endif

        XCTAssertEqual(hsb.hue, 0.5, accuracy: .ulpOfOne)
        XCTAssertEqual(hsba.hue, 0.5, accuracy: .ulpOfOne)
        XCTAssertEqual(hsb.saturation, 0.25, accuracy: .ulpOfOne)
        XCTAssertEqual(hsba.saturation, 0.25, accuracy: .ulpOfOne)
        XCTAssertEqual(hsb.brightness, 0.75, accuracy: .ulpOfOne)
        XCTAssertEqual(hsba.brightness, 0.75, accuracy: .ulpOfOne)
        XCTAssertEqual(hsba.alpha, 0.25)
        XCTAssertNil(HSB<InexactFloat>(exactly: Color(white: 1)))
        XCTAssertNil(HSBA<InexactFloat>(exactly: Color(white: 1)))
    }
}
#endif
