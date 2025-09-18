import Testing
import ColorComponents

@Suite
struct HSBATests {
    @Test
    func simpleCreation() {
        let hsb = HSB<UInt8>(hue: 128, saturation: 64, brightness: 32)
        let hsba = HSBA<UInt8>(hsb: hsb, alpha: 0xFF)
        let hsba2 = HSBA<UInt8>(hue: 128, saturation: 64, brightness: 32, alpha: 0xFF)
        #expect(hsb.hue == 128)
        #expect(hsb.saturation == 64)
        #expect(hsb.brightness == 32)
        #expect(hsba.hsb == hsb)
        #expect(hsba.hsb.hue == 128)
        #expect(hsba.hsb.saturation == 64)
        #expect(hsba.hsb.brightness == 32)
        #expect(hsba2.hsb.hue == 128)
        #expect(hsba2.hsb.saturation == 64)
        #expect(hsba2.hsb.brightness == 32)
        #expect(hsba.alpha == 0xFF)
        #expect(hsba2.alpha == 0xFF)
        #expect(hsba == hsba2)
    }

    @Test
    func modification() {
        var hsba = HSBA<UInt8>(hue: 128, saturation: 64, brightness: 32, alpha: 0xFF)
        hsba.hue = 120
        hsba.saturation = 60
        hsba.brightness = 30
        #expect(hsba.hue == 120)
        #expect(hsba.hsb.hue == 120)
        #expect(hsba.saturation == 60)
        #expect(hsba.hsb.saturation == 60)
        #expect(hsba.brightness == 30)
        #expect(hsba.hsb.brightness == 30)
    }

    @Test
    func integerToIntegerConversion() {
        let hsb = HSB<UInt8>(hue: 128, saturation: 64, brightness: 32)
        let hsba = HSBA<UInt8>(hsb: hsb, alpha: 0xFF)

        let hsbInt = HSB<Int>(hsb)
        let hsbaInt = HSBA<Int>(hsba)

        #expect(hsbInt.hue == Int(hsb.hue))
        #expect(hsbaInt.hue == Int(hsba.hue))
        #expect(hsbInt.saturation == Int(hsb.saturation))
        #expect(hsbaInt.saturation == Int(hsba.saturation))
        #expect(hsbInt.brightness == Int(hsb.brightness))
        #expect(hsbaInt.brightness == Int(hsba.brightness))
        #expect(hsbaInt.alpha == Int(hsba.alpha))
    }

    @Test
    func exactIntegerToIntegerConversion() throws {
        let hsb = HSB<UInt8>(hue: 128, saturation: 64, brightness: 32)
        let hsba = HSBA<UInt8>(hsb: hsb, alpha: 0xFF)

        #expect(HSB<Int8>(exactly: hsb) == nil)
        #expect(HSBA<Int8>(exactly: hsba) == nil)

        let hsbExact = try #require(HSB<UInt>(exactly: hsb))
        let hsbaExact = try #require(HSBA<UInt>(exactly: hsba))

        #expect(hsbExact.hue == UInt(hsb.hue))
        #expect(hsbaExact.hue == UInt(hsba.hue))
        #expect(hsbExact.saturation == UInt(hsb.saturation))
        #expect(hsbaExact.saturation == UInt(hsba.saturation))
        #expect(hsbExact.brightness == UInt(hsb.brightness))
        #expect(hsbaExact.brightness == UInt(hsba.brightness))
        #expect(hsbaExact.alpha == UInt(hsba.alpha))
    }

    @Test
    func floatToIntegerConversion() {
        let hsb = HSB<Float>(hue: 0.5, saturation: 0.25, brightness: 0.125)
        let hsba = HSBA<Float>(hsb: hsb, alpha: 1)

        let hsbInt = HSB<Int>(hsb)
        let hsbaInt = HSBA<Int>(hsba)

        #expect(hsbInt.hue == Int(hsb.hue * 0xFF))
        #expect(hsbaInt.hue == Int(hsba.hue * 0xFF))
        #expect(hsbInt.saturation == Int(hsb.saturation * 0xFF))
        #expect(hsbaInt.saturation == Int(hsba.saturation * 0xFF))
        #expect(hsbInt.brightness == Int(hsb.brightness * 0xFF))
        #expect(hsbaInt.brightness == Int(hsba.brightness * 0xFF))
        #expect(hsbaInt.alpha == Int(hsba.alpha * 0xFF))
    }

    @Test
    func exactFloatToIntegerConversion() throws {
        let hsb = HSB<Float>(hue: 1, saturation: 0, brightness: 1)
        let hsba = HSBA<Float>(hsb: hsb, alpha: 1)

        #expect(HSB<Int8>(exactly: hsb) == nil)
        #expect(HSBA<Int8>(exactly: hsba) == nil)

        let hsbExact = try #require(HSB<UInt8>(exactly: hsb))
        let hsbaExact = try #require(HSBA<UInt8>(exactly: hsba))

        #expect(hsbExact.hue == UInt8(hsb.hue * 0xFF))
        #expect(hsbaExact.hue == UInt8(hsba.hue * 0xFF))
        #expect(hsbExact.saturation == UInt8(hsb.saturation * 0xFF))
        #expect(hsbaExact.saturation == UInt8(hsba.saturation * 0xFF))
        #expect(hsbExact.brightness == UInt8(hsb.brightness * 0xFF))
        #expect(hsbaExact.brightness == UInt8(hsba.brightness * 0xFF))
        #expect(hsbaExact.alpha == UInt8(hsba.alpha * 0xFF))
    }

