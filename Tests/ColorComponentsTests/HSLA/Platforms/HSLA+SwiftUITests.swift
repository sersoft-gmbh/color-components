import XCTest
import XCHelpers
#if arch(arm64) || arch(x86_64)
#if canImport(SwiftUI) && canImport(Combine)
import SwiftUI
#endif
#endif
import ColorComponents

final class HSLA_SwiftUITests: XCTestCase {
    func testColorCreationWithFloatingPoint() throws {
        #if arch(arm64) || arch(x86_64)
        #if canImport(SwiftUI) && canImport(Combine)
        guard #available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
        else { try skipUnavailableAPI() }

        let hsl = HSL<Double>(hue: 0.5, saturation: 0.25, luminance: 0.75)
        let hsla = HSLA(hsl: hsl, alpha: 0.25)

        XCTAssertEqual(Color(hsl), Color(HSB(hsl: hsl)))
        XCTAssertEqual(Color(hsla), Color(HSBA(hsla: hsla)))
        #else
        try skipUnavailableAPI()
        #endif
        #else
        try skipUnavailableAPI()
        #endif
    }

    func testCreationFromColorWithFloatingPoint() throws {
        #if arch(arm64) || arch(x86_64)
        #if canImport(SwiftUI) && canImport(Combine)
        guard #available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
        else { try skipUnavailableAPI() }

        let color = Color(hue: 0.5, saturation: 0.25, brightness: 0.75, opacity: 0.25)

        #if canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst))
        let hsl = HSL<CGFloat>(color)
        let hsb = HSB<CGFloat>(color)
        let hsla = HSLA<CGFloat>(color)
        let hsba = HSBA<CGFloat>(color)
        #elseif canImport(CoreGraphics)
        let hsl = try XCTUnwrap(HSL<CGFloat>(color))
        let hsb = try XCTUnwrap(HSB<CGFloat>(color))
        let hsla = try XCTUnwrap(HSLA<CGFloat>(color))
        let hsba = try XCTUnwrap(HSBA<CGFloat>(color))
        #else
        try skipUnavailableAPI()
        #endif

        XCTAssertEqual(hsl.hue, 0.5, accuracy: .ulpOfOne)
        XCTAssertEqual(hsla.hue, 0.5, accuracy: .ulpOfOne)
        XCTAssertEqual(hsl.saturation, HSL(hsb: hsb).saturation, accuracy: .ulpOfOne)
        XCTAssertEqual(hsla.saturation, HSLA(hsba: hsba).saturation, accuracy: .ulpOfOne)
        XCTAssertEqual(hsl.brightness, 0.75, accuracy: .ulpOfOne)
        XCTAssertEqual(hsla.brightness, 0.75, accuracy: .ulpOfOne)
        XCTAssertEqual(hsla.alpha, 0.25)
        XCTAssertNil(HSL<InexactFloat>(exactly: Color(white: 1)))
        XCTAssertNil(HSLA<InexactFloat>(exactly: Color(white: 1)))
        #else
        try skipUnavailableAPI()
        #endif
        #else
        try skipUnavailableAPI()
        #endif
    }

    func testColorCreationWithInteger() throws {
        #if arch(arm64) || arch(x86_64)
        #if canImport(SwiftUI) && canImport(Combine)
        guard #available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
        else { try skipUnavailableAPI() }

        let hsl = HSL<UInt8>(hue: 0x80, saturation: 0x40, luminance: 0xB0)
        let hsla = HSLA(hsl: hsl, alpha: 0x40)

        XCTAssertEqual(Color(hsl), Color(HSL<Double>(hsl)))
        XCTAssertEqual(Color(hsla), Color(HSLA<Double>(hsla)))
        #else
        try skipUnavailableAPI()
        #endif
        #else
        try skipUnavailableAPI()
        #endif
    }

    func testCreationFromColorWithInteger() throws {
        #if arch(arm64) || arch(x86_64)
        #if canImport(SwiftUI) && canImport(Combine)
        guard #available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
        else { try skipUnavailableAPI() }

        let color = Color(hue: 0.5, saturation: 0.25, brightness: 0.75, opacity: 0.25)

        #if canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst))
        let hsl = HSL<UInt8>(color)
        let hsb = HSB<UInt8>(color)
        let hsla = HSLA<UInt8>(color)
        let hsba = HSBA<UInt8>(color)
        #elseif canImport(CoreGraphics)
        let hsl = try XCTUnwrap(HSL<UInt8>(color))
        let hsb = try XCTUnwrap(HSB<UInt8>(color))
        let hsla = try XCTUnwrap(HSLA<UInt8>(color))
        let hsba = try XCTUnwrap(HSBA<UInt8>(color))
        #else
        try skipUnavailableAPI()
        #endif

        XCTAssertEqual(hsl.hue, .init(0.5 * 0xFF))
        XCTAssertEqual(hsla.hue, .init(0.5 * 0xFF))
        XCTAssertEqual(hsl.saturation, HSL(hsb: hsb).saturation, accuracy: 1)
        XCTAssertEqual(hsla.saturation, HSLA(hsba: hsba).saturation, accuracy: 1)
        XCTAssertEqual(hsl.luminance, HSL(hsb: hsb).luminance)
        XCTAssertEqual(hsla.luminance, HSLA(hsba: hsba).luminance)
        XCTAssertEqual(hsla.alpha, .init(0.25 * 0xFF))
        XCTAssertNil(HSL<Int8>(exactly: color))
        XCTAssertNil(HSLA<Int8>(exactly: color))
        #else
        try skipUnavailableAPI()
        #endif
        #else
        try skipUnavailableAPI()
        #endif
    }

    func testViewConformance() throws {
        #if arch(arm64) || arch(x86_64)
        #if canImport(SwiftUI) && canImport(Combine) && (canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst)) || canImport(CoreGraphics))
        guard #available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
        else { try skipUnavailableAPI() }

        let hsl = HSL<Double>(hue: 0.5, saturation: 0.25, luminance: 0.75)
        let hsla = HSLA(hsl: hsl, alpha: 0.25)

        XCTAssertEqual(hsl.body as? Color, Color(hsl))
        XCTAssertEqual(hsla.body as? Color, Color(hsla))
        #else
        try skipUnavailableAPI()
        #endif
        #else
        try skipUnavailableAPI()
        #endif
    }
}
