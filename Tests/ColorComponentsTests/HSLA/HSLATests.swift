import Testing
import ColorComponents

@Suite
struct HSLATests {
    @Test
    func simpleCreation() {
        let hsl = HSL<UInt8>(hue: 128, saturation: 64, luminance: 32)
        let hsla = HSLA<UInt8>(hsl: hsl, alpha: 0xFF)
        let hsla2 = HSLA<UInt8>(hue: 128, saturation: 64, luminance: 32, alpha: 0xFF)
        #expect(hsl.hue == 128)
        #expect(hsl.saturation == 64)
        #expect(hsl.luminance == 32)
        #expect(hsla.hsl == hsl)
        #expect(hsla.hsl.hue == 128)
        #expect(hsla.hsl.saturation == 64)
        #expect(hsla.hsl.luminance == 32)
        #expect(hsla2.hsl.hue == 128)
        #expect(hsla2.hsl.saturation == 64)
        #expect(hsla2.hsl.luminance == 32)
        #expect(hsla.alpha == 0xFF)
        #expect(hsla2.alpha == 0xFF)
        #expect(hsla == hsla2)
    }

    @Test
    func modification() {
        var hsla = HSLA<UInt8>(hue: 128, saturation: 64, luminance: 32, alpha: 0xFF)
        hsla.hue = 120
        hsla.saturation = 60
        hsla.luminance = 30
        #expect(hsla.hue == 120)
        #expect(hsla.hsl.hue == 120)
        #expect(hsla.saturation == 60)
        #expect(hsla.hsl.saturation == 60)
        #expect(hsla.luminance == 30)
        #expect(hsla.hsl.luminance == 30)
    }

    @Test
    func integerToIntegerConversion() {
        let hsl = HSL<UInt8>(hue: 128, saturation: 64, luminance: 32)
        let hsla = HSLA<UInt8>(hsl: hsl, alpha: 0xFF)

        let hslInt = HSL<Int>(hsl)
        let hslaInt = HSLA<Int>(hsla)

        #expect(hslInt.hue == Int(hsl.hue))
        #expect(hslaInt.hue == Int(hsla.hue))
        #expect(hslInt.saturation == Int(hsl.saturation))
        #expect(hslaInt.saturation == Int(hsla.saturation))
        #expect(hslInt.luminance == Int(hsl.luminance))
        #expect(hslaInt.luminance == Int(hsla.luminance))
        #expect(hslaInt.alpha == Int(hsla.alpha))
    }

    @Test
    func exactIntegerToIntegerConversion() throws {
        let hsl = HSL<UInt8>(hue: 128, saturation: 64, luminance: 32)
        let hsla = HSLA<UInt8>(hsl: hsl, alpha: 0xFF)

        #expect(HSL<Int8>(exactly: hsl) == nil)
        #expect(HSLA<Int8>(exactly: hsla) == nil)

        let hslExact = try #require(HSL<UInt>(exactly: hsl))
        let hslaExact = try #require(HSLA<UInt>(exactly: hsla))

        #expect(hslExact.hue == UInt(hsl.hue))
        #expect(hslaExact.hue == UInt(hsla.hue))
        #expect(hslExact.saturation == UInt(hsl.saturation))
        #expect(hslaExact.saturation == UInt(hsla.saturation))
        #expect(hslExact.luminance == UInt(hsl.luminance))
        #expect(hslaExact.luminance == UInt(hsla.luminance))
        #expect(hslaExact.alpha == UInt(hsla.alpha))
    }

    @Test
    func floatToIntegerConversion() {
        let hsl = HSL<Float>(hue: 0.5, saturation: 0.25, luminance: 0.125)
        let hsla = HSLA<Float>(hsl: hsl, alpha: 1)

        let hslInt = HSL<Int>(hsl)
        let hslaInt = HSLA<Int>(hsla)

        #expect(hslInt.hue == Int(hsl.hue * 0xFF))
        #expect(hslaInt.hue == Int(hsla.hue * 0xFF))
        #expect(hslInt.saturation == Int(hsl.saturation * 0xFF))
        #expect(hslaInt.saturation == Int(hsla.saturation * 0xFF))
        #expect(hslInt.luminance == Int(hsl.luminance * 0xFF))
        #expect(hslaInt.luminance == Int(hsla.luminance * 0xFF))
        #expect(hslaInt.alpha == Int(hsla.alpha * 0xFF))
    }