    @Test
    func floatToFloatConversion() {
        let hsb = HSB<Float>(hue: 0.5, saturation: 0.25, brightness: 0.125)
        let hsba = HSBA<Float>(hsb: hsb, alpha: 1)

        let hsbDbl = HSB<Double>(hsb)
        let hsbaDbl = HSBA<Double>(hsba)

        #expect(hsbDbl.hue == Double(hsb.hue))
        #expect(hsbaDbl.hue == Double(hsba.hue))
        #expect(hsbDbl.saturation == Double(hsb.saturation))
        #expect(hsbaDbl.saturation == Double(hsba.saturation))
        #expect(hsbDbl.brightness == Double(hsb.brightness))
        #expect(hsbaDbl.brightness == Double(hsba.brightness))
        #expect(hsbaDbl.alpha == Double(hsba.alpha))
    }

    @Test
    func exactFloatToFloatConversion() throws {
        let hsb = HSB<Double>(hue: 0.5, saturation: 0.25, brightness: 0.125)
        let hsba = HSBA<Double>(hsb: hsb, alpha: 1)

        #expect(HSB<InexactFloat>(exactly: hsb) == nil)
        #expect(HSBA<InexactFloat>(exactly: hsba) == nil)

        let hsbExact = try #require(HSB<Float>(exactly: hsb))
        let hsbaExact = try #require(HSBA<Float>(exactly: hsba))

        #expect(hsbExact.hue == Float(hsb.hue))
        #expect(hsbaExact.hue == Float(hsba.hue))
        #expect(hsbExact.saturation == Float(hsb.saturation))
        #expect(hsbaExact.saturation == Float(hsba.saturation))
        #expect(hsbExact.brightness == Float(hsb.brightness))
        #expect(hsbaExact.brightness == Float(hsba.brightness))
        #expect(hsbaExact.alpha == Float(hsba.alpha))
    }

    @Test
    func integerToFloatConversion() {
        let hsb = HSB<UInt8>(hue: 128, saturation: 64, brightness: 32)
        let hsba = HSBA<UInt8>(hsb: hsb, alpha: 0xFF)

        let hsbInt = HSB<Double>(hsb)
        let hsbaInt = HSBA<Double>(hsba)

        #expect(hsbInt.hue == Double(hsb.hue) / 0xFF)
        #expect(hsbaInt.hue == Double(hsba.hue) / 0xFF)
        #expect(hsbInt.saturation == Double(hsb.saturation) / 0xFF)
        #expect(hsbaInt.saturation == Double(hsba.saturation) / 0xFF)
        #expect(hsbInt.brightness == Double(hsb.brightness) / 0xFF)
        #expect(hsbaInt.brightness == Double(hsba.brightness) / 0xFF)
        #expect(hsbaInt.alpha == Double(hsba.alpha) / 0xFF)
    }

    @Test
    func exactIntegerToFloatConversion() throws {
        let hsb = HSB<UInt8>(hue: 128, saturation: 64, brightness: 32)
        let hsba = HSBA<UInt8>(hsb: hsb, alpha: 0xFF)

        #expect(HSB<InexactFloat>(exactly: hsb) == nil)
        #expect(HSBA<InexactFloat>(exactly: hsba) == nil)

        let hsbExact = try #require(HSB<Double>(exactly: hsb))
        let hsbaExact = try #require(HSBA<Double>(exactly: hsba))

        #expect(hsbExact.hue == Double(hsb.hue) / 0xFF)
        #expect(hsbaExact.hue == Double(hsba.hue) / 0xFF)
        #expect(hsbExact.saturation == Double(hsb.saturation) / 0xFF)
        #expect(hsbaExact.saturation == Double(hsba.saturation) / 0xFF)
        #expect(hsbExact.brightness == Double(hsb.brightness) / 0xFF)
        #expect(hsbaExact.brightness == Double(hsba.brightness) / 0xFF)
        #expect(hsbaExact.alpha == Double(hsba.alpha) / 0xFF)
    }

    @Test
    func floatingPointColorComponentsConformance() {
        var hsb = HSB<Double>(hue: 0.5, saturation: 0.25, brightness: 0.125)
        var hsba = HSBA<Double>(hsb: hsb, alpha: 1)

        hsb.changeBrightness(by: 0.1)
        hsba.changeBrightness(by: 0.1)

        #expect(hsb.brightness == 0.225)
        #expect(hsba.brightness == 0.225)
    }
}
