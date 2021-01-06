import XCTest
import XCHelpers
#if canImport(UIKit)
import UIKit
#endif
import ColorComponents

final class BWA_UIKitTests: XCTestCase {
    func testUIColorCreationWithFloatingPoint() throws {
        #if canImport(UIKit)
        let bw = BW<CGFloat>(white: 0.5)
        let bwa = BWA(bw: bw, alpha: 0.25)

        let opaqueColor = UIColor(bw)
        let alphaColor = UIColor(bwa)

        var (white, alpha) = (CGFloat(), CGFloat())
        XCTAssertTrue(opaqueColor.getWhite(&white, alpha: &alpha))
        XCTAssertEqual(white, bw.white)
        XCTAssertEqual(alpha, 1)
        (white, alpha) = (0, 0)
        XCTAssertTrue(alphaColor.getWhite(&white, alpha: &alpha))
        XCTAssertEqual(white, bwa.white)
        XCTAssertEqual(alpha, bwa.alpha)
        #else
        try skipUnavailableAPI()
        #endif
    }

    func testCreationFromUIColorWithFloatingPoint() throws {
        #if canImport(UIKit)
        let white: CGFloat = 0.5
        let alpha: CGFloat = 0.25
        let color = UIColor(white: white, alpha: alpha)

        let bw = BW<CGFloat>(color)
        let bwa = BWA<CGFloat>(color)

        XCTAssertEqual(bw.white, white)
        XCTAssertEqual(bwa.white, white)
        XCTAssertEqual(bwa.alpha, alpha)
        XCTAssertNil(BW<InexactFloat>(exactly: NoCompsUIColor(white: white, alpha: alpha)))
        XCTAssertNil(BW<InexactFloat>(exactly: NoCompsUIColor(white: white, alpha: alpha)))
        XCTAssertNil(BW<InexactFloat>(exactly: color))
        XCTAssertNil(BW<InexactFloat>(exactly: color))
        #else
        try skipUnavailableAPI()
        #endif
    }

    func testUIColorCreationWithInteger() throws {
        #if canImport(UIKit)
        let bw = BW<UInt8>(white: 0x80)
        let bwa = BWA(bw: bw, alpha: 0x40)

        let opaqueColor = UIColor(bw)
        let alphaColor = UIColor(bwa)

        var (white, alpha) = (CGFloat(), CGFloat())
        XCTAssertTrue(opaqueColor.getWhite(&white, alpha: &alpha))
        XCTAssertEqual(white, .init(bw.white) / 0xFF)
        XCTAssertEqual(alpha, 1)
        (white, alpha) = (0, 0)
        XCTAssertTrue(alphaColor.getWhite(&white, alpha: &alpha))
        XCTAssertEqual(white, .init(bwa.white) / 0xFF)
        XCTAssertEqual(alpha, .init(bwa.alpha) / 0xFF)
        #else
        try skipUnavailableAPI()
        #endif
    }

    func testCreationFromUIColorWithInteger() throws {
        #if canImport(UIKit)
        let white: CGFloat = 0.75
        let alpha: CGFloat = 0.25
        let color = UIColor(white: white, alpha: alpha)

        let bw = BW<UInt8>(color)
        let bwa = BWA<UInt8>(color)

        XCTAssertEqual(bw.white, .init(white * 0xFF))
        XCTAssertEqual(bwa.white, .init(white * 0xFF))
        XCTAssertEqual(bwa.alpha, .init(alpha * 0xFF))
        XCTAssertNil(BW<Int8>(exactly: NoCompsUIColor(white: white, alpha: alpha)))
        XCTAssertNil(BW<Int8>(exactly: NoCompsUIColor(white: white, alpha: alpha)))
        XCTAssertNil(BW<Int8>(exactly: color))
        XCTAssertNil(BW<Int8>(exactly: color))
        #else
        try skipUnavailableAPI()
        #endif
    }
}
