import XCTest
import ColorComponents

final class BWATests: XCTestCase {
    func testSimpleCreation() {
        let bw = BW<UInt8>(white: 128)
        let bwa = BWA<UInt8>(bw: bw, alpha: 0xFF)
        let bwa2 = BWA<UInt8>(white: 128, alpha: 0xFF)
        XCTAssertEqual(bw.white, 128)
        XCTAssertEqual(bwa.bw, bw)
        XCTAssertEqual(bwa.bw.white, 128)
        XCTAssertEqual(bwa2.bw.white, 128)
        XCTAssertEqual(bwa.alpha, 0xFF)
        XCTAssertEqual(bwa2.alpha, 0xFF)
        XCTAssertEqual(bwa, bwa2)
    }

    func testModification() {
        var bwa = BWA<UInt8>(white: 128, alpha: 0xFF)
        bwa.white = 120
        XCTAssertEqual(bwa.white, 120)
        XCTAssertEqual(bwa.bw.white, 120)
    }

    func testIntegerToIntegerConversion() {
        let bw = BW<UInt8>(white: 128)
        let bwa = BWA<UInt8>(bw: bw, alpha: 0xFF)

        let bwInt = BW<Int>(bw)
        let bwaInt = BWA<Int>(bwa)

        XCTAssertEqual(bwInt.white, .init(bw.white))
        XCTAssertEqual(bwaInt.white, .init(bwa.white))
        XCTAssertEqual(bwaInt.alpha, .init(bwa.alpha))
    }

    func testExactIntegerToIntegerConversion() {
        let bw = BW<UInt8>(white: 128)
        let bwa = BWA<UInt8>(bw: bw, alpha: 0xFF)

        let bwExact = BW<UInt>(exactly: bw)
        let bwaExact = BWA<UInt>(exactly: bwa)

        XCTAssertNil(BW<Int8>(exactly: bw))
        XCTAssertNil(BWA<Int8>(exactly: bwa))
        XCTAssertNotNil(bwExact)
        XCTAssertNotNil(bwaExact)
        XCTAssertEqual(bwExact?.white, .init(bw.white))
        XCTAssertEqual(bwaExact?.white, .init(bwa.white))
        XCTAssertEqual(bwaExact?.alpha, .init(bwa.alpha))
    }

    func testFloatToIntegerConversion() {
        let bw = BW<Float>(white: 0.5)
        let bwa = BWA<Float>(bw: bw, alpha: 1)

        let bwInt = BW<Int>(bw)
        let bwaInt = BWA<Int>(bwa)

        XCTAssertEqual(bwInt.white, .init(bw.white * 0xFF))
        XCTAssertEqual(bwaInt.white, .init(bwa.white * 0xFF))
        XCTAssertEqual(bwaInt.alpha, .init(bwa.alpha * 0xFF))
    }

    func testExactFloatToIntegerConversion() {
        let bw = BW<Float>(white: 1)
        let bwa = BWA<Float>(bw: bw, alpha: 1)

        let bwExact = BW<UInt8>(exactly: bw)
        let bwaExact = BWA<UInt8>(exactly: bwa)

        XCTAssertNil(BW<Int8>(exactly: bw))
        XCTAssertNil(BWA<Int8>(exactly: bwa))
        XCTAssertNotNil(bwExact)
        XCTAssertNotNil(bwaExact)
        XCTAssertEqual(bwExact?.white, .init(bw.white * 0xFF))
        XCTAssertEqual(bwaExact?.white, .init(bwa.white * 0xFF))
        XCTAssertEqual(bwaExact?.alpha, .init(bwa.alpha * 0xFF))
    }

    func testFloatToFloatConversion() {
        let bw = BW<Float>(white: 0.5)
        let bwa = BWA<Float>(bw: bw, alpha: 1)

        let bwDbl = BW<Double>(bw)
        let bwaDbl = BWA<Double>(bwa)

        XCTAssertEqual(bwDbl.white, .init(bw.white))
        XCTAssertEqual(bwaDbl.white, .init(bwa.white))
        XCTAssertEqual(bwaDbl.alpha, .init(bwa.alpha))
    }

    func testExactFloatToFloatConversion() {
        let bw = BW<Double>(white: 0.5)
        let bwa = BWA<Double>(bw: bw, alpha: 1)

        let bwExact = BW<Float>(exactly: bw)
        let bwaExact = BWA<Float>(exactly: bwa)

        XCTAssertNil(BW<InexactFloat>(exactly: bw))
        XCTAssertNil(BWA<InexactFloat>(exactly: bwa))
        XCTAssertNotNil(bwExact)
        XCTAssertNotNil(bwaExact)
        XCTAssertEqual(bwExact?.white, .init(bw.white))
        XCTAssertEqual(bwaExact?.white, .init(bwa.white))
        XCTAssertEqual(bwaExact?.alpha, .init(bwa.alpha))
    }

    func testIntegerToFloatConversion() {
        let bw = BW<UInt8>(white: 128)
        let bwa = BWA<UInt8>(bw: bw, alpha: 0xFF)

        let bwInt = BW<Double>(bw)
        let bwaInt = BWA<Double>(bwa)

        XCTAssertEqual(bwInt.white, .init(bw.white) / 0xFF)
        XCTAssertEqual(bwaInt.white, .init(bwa.white) / 0xFF)
        XCTAssertEqual(bwaInt.alpha, .init(bwa.alpha) / 0xFF)
    }

    func testExactIntegerToFloatConversion() {
        let bw = BW<UInt8>(white: 128)
        let bwa = BWA<UInt8>(bw: bw, alpha: 0xFF)

        let bwExact = BW<Double>(exactly: bw)
        let bwaExact = BWA<Double>(exactly: bwa)

        XCTAssertNil(BW<InexactFloat>(exactly: bw))
        XCTAssertNil(BWA<InexactFloat>(exactly: bwa))
        XCTAssertNotNil(bwExact)
        XCTAssertNotNil(bwaExact)
        XCTAssertEqual(bwExact?.white, .init(bw.white) / 0xFF)
        XCTAssertEqual(bwaExact?.white, .init(bwa.white) / 0xFF)
        XCTAssertEqual(bwaExact?.alpha, .init(bwa.alpha) / 0xFF)
    }

    func testFloatingPointColorComponentsConformance() {
        var bw = BW<Double>(white: 0.5)
        var bwa = BWA<Double>(bw: bw, alpha: 1)
        XCTAssertEqual(bw.brightness, bw.white)
        XCTAssertEqual(bwa.brightness, bwa.white)
        bw.changeBrightness(by: 0.1)
        bwa.changeBrightness(by: 0.1)
        XCTAssertEqual(bw.brightness, bw.white)
        XCTAssertEqual(bwa.brightness, bwa.white)
        XCTAssertEqual(bw.brightness, 0.6)
        XCTAssertEqual(bwa.brightness, 0.6)
    }
}
