import XCTest
import ColorComponents

final class RGBATests: XCTestCase {
    func testSimpleCreation() {
        let rgb = RGB<UInt8>(red: 128, green: 64, blue: 32)
        let rgba = RGBA<UInt8>(rgb: rgb, alpha: 0xFF)
        let rgba2 = RGBA<UInt8>(red: 128, green: 64, blue: 32, alpha: 0xFF)
        XCTAssertEqual(rgb.red, 128)
        XCTAssertEqual(rgb.green, 64)
        XCTAssertEqual(rgb.blue, 32)
        XCTAssertEqual(rgba.rgb, rgb)
        XCTAssertEqual(rgba.rgb.red, 128)
        XCTAssertEqual(rgba.rgb.green, 64)
        XCTAssertEqual(rgba.rgb.blue, 32)
        XCTAssertEqual(rgba2.rgb.red, 128)
        XCTAssertEqual(rgba2.rgb.green, 64)
        XCTAssertEqual(rgba2.rgb.blue, 32)
        XCTAssertEqual(rgba.alpha, 0xFF)
        XCTAssertEqual(rgba2.alpha, 0xFF)
        XCTAssertEqual(rgba, rgba2)
    }

    func testModification() {
        var rgba = RGBA<UInt8>(red: 128, green: 64, blue: 32, alpha: 0xFF)
        rgba.red = 120
        rgba.green = 60
        rgba.blue = 30
        XCTAssertEqual(rgba.red, 120)
        XCTAssertEqual(rgba.rgb.red, 120)
        XCTAssertEqual(rgba.green, 60)
        XCTAssertEqual(rgba.rgb.green, 60)
        XCTAssertEqual(rgba.blue, 30)
        XCTAssertEqual(rgba.rgb.blue, 30)
    }

    func testIntegerToIntegerConversion() {
        let rgb = RGB<UInt8>(red: 128, green: 64, blue: 32)
        let rgba = RGBA<UInt8>(rgb: rgb, alpha: 0xFF)

        let rgbInt = RGB<Int>(rgb)
        let rgbaInt = RGBA<Int>(rgba)

        XCTAssertEqual(rgbInt.red, .init(rgb.red))
        XCTAssertEqual(rgbaInt.red, .init(rgba.red))
        XCTAssertEqual(rgbInt.green, .init(rgb.green))
        XCTAssertEqual(rgbaInt.green, .init(rgba.green))
        XCTAssertEqual(rgbInt.blue, .init(rgb.blue))
        XCTAssertEqual(rgbaInt.blue, .init(rgba.blue))
        XCTAssertEqual(rgbaInt.alpha, .init(rgba.alpha))
    }

    func testExactIntegerToIntegerConversion() {
        let rgb = RGB<UInt8>(red: 128, green: 64, blue: 32)
        let rgba = RGBA<UInt8>(rgb: rgb, alpha: 0xFF)

        let rgbExact = RGB<UInt>(exactly: rgb)
        let rgbaExact = RGBA<UInt>(exactly: rgba)

        XCTAssertNil(RGB<Int8>(exactly: rgb))
        XCTAssertNil(RGBA<Int8>(exactly: rgba))
        XCTAssertNotNil(rgbExact)
        XCTAssertNotNil(rgbaExact)
        XCTAssertEqual(rgbExact?.red, .init(rgb.red))
        XCTAssertEqual(rgbaExact?.red, .init(rgba.red))
        XCTAssertEqual(rgbExact?.green, .init(rgb.green))
        XCTAssertEqual(rgbaExact?.green, .init(rgba.green))
        XCTAssertEqual(rgbExact?.blue, .init(rgb.blue))
        XCTAssertEqual(rgbaExact?.blue, .init(rgba.blue))
        XCTAssertEqual(rgbaExact?.alpha, .init(rgba.alpha))
    }

    func testFloatToIntegerConversion() {
        let rgb = RGB<Float>(red: 0.5, green: 0.25, blue: 0.125)
        let rgba = RGBA<Float>(rgb: rgb, alpha: 1)

        let rgbInt = RGB<Int>(rgb)
        let rgbaInt = RGBA<Int>(rgba)

        XCTAssertEqual(rgbInt.red, .init(rgb.red * 0xFF))
        XCTAssertEqual(rgbaInt.red, .init(rgba.red * 0xFF))
        XCTAssertEqual(rgbInt.green, .init(rgb.green * 0xFF))
        XCTAssertEqual(rgbaInt.green, .init(rgba.green * 0xFF))
        XCTAssertEqual(rgbInt.blue, .init(rgb.blue * 0xFF))
        XCTAssertEqual(rgbaInt.blue, .init(rgba.blue * 0xFF))
        XCTAssertEqual(rgbaInt.alpha, .init(rgba.alpha * 0xFF))
    }

    func testExactFloatToIntegerConversion() {
        let rgb = RGB<Float>(red: 1, green: 0, blue: 1)
        let rgba = RGBA<Float>(rgb: rgb, alpha: 1)

        let rgbExact = RGB<UInt8>(exactly: rgb)
        let rgbaExact = RGBA<UInt8>(exactly: rgba)

        XCTAssertNil(RGB<Int8>(exactly: rgb))
        XCTAssertNil(RGBA<Int8>(exactly: rgba))
        XCTAssertNotNil(rgbExact)
        XCTAssertNotNil(rgbaExact)
        XCTAssertEqual(rgbExact?.red, .init(rgb.red * 0xFF))
        XCTAssertEqual(rgbaExact?.red, .init(rgba.red * 0xFF))
        XCTAssertEqual(rgbExact?.green, .init(rgb.green * 0xFF))
        XCTAssertEqual(rgbaExact?.green, .init(rgba.green * 0xFF))
        XCTAssertEqual(rgbExact?.blue, .init(rgb.blue * 0xFF))
        XCTAssertEqual(rgbaExact?.blue, .init(rgba.blue * 0xFF))
        XCTAssertEqual(rgbaExact?.alpha, .init(rgba.alpha * 0xFF))
    }

