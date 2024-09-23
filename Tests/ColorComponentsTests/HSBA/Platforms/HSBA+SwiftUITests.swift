import XCTest
import XCHelpers
#if arch(arm64) || arch(x86_64)
#if canImport(SwiftUI) && canImport(Combine)
import SwiftUI
#endif
#endif
import ColorComponents

final class HSBA_SwiftUITests: XCTestCase {
    func testColorCreationWithFloatingPoint() throws {
#if arch(arm64) || arch(x86_64)
#if canImport(SwiftUI) && canImport(Combine)
        guard #available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
        else { try skipUnavailableAPI() }

        let hsb = HSB<Double>(hue: 0.5, saturation: 0.25, brightness: 0.75)
        let hsba = HSBA(hsb: hsb, alpha: 0.25)

        XCTAssertEqual(Color(hsb), Color(hue: 0.5, saturation: 0.25, brightness: 0.75, opacity: 1))
        XCTAssertEqual(Color(hsba), Color(hue: 0.5, saturation: 0.25, brightness: 0.75, opacity: 0.25))
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
        let hsb = HSB<CGFloat>(color)
        let hsba = HSBA<CGFloat>(color)
#elseif canImport(CoreGraphics)
        let hsb = try XCTUnwrap(HSB<CGFloat>(color))
        let hsba = try XCTUnwrap(HSBA<CGFloat>(color))
#else
        try skipUnavailableAPI()
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

        let hsb = HSB<UInt8>(hue: 0x80, saturation: 0x40, brightness: 0xB0)
        let hsba = HSBA(hsb: hsb, alpha: 0x40)

        XCTAssertEqual(Color(hsb),
                       Color(hue: .init(hsb.hue) / 0xFF,
                             saturation: .init(hsb.saturation) / 0xFF,
                             brightness: .init(hsb.brightness) / 0xFF,
                             opacity: 1))
        XCTAssertEqual(Color(hsba),
                       Color(hue: .init(hsba.hue) / 0xFF,
                             saturation: .init(hsba.saturation) / 0xFF,
                             brightness: .init(hsba.brightness) / 0xFF,
                             opacity: .init(hsba.alpha) / 0xFF))
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
        let hsb = HSB<UInt8>(color)
        let hsba = HSBA<UInt8>(color)
#elseif canImport(CoreGraphics)
        let hsb = try XCTUnwrap(HSB<UInt8>(color))
        let hsba = try XCTUnwrap(HSBA<UInt8>(color))
#else
        try skipUnavailableAPI()
#endif

        XCTAssertEqual(hsb.hue, .init(0.5 * 0xFF))
        XCTAssertEqual(hsba.hue, .init(0.5 * 0xFF))
        XCTAssertEqual(hsb.saturation, .init(0.25 * 0xFF))
        XCTAssertEqual(hsba.saturation, .init(0.25 * 0xFF))
        XCTAssertEqual(hsb.brightness, .init(0.75 * 0xFF))
        XCTAssertEqual(hsba.brightness, .init(0.75 * 0xFF))
        XCTAssertEqual(hsba.alpha, .init(0.25 * 0xFF))
        XCTAssertNil(HSB<Int8>(exactly: color))
        XCTAssertNil(HSBA<Int8>(exactly: color))
#else
        try skipUnavailableAPI()
#endif
#else
        try skipUnavailableAPI()
#endif
    }

    func testViewConformance() async throws {
#if arch(arm64) || arch(x86_64)
#if canImport(SwiftUI) && canImport(Combine) && (canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst)) || canImport(CoreGraphics))
        guard #available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
        else { try skipUnavailableAPI() }

        let hsb = HSB<Double>(hue: 0.5, saturation: 0.25, brightness: 0.75)
        let hsba = HSBA(hsb: hsb, alpha: 0.25)

        await MainActor.run {
            XCTAssertBody(of: hsb, equals: Color(hsb))
            XCTAssertBody(of: hsba, equals: Color(hsba))
        }
#else
        try skipUnavailableAPI()
#endif
#else
        try skipUnavailableAPI()
#endif
    }
}
