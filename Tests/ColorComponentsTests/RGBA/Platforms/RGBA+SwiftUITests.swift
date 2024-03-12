import XCTest
#if arch(arm64) || arch(x86_64)
#if canImport(SwiftUI) && canImport(Combine)
import SwiftUI
#endif
#endif
import ColorComponents

final class RGBA_SwiftUITests: XCTestCase {
    func testColorCreationWithFloatingPoint() throws {
#if arch(arm64) || arch(x86_64)
#if canImport(SwiftUI) && canImport(Combine)
        guard #available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
        else { try skipUnavailableAPI() }

        let rgb = RGB<Double>(red: 0.5, green: 0.25, blue: 0.75)
        let rgba = RGBA(rgb: rgb, alpha: 0.25)

        XCTAssertEqual(Color(rgb), Color(red: 0.5, green: 0.25, blue: 0.75, opacity: 1))
        XCTAssertEqual(Color(rgba), Color(red: 0.5, green: 0.25, blue: 0.75, opacity: 0.25))
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

        let color = Color(red: 0.5, green: 0.25, blue: 0.75, opacity: 0.25)

#if canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst))
        let rgb = RGB<CGFloat>(color)
        let rgba = RGBA<CGFloat>(color)
#elseif canImport(CoreGraphics)
        let rgb = try XCTUnwrap(RGB<CGFloat>(color))
        let rgba = try XCTUnwrap(RGBA<CGFloat>(color))
#else
        try skipUnavailableAPI()
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

        let rgb = RGB<UInt8>(red: 0x80, green: 0x40, blue: 0xB0)
        let rgba = RGBA(rgb: rgb, alpha: 0x40)

        XCTAssertEqual(Color(rgb),
                       Color(red: .init(rgb.red) / 0xFF,
                             green: .init(rgb.green) / 0xFF,
                             blue: .init(rgb.blue) / 0xFF,
                             opacity: 1))
        XCTAssertEqual(Color(rgba),
                       Color(red: .init(rgba.red) / 0xFF,
                             green: .init(rgba.green) / 0xFF,
                             blue: .init(rgba.blue) / 0xFF,
                             opacity: .init(rgba.alpha) / 0xFF))
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

        let color = Color(red: 0.5, green: 0.25, blue: 0.75, opacity: 0.25)

#if canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst))
        let rgb = RGB<UInt8>(color)
        let rgba = RGBA<UInt8>(color)
#elseif canImport(CoreGraphics)
        let rgb = try XCTUnwrap(RGB<UInt8>(color))
        let rgba = try XCTUnwrap(RGBA<UInt8>(color))
#else
        try skipUnavailableAPI()
#endif

        XCTAssertEqual(rgb.red, .init(0.5 * 0xFF))
        XCTAssertEqual(rgba.red, .init(0.5 * 0xFF))
        XCTAssertEqual(rgb.green, .init(0.25 * 0xFF))
        XCTAssertEqual(rgba.green, .init(0.25 * 0xFF))
        XCTAssertEqual(rgb.blue, .init(0.75 * 0xFF))
        XCTAssertEqual(rgba.blue, .init(0.75 * 0xFF))
        XCTAssertEqual(rgba.alpha, .init(0.25 * 0xFF))
        XCTAssertNil(RGB<Int8>(exactly: Color(white: 1)))
        XCTAssertNil(RGBA<Int8>(exactly: Color(white: 1)))
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

        let rgb = RGB<Double>(red: 0.5, green: 0.25, blue: 0.75)
        let rgba = RGBA(rgb: rgb, alpha: 0.25)

        await MainActor.run {
            XCTAssertEqual(rgb.body as? Color, Color(rgb))
            XCTAssertEqual(rgba.body as? Color, Color(rgba))
        }
#else
        try skipUnavailableAPI()
#endif
#else
        try skipUnavailableAPI()
#endif
    }
}
