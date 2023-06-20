import XCTest
import XCHelpers
#if arch(arm64) || arch(x86_64)
#if canImport(SwiftUI) && canImport(Combine)
import SwiftUI
#endif
#endif
import ColorComponents

final class BWA_SwiftUITests: XCTestCase {
    func testColorCreationWithFloatingPoint() throws {
#if arch(arm64) || arch(x86_64)
#if canImport(SwiftUI) && canImport(Combine)
        guard #available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
        else { try skipUnavailableAPI() }

        let bw = BW<Double>(white: 0.5)
        let bwa = BWA(bw: bw, alpha: 0.25)

        XCTAssertEqual(Color(bw), Color(white: 0.5, opacity: 1))
        XCTAssertEqual(Color(bwa), Color(white: 0.5, opacity: 0.25))
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

        let color = Color(white: 0.5, opacity: 0.25)

#if (canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst)))
        let bw = BW<CGFloat>(color)
        let bwa = BWA<CGFloat>(color)
#elseif canImport(CoreGraphics)
        let bw = try XCTUnwrap(BW<CGFloat>(color))
        let bwa = try XCTUnwrap(BWA<CGFloat>(color))
#else
        try skipUnavailableAPI()
#endif

        XCTAssertEqual(bw.white, 0.5, accuracy: 0.00001)
        XCTAssertEqual(bwa.white, 0.5, accuracy: 0.00001)
        XCTAssertEqual(bwa.alpha, 0.25)
        XCTAssertNil(BW<InexactFloat>(exactly: Color(white: 1)))
        XCTAssertNil(BWA<InexactFloat>(exactly: Color(white: 1)))
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

        let bw = BW<UInt8>(white: 0x80)
        let bwa = BWA(bw: bw, alpha: 0x40)

        XCTAssertEqual(Color(bw), Color(white: 0x80 / 0xFF, opacity: 1))
        XCTAssertEqual(Color(bwa), Color(white: 0x80 / 0xFF, opacity: 0x40 / 0xFF))
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

        let color = Color(white: 0.75, opacity: 0.25)

#if (canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst)))
        let bw = BW<UInt8>(color)
        let bwa = BWA<UInt8>(color)
#elseif canImport(CoreGraphics)
        let bw = try XCTUnwrap(BW<UInt8>(color))
        let bwa = try XCTUnwrap(BWA<UInt8>(color))
#else
        try skipUnavailableAPI()
#endif

        XCTAssertEqual(bw.white, 0xBF)
        XCTAssertEqual(bwa.white, 0xBF)
        XCTAssertEqual(bwa.alpha, 0x3F)
        XCTAssertNil(BW<Int8>(exactly: Color(white: 1)))
        XCTAssertNil(BWA<Int8>(exactly: Color(white: 1)))
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

        let bw = BW<Double>(white: 0.5)
        let bwa = BWA(bw: bw, alpha: 0.25)

        XCTAssertEqual(bw.body as? Color, Color(bw))
        XCTAssertEqual(bwa.body as? Color, Color(bwa))
#else
        try skipUnavailableAPI()
#endif
#else
        try skipUnavailableAPI()
#endif
    }
}
