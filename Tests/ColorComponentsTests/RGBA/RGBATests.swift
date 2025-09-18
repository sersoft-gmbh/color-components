import Testing
import Numerics
import ColorComponents

@Suite
struct RGBATests {
    @Test
    func simpleCreation() {
        let rgb = RGB<UInt8>(red: 128, green: 64, blue: 32)
        let rgba = RGBA<UInt8>(rgb: rgb, alpha: 0xFF)
        let rgba2 = RGBA<UInt8>(red: 128, green: 64, blue: 32, alpha: 0xFF)
        #expect(rgb.red == 128)
        #expect(rgb.green == 64)
        #expect(rgb.blue == 32)
        #expect(rgba.rgb == rgb)
        #expect(rgba.rgb.red == 128)
        #expect(rgba.rgb.green == 64)
        #expect(rgba.rgb.blue == 32)
        #expect(rgba2.rgb.red == 128)
        #expect(rgba2.rgb.green == 64)
        #expect(rgba2.rgb.blue == 32)
        #expect(rgba.alpha == 0xFF)
        #expect(rgba2.alpha == 0xFF)
        #expect(rgba == rgba2)
    }

    @Test
    func modification() {
        var rgba = RGBA<UInt8>(red: 128, green: 64, blue: 32, alpha: 0xFF)
        rgba.red = 120
        rgba.green = 60
        rgba.blue = 30
        #expect(rgba.red == 120)
        #expect(rgba.rgb.red == 120)
        #expect(rgba.green == 60)
        #expect(rgba.rgb.green == 60)
        #expect(rgba.blue == 30)
        #expect(rgba.rgb.blue == 30)
    }

    @Test
    func integerToIntegerConversion() {
        let rgb = RGB<UInt8>(red: 128, green: 64, blue: 32)
        let rgba = RGBA<UInt8>(rgb: rgb, alpha: 0xFF)

        let rgbInt = RGB<Int>(rgb)
        let rgbaInt = RGBA<Int>(rgba)

        #expect(rgbInt.red == Int(rgb.red))
        #expect(rgbaInt.red == Int(rgba.red))
        #expect(rgbInt.green == Int(rgb.green))
        #expect(rgbaInt.green == Int(rgba.green))
        #expect(rgbInt.blue == Int(rgb.blue))
        #expect(rgbaInt.blue == Int(rgba.blue))
        #expect(rgbaInt.alpha == Int(rgba.alpha))
    }

    @Test
    func exactIntegerToIntegerConversion() throws {
        let rgb = RGB<UInt8>(red: 128, green: 64, blue: 32)
        let rgba = RGBA<UInt8>(rgb: rgb, alpha: 0xFF)

        #expect(RGB<Int8>(exactly: rgb) == nil)
        #expect(RGBA<Int8>(exactly: rgba) == nil)

        let rgbExact = try #require(RGB<UInt>(exactly: rgb))
        let rgbaExact = try #require(RGBA<UInt>(exactly: rgba))

        #expect(rgbExact.red == UInt(rgb.red))
        #expect(rgbaExact.red == UInt(rgba.red))
        #expect(rgbExact.green == UInt(rgb.green))
        #expect(rgbaExact.green == UInt(rgba.green))
        #expect(rgbExact.blue == UInt(rgb.blue))
        #expect(rgbaExact.blue == UInt(rgba.blue))
        #expect(rgbaExact.alpha == UInt(rgba.alpha))
    }

    @Test
    func floatToIntegerConversion() {
        let rgb = RGB<Float>(red: 0.5, green: 0.25, blue: 0.125)
        let rgba = RGBA<Float>(rgb: rgb, alpha: 1)

        let rgbInt = RGB<Int>(rgb)
        let rgbaInt = RGBA<Int>(rgba)

        #expect(rgbInt.red == Int(rgb.red * 0xFF))
        #expect(rgbaInt.red == Int(rgba.red * 0xFF))
        #expect(rgbInt.green == Int(rgb.green * 0xFF))
        #expect(rgbaInt.green == Int(rgba.green * 0xFF))
        #expect(rgbInt.blue == Int(rgb.blue * 0xFF))
        #expect(rgbaInt.blue == Int(rgba.blue * 0xFF))
        #expect(rgbaInt.alpha == Int(rgba.alpha * 0xFF))
    }

    @Test
    func exactFloatToIntegerConversion() throws {
        let rgb = RGB<Float>(red: 1, green: 0, blue: 1)
        let rgba = RGBA<Float>(rgb: rgb, alpha: 1)

        #expect(RGB<Int8>(exactly: rgb) == nil)
        #expect(RGBA<Int8>(exactly: rgba) == nil)

        let rgbExact = try #require(RGB<UInt8>(exactly: rgb))
        let rgbaExact = try #require(RGBA<UInt8>(exactly: rgba))

        #expect(rgbExact.red == UInt8(rgb.red * 0xFF))
        #expect(rgbaExact.red == UInt8(rgba.red * 0xFF))
        #expect(rgbExact.green == UInt8(rgb.green * 0xFF))
        #expect(rgbaExact.green == UInt8(rgba.green * 0xFF))
        #expect(rgbExact.blue == UInt8(rgb.blue * 0xFF))
        #expect(rgbaExact.blue == UInt8(rgba.blue * 0xFF))
        #expect(rgbaExact.alpha == UInt8(rgba.alpha * 0xFF))
    }

