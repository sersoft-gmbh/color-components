#if canImport(SwiftUI) && canImport(Combine)
import XCTest
import SwiftUI
import ColorComponents

final class BWA_SwiftUITests: XCTestCase {
    func testColorCreation() throws {
        guard #available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
        else { try skipUnavailableAPI() }

        let bw = BW<CGFloat>(white: 0.5)
        let bwa = BWA(bw: bw, alpha: 0.25)

        XCTAssertEqual(Color(bw), Color(white: 0.5, opacity: 1))
        XCTAssertEqual(Color(bwa), Color(white: 0.5, opacity: 0.25))
    }

    func testCreationFromColor() throws {
        guard #available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
        else { try skipUnavailableAPI() }

        let color = Color(white: 0.5, opacity: 0.25)

        #if canImport(UIKit) || (canImport(AppKit) && !targetEnvironment(macCatalyst))
        let bw = BW<CGFloat>(color)
        let bwa = BWA<CGFloat>(color)
        #elseif canImport(CoreGraphics)
        let bw = try XCTUnwrap(BW<CGFloat>(color))
        let bwa = try XCTUnwrap(BWA<CGFloat>(color))
        #else
        try apiUnavailable()
        #endif

        XCTAssertEqual(bw.white, 0.5, accuracy: 0.00001)
        XCTAssertEqual(bwa.white, 0.5, accuracy: 0.00001)
        XCTAssertEqual(bwa.alpha, 0.25)
        XCTAssertNil(BW<InexactFloat>(exactly: Color(white: 1)))
        XCTAssertNil(BWA<InexactFloat>(exactly: Color(white: 1)))
    }
}
#endif
