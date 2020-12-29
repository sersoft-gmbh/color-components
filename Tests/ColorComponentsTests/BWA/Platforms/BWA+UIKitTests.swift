#if canImport(UIKit)
import XCTest
import UIKit
import ColorComponents

final class BWA_UIKitTests: XCTestCase {
    func testUIColorCreation() {
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
    }

    func testCreationFromUIColor() {
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
    }
}
#endif