    @Test
    func exactFloatToIntegerConversion() throws {
        let hsl = HSL<Float>(hue: 1, saturation: 0, luminance: 1)
        let hsla = HSLA<Float>(hsl: hsl, alpha: 1)

        #expect(HSL<Int8>(exactly: hsl) == nil)
        #expect(HSLA<Int8>(exactly: hsla) == nil)

        let hslExact = try #require(HSL<UInt8>(exactly: hsl))
        let hslaExact = try #require(HSLA<UInt8>(exactly: hsla))

        #expect(hslExact.hue == UInt8(hsl.hue * 0xFF))
        #expect(hslaExact.hue == UInt8(hsla.hue * 0xFF))
        #expect(hslExact.saturation == UInt8(hsl.saturation * 0xFF))
        #expect(hslaExact.saturation == UInt8(hsla.saturation * 0xFF))
        #expect(hslExact.luminance == UInt8(hsl.luminance * 0xFF))
        #expect(hslaExact.luminance == UInt8(hsla.luminance * 0xFF))
        #expect(hslaExact.alpha == UInt8(hsla.alpha * 0xFF))
    }

    @Test
    func floatToFloatConversion() {
        let hsl = HSL<Float>(hue: 0.5, saturation: 0.25, luminance: 0.125)
        let hsla = HSLA<Float>(hsl: hsl, alpha: 1)

        let hslDbl = HSL<Double>(hsl)
        let hslaDbl = HSLA<Double>(hsla)

        #expect(hslDbl.hue == Double(hsl.hue))
        #expect(hslaDbl.hue == Double(hsla.hue))
        #expect(hslDbl.saturation == Double(hsl.saturation))
        #expect(hslaDbl.saturation == Double(hsla.saturation))
        #expect(hslDbl.luminance == Double(hsl.luminance))
        #expect(hslaDbl.luminance == Double(hsla.luminance))
        #expect(hslaDbl.alpha == Double(hsla.alpha))
    }

    @Test
    func exactFloatToFloatConversion() throws {
        let hsl = HSL<Double>(hue: 0.5, saturation: 0.25, luminance: 0.125)
        let hsla = HSLA<Double>(hsl: hsl, alpha: 1)

        #expect(HSL<InexactFloat>(exactly: hsl) == nil)
        #expect(HSLA<InexactFloat>(exactly: hsla) == nil)

        let hslExact = try #require(HSL<Float>(exactly: hsl))
        let hslaExact = try #require(HSLA<Float>(exactly: hsla))

        #expect(hslExact.hue == Float(hsl.hue))
        #expect(hslaExact.hue == Float(hsla.hue))
        #expect(hslExact.saturation == Float(hsl.saturation))
        #expect(hslaExact.saturation == Float(hsla.saturation))
        #expect(hslExact.luminance == Float(hsl.luminance))
        #expect(hslaExact.luminance == Float(hsla.luminance))
        #expect(hslaExact.alpha == Float(hsla.alpha))
    }

    @Test
    func integerToFloatConversion() {
        let hsl = HSL<UInt8>(hue: 128, saturation: 64, luminance: 32)
        let hsla = HSLA<UInt8>(hsl: hsl, alpha: 0xFF)

        let hslInt = HSL<Double>(hsl)
        let hslaInt = HSLA<Double>(hsla)

        #expect(hslInt.hue == Double(hsl.hue) / 0xFF)
        #expect(hslaInt.hue == Double(hsla.hue) / 0xFF)
        #expect(hslInt.saturation == Double(hsl.saturation) / 0xFF)
        #expect(hslaInt.saturation == Double(hsla.saturation) / 0xFF)
        #expect(hslInt.luminance == Double(hsl.luminance) / 0xFF)
        #expect(hslaInt.luminance == Double(hsla.luminance) / 0xFF)
        #expect(hslaInt.alpha == Double(hsla.alpha) / 0xFF)
    }

    @Test
    func exactIntegerToFloatConversion() throws {
        let hsl = HSL<UInt8>(hue: 128, saturation: 64, luminance: 32)
        let hsla = HSLA<UInt8>(hsl: hsl, alpha: 0xFF)

        #expect(HSL<InexactFloat>(exactly: hsl) == nil)
        #expect(HSLA<InexactFloat>(exactly: hsla) == nil)

        let hslExact = try #require(HSL<Double>(exactly: hsl))
        let hslaExact = try #require(HSLA<Double>(exactly: hsla))

        #expect(hslExact.hue == Double(hsl.hue) / 0xFF)
        #expect(hslaExact.hue == Double(hsla.hue) / 0xFF)
        #expect(hslExact.saturation == Double(hsl.saturation) / 0xFF)
        #expect(hslaExact.saturation == Double(hsla.saturation) / 0xFF)
        #expect(hslExact.luminance == Double(hsl.luminance) / 0xFF)
        #expect(hslaExact.luminance == Double(hsla.luminance) / 0xFF)
        #expect(hslaExact.alpha == Double(hsla.alpha) / 0xFF)
    }

    @Test
    func floatingPointColorComponentsConformance() {
        var hsl = HSL<Double>(hue: 0.5, saturation: 0.25, luminance: 0.125)
        var hsla = HSLA<Double>(hsl: hsl, alpha: 1)

        hsl.changeBrightness(by: 0.1)
        hsla.changeBrightness(by: 0.1)

        #expect(hsl.luminance == 0.225)
        #expect(hsla.luminance == 0.225)
    }
}