    func testFloatToFloatConversion() {
        let rgb = RGB<Float>(red: 0.5, green: 0.25, blue: 0.125)
        let rgba = RGBA<Float>(rgb: rgb, alpha: 1)

        let rgbDbl = RGB<Double>(rgb)
        let rgbaDbl = RGBA<Double>(rgba)

        XCTAssertEqual(rgbDbl.red, .init(rgb.red))
        XCTAssertEqual(rgbaDbl.red, .init(rgba.red))
        XCTAssertEqual(rgbDbl.green, .init(rgb.green))
        XCTAssertEqual(rgbaDbl.green, .init(rgba.green))
        XCTAssertEqual(rgbDbl.blue, .init(rgb.blue))
        XCTAssertEqual(rgbaDbl.blue, .init(rgba.blue))
        XCTAssertEqual(rgbaDbl.alpha, .init(rgba.alpha))
    }

    func testExactFloatToFloatConversion() {
        let rgb = RGB<Double>(red: 0.5, green: 0.25, blue: 0.125)
        let rgba = RGBA<Double>(rgb: rgb, alpha: 1)

        let rgbExact = RGB<Float>(exactly: rgb)
        let rgbaExact = RGBA<Float>(exactly: rgba)

        XCTAssertNil(RGB<InexactFloat>(exactly: rgb))
        XCTAssertNil(RGBA<InexactFloat>(exactly: rgba))
        XCTAssertNotNil(rgbExact)
        XCTAssertNotNil(rgbaExact)
        XCTAssertEqual(rgbExact?.red, .init(rgb.red))
        XCTAssertEqual(rgbaExact?.red, .init(rgba.red))
        XCTAssertEqual(rgbExact?.green, .init(rgb.green))
        XCTAssertEqual(rgbaExact?.green, .init(rgba.green))
        XCTAssertEqual(rgbExact?.blue, .init(rgb.blue))
        XCTAssertEqual(rgbaExact?.blue, .init(rgba.blue))
        XCTAssertEqual(rgbaExact?.alpha, .init(rgba.alpha))
    }

    func testIntegerToFloatConversion() {
        let rgb = RGB<UInt8>(red: 128, green: 64, blue: 32)
        let rgba = RGBA<UInt8>(rgb: rgb, alpha: 0xFF)

        let rgbInt = RGB<Double>(rgb)
        let rgbaInt = RGBA<Double>(rgba)

        XCTAssertEqual(rgbInt.red, .init(rgb.red) / 0xFF)
        XCTAssertEqual(rgbaInt.red, .init(rgba.red) / 0xFF)
        XCTAssertEqual(rgbInt.green, .init(rgb.green) / 0xFF)
        XCTAssertEqual(rgbaInt.green, .init(rgba.green) / 0xFF)
        XCTAssertEqual(rgbInt.blue, .init(rgb.blue) / 0xFF)
        XCTAssertEqual(rgbaInt.blue, .init(rgba.blue) / 0xFF)
        XCTAssertEqual(rgbaInt.alpha, .init(rgba.alpha) / 0xFF)
    }

    func testExactIntegerToFloatConversion() {
        let rgb = RGB<UInt8>(red: 128, green: 64, blue: 32)
        let rgba = RGBA<UInt8>(rgb: rgb, alpha: 0xFF)

        let rgbExact = RGB<Double>(exactly: rgb)
        let rgbaExact = RGBA<Double>(exactly: rgba)

        XCTAssertNil(RGB<InexactFloat>(exactly: rgb))
        XCTAssertNil(RGBA<InexactFloat>(exactly: rgba))
        XCTAssertNotNil(rgbExact)
        XCTAssertNotNil(rgbaExact)
        XCTAssertEqual(rgbExact?.red, .init(rgb.red) / 0xFF)
        XCTAssertEqual(rgbaExact?.red, .init(rgba.red) / 0xFF)
        XCTAssertEqual(rgbExact?.green, .init(rgb.green) / 0xFF)
        XCTAssertEqual(rgbaExact?.green, .init(rgba.green) / 0xFF)
        XCTAssertEqual(rgbExact?.blue, .init(rgb.blue) / 0xFF)
        XCTAssertEqual(rgbaExact?.blue, .init(rgba.blue) / 0xFF)
        XCTAssertEqual(rgbaExact?.alpha, .init(rgba.alpha) / 0xFF)
    }

    func testFloatingPointColorComponentsConformance() {
        var rgb = RGB<Double>(red: 0.5, green: 0.25, blue: 0.125)
        var rgba = RGBA<Double>(rgb: rgb, alpha: 0.75)

        let oldBrightness = rgb.brightness
        XCTAssertEqual(rgb.brightness, rgb.red * 0.299 + rgb.green * 0.587 + rgb.blue * 0.114)
        XCTAssertEqual(rgba.brightness, rgb.brightness)

        rgb.changeBrightness(by: 0.1)
        rgba.changeBrightness(by: 0.1)

        XCTAssertEqual(rgb.red, 0.6)
        XCTAssertEqual(rgb.green, 0.35)
        XCTAssertEqual(rgb.blue, 0.225)
        XCTAssertEqual(rgba.rgb, rgb)
        XCTAssertEqual(rgba.alpha, 0.75)
        XCTAssertEqual(rgb.brightness, oldBrightness + 0.1, accuracy: 0.0001)
        XCTAssertEqual(rgba.brightness, oldBrightness + 0.1, accuracy: 0.0001)
    }
}
