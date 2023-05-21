import XCTest
import ColorComponents

final class HSLATests: XCTestCase {
    func testSimpleCreation() {
        let hsl = HSL<UInt8>(hue: 128, saturation: 64, luminance: 32)
        let hsla = HSLA<UInt8>(hsl: hsl, alpha: 0xFF)
        let hsla2 = HSLA<UInt8>(hue: 128, saturation: 64, luminance: 32, alpha: 0xFF)
        XCTAssertEqual(hsl.hue, 128)
        XCTAssertEqual(hsl.saturation, 64)
        XCTAssertEqual(hsl.luminance, 32)
        XCTAssertEqual(hsla.hsl, hsl)
        XCTAssertEqual(hsla.hsl.hue, 128)
        XCTAssertEqual(hsla.hsl.saturation, 64)
        XCTAssertEqual(hsla.hsl.luminance, 32)
        XCTAssertEqual(hsla2.hsl.hue, 128)
        XCTAssertEqual(hsla2.hsl.saturation, 64)
        XCTAssertEqual(hsla2.hsl.luminance, 32)
        XCTAssertEqual(hsla.alpha, 0xFF)
        XCTAssertEqual(hsla2.alpha, 0xFF)
        XCTAssertEqual(hsla, hsla2)
    }

    func testModification() {
        var hsla = HSLA<UInt8>(hue: 128, saturation: 64, luminance: 32, alpha: 0xFF)
        hsla.hue = 120
        hsla.saturation = 60
        hsla.luminance = 30
        XCTAssertEqual(hsla.hue, 120)
        XCTAssertEqual(hsla.hsl.hue, 120)
        XCTAssertEqual(hsla.saturation, 60)
        XCTAssertEqual(hsla.hsl.saturation, 60)
        XCTAssertEqual(hsla.luminance, 30)
        XCTAssertEqual(hsla.hsl.luminance, 30)
    }

    func testIntegerToIntegerConversion() {
        let hsl = HSL<UInt8>(hue: 128, saturation: 64, luminance: 32)
        let hsla = HSLA<UInt8>(hsl: hsl, alpha: 0xFF)

        let hslInt = HSL<Int>(hsl)
        let hslaInt = HSLA<Int>(hsla)

        XCTAssertEqual(hslInt.hue, .init(hsl.hue))
        XCTAssertEqual(hslaInt.hue, .init(hsla.hue))
        XCTAssertEqual(hslInt.saturation, .init(hsl.saturation))
        XCTAssertEqual(hslaInt.saturation, .init(hsla.saturation))
        XCTAssertEqual(hslInt.luminance, .init(hsl.luminance))
        XCTAssertEqual(hslaInt.luminance, .init(hsla.luminance))
        XCTAssertEqual(hslaInt.alpha, .init(hsla.alpha))
    }

    func testExactIntegerToIntegerConversion() {
        let hsl = HSL<UInt8>(hue: 128, saturation: 64, luminance: 32)
        let hsla = HSLA<UInt8>(hsl: hsl, alpha: 0xFF)

        let hslExact = HSL<UInt>(exactly: hsl)
        let hslaExact = HSLA<UInt>(exactly: hsla)

        XCTAssertNil(HSL<Int8>(exactly: hsl))
        XCTAssertNil(HSLA<Int8>(exactly: hsla))
        XCTAssertNotNil(hslExact)
        XCTAssertNotNil(hslaExact)
        XCTAssertEqual(hslExact?.hue, .init(hsl.hue))
        XCTAssertEqual(hslaExact?.hue, .init(hsla.hue))
        XCTAssertEqual(hslExact?.saturation, .init(hsl.saturation))
        XCTAssertEqual(hslaExact?.saturation, .init(hsla.saturation))
        XCTAssertEqual(hslExact?.luminance, .init(hsl.luminance))
        XCTAssertEqual(hslaExact?.luminance, .init(hsla.luminance))
        XCTAssertEqual(hslaExact?.alpha, .init(hsla.alpha))
    }

    func testFloatToIntegerConversion() {
        let hsl = HSL<Float>(hue: 0.5, saturation: 0.25, luminance: 0.125)
        let hsla = HSLA<Float>(hsl: hsl, alpha: 1)

        let hslInt = HSL<Int>(hsl)
        let hslaInt = HSLA<Int>(hsla)

        XCTAssertEqual(hslInt.hue, .init(hsl.hue * 0xFF))
        XCTAssertEqual(hslaInt.hue, .init(hsla.hue * 0xFF))
        XCTAssertEqual(hslInt.saturation, .init(hsl.saturation * 0xFF))
        XCTAssertEqual(hslaInt.saturation, .init(hsla.saturation * 0xFF))
        XCTAssertEqual(hslInt.luminance, .init(hsl.luminance * 0xFF))
        XCTAssertEqual(hslaInt.luminance, .init(hsla.luminance * 0xFF))
        XCTAssertEqual(hslaInt.alpha, .init(hsla.alpha * 0xFF))
    }

