import XCTest
import ColorComponents

final class HSBATests: XCTestCase {
    func testSimpleCreation() {
        let hsb = HSB<UInt8>(hue: 128, saturation: 64, brightness: 32)
        let hsba = HSBA<UInt8>(hsb: hsb, alpha: 0xFF)
        let hsba2 = HSBA<UInt8>(hue: 128, saturation: 64, brightness: 32, alpha: 0xFF)
        XCTAssertEqual(hsb.hue, 128)
        XCTAssertEqual(hsb.saturation, 64)
        XCTAssertEqual(hsb.brightness, 32)
        XCTAssertEqual(hsba.hsb, hsb)
        XCTAssertEqual(hsba.hsb.hue, 128)
        XCTAssertEqual(hsba.hsb.saturation, 64)
        XCTAssertEqual(hsba.hsb.brightness, 32)
        XCTAssertEqual(hsba2.hsb.hue, 128)
        XCTAssertEqual(hsba2.hsb.saturation, 64)
        XCTAssertEqual(hsba2.hsb.brightness, 32)
        XCTAssertEqual(hsba.alpha, 0xFF)
        XCTAssertEqual(hsba2.alpha, 0xFF)
        XCTAssertEqual(hsba, hsba2)
    }

    func testModification() {
        var hsba = HSBA<UInt8>(hue: 128, saturation: 64, brightness: 32, alpha: 0xFF)
        hsba.hue = 120
        hsba.saturation = 60
        hsba.brightness = 30
        XCTAssertEqual(hsba.hue, 120)
        XCTAssertEqual(hsba.hsb.hue, 120)
        XCTAssertEqual(hsba.saturation, 60)
        XCTAssertEqual(hsba.hsb.saturation, 60)
        XCTAssertEqual(hsba.brightness, 30)
        XCTAssertEqual(hsba.hsb.brightness, 30)
    }

    func testIntegerToIntegerConversion() {
        let hsb = HSB<UInt8>(hue: 128, saturation: 64, brightness: 32)
        let hsba = HSBA<UInt8>(hsb: hsb, alpha: 0xFF)

        let hsbInt = HSB<Int>(hsb)
        let hsbaInt = HSBA<Int>(hsba)

        XCTAssertEqual(hsbInt.hue, .init(hsb.hue))
        XCTAssertEqual(hsbaInt.hue, .init(hsba.hue))
        XCTAssertEqual(hsbInt.saturation, .init(hsb.saturation))
        XCTAssertEqual(hsbaInt.saturation, .init(hsba.saturation))
        XCTAssertEqual(hsbInt.brightness, .init(hsb.brightness))
        XCTAssertEqual(hsbaInt.brightness, .init(hsba.brightness))
        XCTAssertEqual(hsbaInt.alpha, .init(hsba.alpha))
    }

    func testExactIntegerToIntegerConversion() {
        let hsb = HSB<UInt8>(hue: 128, saturation: 64, brightness: 32)
        let hsba = HSBA<UInt8>(hsb: hsb, alpha: 0xFF)

        let hsbExact = HSB<UInt>(exactly: hsb)
        let hsbaExact = HSBA<UInt>(exactly: hsba)

        XCTAssertNil(HSB<Int8>(exactly: hsb))
        XCTAssertNil(HSBA<Int8>(exactly: hsba))
        XCTAssertNotNil(hsbExact)
        XCTAssertNotNil(hsbaExact)
        XCTAssertEqual(hsbExact?.hue, .init(hsb.hue))
        XCTAssertEqual(hsbaExact?.hue, .init(hsba.hue))
        XCTAssertEqual(hsbExact?.saturation, .init(hsb.saturation))
        XCTAssertEqual(hsbaExact?.saturation, .init(hsba.saturation))
        XCTAssertEqual(hsbExact?.brightness, .init(hsb.brightness))
        XCTAssertEqual(hsbaExact?.brightness, .init(hsba.brightness))
        XCTAssertEqual(hsbaExact?.alpha, .init(hsba.alpha))
    }

    func testFloatToIntegerConversion() {
        let hsb = HSB<Float>(hue: 0.5, saturation: 0.25, brightness: 0.125)
        let hsba = HSBA<Float>(hsb: hsb, alpha: 1)

        let hsbInt = HSB<Int>(hsb)
        let hsbaInt = HSBA<Int>(hsba)

        XCTAssertEqual(hsbInt.hue, .init(hsb.hue * 0xFF))
        XCTAssertEqual(hsbaInt.hue, .init(hsba.hue * 0xFF))
        XCTAssertEqual(hsbInt.saturation, .init(hsb.saturation * 0xFF))
        XCTAssertEqual(hsbaInt.saturation, .init(hsba.saturation * 0xFF))
        XCTAssertEqual(hsbInt.brightness, .init(hsb.brightness * 0xFF))
        XCTAssertEqual(hsbaInt.brightness, .init(hsba.brightness * 0xFF))
        XCTAssertEqual(hsbaInt.alpha, .init(hsba.alpha * 0xFF))
    }