    @Test
    func floatToFloatConversion() {
        let rgb = RGB<Float>(red: 0.5, green: 0.25, blue: 0.125)
        let rgba = RGBA<Float>(rgb: rgb, alpha: 1)

        let rgbDbl = RGB<Double>(rgb)
        let rgbaDbl = RGBA<Double>(rgba)

        #expect(rgbDbl.red == Double(rgb.red))
        #expect(rgbaDbl.red == Double(rgba.red))
        #expect(rgbDbl.green == Double(rgb.green))
        #expect(rgbaDbl.green == Double(rgba.green))
        #expect(rgbDbl.blue == Double(rgb.blue))
        #expect(rgbaDbl.blue == Double(rgba.blue))
        #expect(rgbaDbl.alpha == Double(rgba.alpha))
    }

    @Test
    func exactFloatToFloatConversion() throws {
        let rgb = RGB<Double>(red: 0.5, green: 0.25, blue: 0.125)
        let rgba = RGBA<Double>(rgb: rgb, alpha: 1)

        #expect(RGB<InexactFloat>(exactly: rgb) == nil)
        #expect(RGBA<InexactFloat>(exactly: rgba) == nil)

        let rgbExact = try #require(RGB<Float>(exactly: rgb))
        let rgbaExact = try #require(RGBA<Float>(exactly: rgba))

        #expect(rgbExact.red == Float(rgb.red))
        #expect(rgbaExact.red == Float(rgba.red))
        #expect(rgbExact.green == Float(rgb.green))
        #expect(rgbaExact.green == Float(rgba.green))
        #expect(rgbExact.blue == Float(rgb.blue))
        #expect(rgbaExact.blue == Float(rgba.blue))
        #expect(rgbaExact.alpha == Float(rgba.alpha))
    }

    @Test
    func integerToFloatConversion() {
        let rgb = RGB<UInt8>(red: 128, green: 64, blue: 32)
        let rgba = RGBA<UInt8>(rgb: rgb, alpha: 0xFF)

        let rgbInt = RGB<Double>(rgb)
        let rgbaInt = RGBA<Double>(rgba)

        #expect(rgbInt.red == Double(rgb.red) / 0xFF)
        #expect(rgbaInt.red == Double(rgba.red) / 0xFF)
        #expect(rgbInt.green == Double(rgb.green) / 0xFF)
        #expect(rgbaInt.green == Double(rgba.green) / 0xFF)
        #expect(rgbInt.blue == Double(rgb.blue) / 0xFF)
        #expect(rgbaInt.blue == Double(rgba.blue) / 0xFF)
        #expect(rgbaInt.alpha == Double(rgba.alpha) / 0xFF)
    }

    @Test
    func exactIntegerToFloatConversion() throws {
        let rgb = RGB<UInt8>(red: 128, green: 64, blue: 32)
        let rgba = RGBA<UInt8>(rgb: rgb, alpha: 0xFF)

        #expect(RGB<InexactFloat>(exactly: rgb) == nil)
        #expect(RGBA<InexactFloat>(exactly: rgba) == nil)

        let rgbExact = try #require(RGB<Double>(exactly: rgb))
        let rgbaExact = try #require(RGBA<Double>(exactly: rgba))

        #expect(rgbExact.red == Double(rgb.red) / 0xFF)
        #expect(rgbaExact.red == Double(rgba.red) / 0xFF)
        #expect(rgbExact.green == Double(rgb.green) / 0xFF)
        #expect(rgbaExact.green == Double(rgba.green) / 0xFF)
        #expect(rgbExact.blue == Double(rgb.blue) / 0xFF)
        #expect(rgbaExact.blue == Double(rgba.blue) / 0xFF)
        #expect(rgbaExact.alpha == Double(rgba.alpha) / 0xFF)
    }

    @Test
    func floatingPointColorComponentsConformance() {
        var rgb = RGB<Double>(red: 0.5, green: 0.25, blue: 0.125)
        var rgba = RGBA<Double>(rgb: rgb, alpha: 0.75)

        let oldBrightness = rgb.brightness
        #expect(rgb.brightness == rgb.red * 0.299 + rgb.green * 0.587 + rgb.blue * 0.114)
        #expect(rgba.brightness == rgb.brightness)

        rgb.changeBrightness(by: 0.1)
        rgba.changeBrightness(by: 0.1)

        #expect(rgb.red == 0.6)
        #expect(rgb.green == 0.35)
        #expect(rgb.blue == 0.225)
        #expect(rgba.rgb == rgb)
        #expect(rgba.alpha == 0.75)
        #expect(rgb.brightness.isApproximatelyEqual(to: oldBrightness + 0.1, absoluteTolerance: 0.0001))
        #expect(rgba.brightness.isApproximatelyEqual(to: oldBrightness + 0.1, absoluteTolerance: 0.0001))
    }
}