    func testExactFloatToIntegerConversion() {
        let hsl = HSL<Float>(hue: 1, saturation: 0, luminance: 1)
        let hsla = HSLA<Float>(hsl: hsl, alpha: 1)

        let hslExact = HSL<UInt8>(exactly: hsl)
        let hslaExact = HSLA<UInt8>(exactly: hsla)

        XCTAssertNil(HSL<Int8>(exactly: hsl))
        XCTAssertNil(HSLA<Int8>(exactly: hsla))
        XCTAssertNotNil(hslExact)
        XCTAssertNotNil(hslaExact)
        XCTAssertEqual(hslExact?.hue, .init(hsl.hue * 0xFF))
        XCTAssertEqual(hslaExact?.hue, .init(hsla.hue * 0xFF))
        XCTAssertEqual(hslExact?.saturation, .init(hsl.saturation * 0xFF))
        XCTAssertEqual(hslaExact?.saturation, .init(hsla.saturation * 0xFF))
        XCTAssertEqual(hslExact?.luminance, .init(hsl.luminance * 0xFF))
        XCTAssertEqual(hslaExact?.luminance, .init(hsla.luminance * 0xFF))
        XCTAssertEqual(hslaExact?.alpha, .init(hsla.alpha * 0xFF))
    }

    func testFloatToFloatConversion() {
        let hsl = HSL<Float>(hue: 0.5, saturation: 0.25, luminance: 0.125)
        let hsla = HSLA<Float>(hsl: hsl, alpha: 1)

        let hslDbl = HSL<Double>(hsl)
        let hslaDbl = HSLA<Double>(hsla)

        XCTAssertEqual(hslDbl.hue, .init(hsl.hue))
        XCTAssertEqual(hslaDbl.hue, .init(hsla.hue))
        XCTAssertEqual(hslDbl.saturation, .init(hsl.saturation))
        XCTAssertEqual(hslaDbl.saturation, .init(hsla.saturation))
        XCTAssertEqual(hslDbl.luminance, .init(hsl.luminance))
        XCTAssertEqual(hslaDbl.luminance, .init(hsla.luminance))
        XCTAssertEqual(hslaDbl.alpha, .init(hsla.alpha))
    }

    func testExactFloatToFloatConversion() {
        let hsl = HSL<Double>(hue: 0.5, saturation: 0.25, luminance: 0.125)
        let hsla = HSLA<Double>(hsl: hsl, alpha: 1)

        let hslExact = HSL<Float>(exactly: hsl)
        let hslaExact = HSLA<Float>(exactly: hsla)

        XCTAssertNil(HSL<InexactFloat>(exactly: hsl))
        XCTAssertNil(HSLA<InexactFloat>(exactly: hsla))
        XCTAssertNotNil(hslExact)
        XCTAssertNotNil(hslaExact)
        XCTAssertEqual(hslExact?.hue, .init(hsl.hue))
        XCTAssertEqual(hslaExact?.hue, .init(hsla.hue))
        XCTAssertEqual(hslExact?.saturation, .init(hsl.saturation))
        XCTAssertEqual(hslaExact?.saturation, .init(hsla.saturation))
        XCTAssertEqual(hslExact?.luminance, .init(hsl.luminance))
        XCTAssertEqual(hslaExact?.luminance, .init(hsla.luminance))
        XCTAssertEqual(hslaExact?.alpha, .init(hsla.alpha))
    }

    func testIntegerToFloatConversion() {
        let hsl = HSL<UInt8>(hue: 128, saturation: 64, luminance: 32)
        let hsla = HSLA<UInt8>(hsl: hsl, alpha: 0xFF)

        let hslInt = HSL<Double>(hsl)
        let hslaInt = HSLA<Double>(hsla)

        XCTAssertEqual(hslInt.hue, .init(hsl.hue) / 0xFF)
        XCTAssertEqual(hslaInt.hue, .init(hsla.hue) / 0xFF)
        XCTAssertEqual(hslInt.saturation, .init(hsl.saturation) / 0xFF)
        XCTAssertEqual(hslaInt.saturation, .init(hsla.saturation) / 0xFF)
        XCTAssertEqual(hslInt.luminance, .init(hsl.luminance) / 0xFF)
        XCTAssertEqual(hslaInt.luminance, .init(hsla.luminance) / 0xFF)
        XCTAssertEqual(hslaInt.alpha, .init(hsla.alpha) / 0xFF)
    }

    func testExactIntegerToFloatConversion() {
        let hsl = HSL<UInt8>(hue: 128, saturation: 64, luminance: 32)
        let hsla = HSLA<UInt8>(hsl: hsl, alpha: 0xFF)

        let hslExact = HSL<Double>(exactly: hsl)
        let hslaExact = HSLA<Double>(exactly: hsla)

        XCTAssertNil(HSL<InexactFloat>(exactly: hsl))
        XCTAssertNil(HSLA<InexactFloat>(exactly: hsla))
        XCTAssertNotNil(hslExact)
        XCTAssertNotNil(hslaExact)
        XCTAssertEqual(hslExact?.hue, .init(hsl.hue) / 0xFF)
        XCTAssertEqual(hslaExact?.hue, .init(hsla.hue) / 0xFF)
        XCTAssertEqual(hslExact?.saturation, .init(hsl.saturation) / 0xFF)
        XCTAssertEqual(hslaExact?.saturation, .init(hsla.saturation) / 0xFF)
        XCTAssertEqual(hslExact?.luminance, .init(hsl.luminance) / 0xFF)
        XCTAssertEqual(hslaExact?.luminance, .init(hsla.luminance) / 0xFF)
        XCTAssertEqual(hslaExact?.alpha, .init(hsla.alpha) / 0xFF)
    }

    func testFloatingPointColorComponentsConformance() {
        var hsl = HSL<Double>(hue: 0.5, saturation: 0.25, luminance: 0.125)
        var hsla = HSLA<Double>(hsl: hsl, alpha: 1)

        hsl.changeBrightness(by: 0.1)
        hsla.changeBrightness(by: 0.1)

        XCTAssertEqual(hsl.luminance, 0.225)
        XCTAssertEqual(hsla.luminance, 0.225)
    }
}