    func testExactFloatToIntegerConversion() {
        let hsb = HSB<Float>(hue: 1, saturation: 0, brightness: 1)
        let hsba = HSBA<Float>(hsb: hsb, alpha: 1)

        let hsbExact = HSB<UInt8>(exactly: hsb)
        let hsbaExact = HSBA<UInt8>(exactly: hsba)

        XCTAssertNil(HSB<Int8>(exactly: hsb))
        XCTAssertNil(HSBA<Int8>(exactly: hsba))
        XCTAssertNotNil(hsbExact)
        XCTAssertNotNil(hsbaExact)
        XCTAssertEqual(hsbExact?.hue, .init(hsb.hue * 0xFF))
        XCTAssertEqual(hsbaExact?.hue, .init(hsba.hue * 0xFF))
        XCTAssertEqual(hsbExact?.saturation, .init(hsb.saturation * 0xFF))
        XCTAssertEqual(hsbaExact?.saturation, .init(hsba.saturation * 0xFF))
        XCTAssertEqual(hsbExact?.brightness, .init(hsb.brightness * 0xFF))
        XCTAssertEqual(hsbaExact?.brightness, .init(hsba.brightness * 0xFF))
        XCTAssertEqual(hsbaExact?.alpha, .init(hsba.alpha * 0xFF))
    }

    func testFloatToFloatConversion() {
        let hsb = HSB<Float>(hue: 0.5, saturation: 0.25, brightness: 0.125)
        let hsba = HSBA<Float>(hsb: hsb, alpha: 1)

        let hsbDbl = HSB<Double>(hsb)
        let hsbaDbl = HSBA<Double>(hsba)

        XCTAssertEqual(hsbDbl.hue, .init(hsb.hue))
        XCTAssertEqual(hsbaDbl.hue, .init(hsba.hue))
        XCTAssertEqual(hsbDbl.saturation, .init(hsb.saturation))
        XCTAssertEqual(hsbaDbl.saturation, .init(hsba.saturation))
        XCTAssertEqual(hsbDbl.brightness, .init(hsb.brightness))
        XCTAssertEqual(hsbaDbl.brightness, .init(hsba.brightness))
        XCTAssertEqual(hsbaDbl.alpha, .init(hsba.alpha))
    }

    func testExactFloatToFloatConversion() {
        let hsb = HSB<Double>(hue: 0.5, saturation: 0.25, brightness: 0.125)
        let hsba = HSBA<Double>(hsb: hsb, alpha: 1)

        let hsbExact = HSB<Float>(exactly: hsb)
        let hsbaExact = HSBA<Float>(exactly: hsba)

        XCTAssertNil(HSB<InexactFloat>(exactly: hsb))
        XCTAssertNil(HSBA<InexactFloat>(exactly: hsba))
        XCTAssertNotNil(hsbExact)
        XCTAssertNotNil(hsbaExact)
        XCTAssertEqual(hsbExact?.hue, .init(hsb.hue))
        XCTAssertEqual(hsbaExact?.hue, .init(hsba.hue))
        XCTAssertEqual(hsbExact?.saturation, .init(hsb.saturation))
        XCTAssertEqual(hsbaExact?.saturation, .init(hsba.saturation))
        XCTAssertEqual(hsbExact?.brightness, .init(hsb.brightness))
        XCTAssertEqual(hsbaExact?.brightness, .init(hsba.brightness))
        XCTAssertEqual(hsbaExact?.alpha, .init(hsba.alpha))
    }

    func testIntegerToFloatConversion() {
        let hsb = HSB<UInt8>(hue: 128, saturation: 64, brightness: 32)
        let hsba = HSBA<UInt8>(hsb: hsb, alpha: 0xFF)

        let hsbInt = HSB<Double>(hsb)
        let hsbaInt = HSBA<Double>(hsba)

        XCTAssertEqual(hsbInt.hue, .init(hsb.hue) / 0xFF)
        XCTAssertEqual(hsbaInt.hue, .init(hsba.hue) / 0xFF)
        XCTAssertEqual(hsbInt.saturation, .init(hsb.saturation) / 0xFF)
        XCTAssertEqual(hsbaInt.saturation, .init(hsba.saturation) / 0xFF)
        XCTAssertEqual(hsbInt.brightness, .init(hsb.brightness) / 0xFF)
        XCTAssertEqual(hsbaInt.brightness, .init(hsba.brightness) / 0xFF)
        XCTAssertEqual(hsbaInt.alpha, .init(hsba.alpha) / 0xFF)
    }

    func testExactIntegerToFloatConversion() {
        let hsb = HSB<UInt8>(hue: 128, saturation: 64, brightness: 32)
        let hsba = HSBA<UInt8>(hsb: hsb, alpha: 0xFF)

        let hsbExact = HSB<Double>(exactly: hsb)
        let hsbaExact = HSBA<Double>(exactly: hsba)

        XCTAssertNil(HSB<InexactFloat>(exactly: hsb))
        XCTAssertNil(HSBA<InexactFloat>(exactly: hsba))
        XCTAssertNotNil(hsbExact)
        XCTAssertNotNil(hsbaExact)
        XCTAssertEqual(hsbExact?.hue, .init(hsb.hue) / 0xFF)
        XCTAssertEqual(hsbaExact?.hue, .init(hsba.hue) / 0xFF)
        XCTAssertEqual(hsbExact?.saturation, .init(hsb.saturation) / 0xFF)
        XCTAssertEqual(hsbaExact?.saturation, .init(hsba.saturation) / 0xFF)
        XCTAssertEqual(hsbExact?.brightness, .init(hsb.brightness) / 0xFF)
        XCTAssertEqual(hsbaExact?.brightness, .init(hsba.brightness) / 0xFF)
        XCTAssertEqual(hsbaExact?.alpha, .init(hsba.alpha) / 0xFF)
    }

    func testFloatingPointColorComponentsConformance() {
        var hsb = HSB<Double>(hue: 0.5, saturation: 0.25, brightness: 0.125)
        var hsba = HSBA<Double>(hsb: hsb, alpha: 1)

        hsb.changeBrightness(by: 0.1)
        hsba.changeBrightness(by: 0.1)

        XCTAssertEqual(hsb.brightness, 0.225)
        XCTAssertEqual(hsba.brightness, 0.225)
    }
}
