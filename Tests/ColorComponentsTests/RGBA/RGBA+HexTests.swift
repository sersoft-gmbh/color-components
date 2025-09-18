import Testing
import Numerics
import ColorComponents

extension RGBATests {
    @Suite
    struct HexTests {
        @Test
        func creationFromHex() {
            let rgb = RGB<UInt64>(hex: 0xFF8055)
            let rgba = RGBA<UInt64>(hex: 0xFF8055FA as UInt64)

            #expect(rgb.red == 0xFF)
            #expect(rgb.green == 0x80)
            #expect(rgb.blue == 0x55)
            #expect(rgba.rgb == rgb)
            #expect(rgba.alpha == 0xFA)
        }

        @Test
        func creationFromHexOfDifferentSize() {
            let rgb = RGB<UInt8>(hex: 0xFF8055)
            let rgba = RGBA<UInt8>(hex: 0xFF8055FA as UInt64)

            #expect(rgb.red == 0xFF)
            #expect(rgb.green == 0x80)
            #expect(rgb.blue == 0x55)
            #expect(rgba.rgb == rgb)
            #expect(rgba.alpha == 0xFA)
        }

        @Test
        func creationFromHexUsingFloatingPoint() {
            let rgb = RGB<Float>(hex: 0xFF8055)
            let rgba = RGBA<Float>(hex: 0xFF8055FA as UInt64)

            #expect(rgb.red.isApproximatelyEqual(to: 1, absoluteTolerance: .ulpOfOne))
            #expect(rgb.green.isApproximatelyEqual(to: 0x80 / 0xFF, absoluteTolerance: .ulpOfOne))
            #expect(rgb.blue.isApproximatelyEqual(to: 0x55 / 0xFF, absoluteTolerance: .ulpOfOne))
            #expect(rgba.rgb == rgb)
            #expect(rgba.alpha.isApproximatelyEqual(to: 0xFA / 0xFF, absoluteTolerance: .ulpOfOne))
        }

        @Test
        func creationFromHexString() {
            let rgb = RGB<UInt8>(hexString: "FF8055")
            let rgb0x = RGB<UInt8>(hexString: "0xFF8055")
            let rgbHash = RGB<UInt8>(hexString: "#FF8055")
            let rgbInvalid = RGB<UInt8>(hexString: "0xTESTIN")
            let rgba = RGBA<UInt8>(hexString: "FF8055FA")
            let rgba0x = RGBA<UInt8>(hexString: "0xFF8055FA")
            let rgbaHash = RGBA<UInt8>(hexString: "#FF8055FA")
            let rgbaInvalid = RGBA<UInt8>(hexString: "0xTESTINIT")

            #expect(rgb != nil)
            #expect(rgb0x != nil)
            #expect(rgbHash != nil)
            #expect(rgba != nil)
            #expect(rgba0x != nil)
            #expect(rgbaHash != nil)

            #expect(rgbInvalid == nil)
            #expect(rgbaInvalid == nil)

            #expect(rgb?.red == 0xFF)
            #expect(rgb?.green == 0x80)
            #expect(rgb?.blue == 0x55)
            #expect(rgba?.rgb == rgb)
            #expect(rgba?.alpha == 0xFA)

            #expect(rgb0x == rgb)
            #expect(rgbHash == rgb)
            #expect(rgba0x == rgba)
            #expect(rgbaHash == rgba)
        }

        @Test
        func creationFromHexStringWithFloatingPoint() throws {
            let rgb = try #require(RGB<Float>(hexString: "FF8055"))
            let rgb0x = try #require(RGB<Float>(hexString: "0xFF8055"))
            let rgbHash = try #require(RGB<Float>(hexString: "#FF8055"))
            let rgba = try #require(RGBA<Float>(hexString: "FF8055FA"))
            let rgba0x = try #require(RGBA<Float>(hexString: "0xFF8055FA"))
            let rgbaHash = try #require(RGBA<Float>(hexString: "#FF8055FA"))

            #expect(RGB<Float>(hexString: "0xTESTIN") == nil)
            #expect(RGBA<Float>(hexString: "0xTESTINIT") == nil)

            #expect(rgb.red.isApproximatelyEqual(to: 1, absoluteTolerance: .ulpOfOne))
            #expect(rgb.green.isApproximatelyEqual(to: 0x80 / 0xFF, absoluteTolerance: .ulpOfOne))
            #expect(rgb.blue.isApproximatelyEqual(to: 0x55 / 0xFF, absoluteTolerance: .ulpOfOne))

            #expect(rgba.rgb == rgb)
            #expect(rgba.alpha.isApproximatelyEqual(to: 0xFA / 0xFF, absoluteTolerance: .ulpOfOne))

            #expect(rgb0x == rgb)
            #expect(rgbHash == rgb)
            #expect(rgba0x == rgba)
            #expect(rgbaHash == rgba)
        }

        @Test
        func hexValue() {
            let rgb = RGB<UInt64>(red: 0xFF, green: 0x08, blue: 0x55)
            let rgba = RGBA<UInt64>(rgb: rgb, alpha: 0xFA)

            #expect(rgb.hexValue() == 0xFF0855)
            #expect(rgba.hexValue() == 0xFF0855FA as UInt64)
        }

        @Test
        func hexValueWithDifferentSize() {
            let rgb = RGB<UInt8>(red: 0xFF, green: 0x08, blue: 0x55)
            let rgba = RGBA<UInt8>(rgb: rgb, alpha: 0xFA)

            #expect(rgb.hexValue(as: UInt64.self) == 0xFF0855)
            #expect(rgba.hexValue(as: UInt64.self) == 0xFF0855FA)
        }

        @Test
        func hexValueWithFloatingPoint() {
            let rgb = RGB<Float>(red: 0xFF / 0xFF, green: 0x08 / 0xFF, blue: 0x55 / 0xFF)
            let rgba = RGBA<Float>(rgb: rgb, alpha: 0xFA / 0xFF)

            #expect(rgb.hexValue(as: UInt64.self) == 0xFF0855)
            #expect(rgba.hexValue(as: UInt64.self) == 0xFF0855FA)
        }

        @Test
        func hexString() {
            let rgb = RGB(red: 0xFF, green: 0x08, blue: 0x55)
            let rgba = RGBA(rgb: rgb, alpha: 0xFA)

            #expect(rgb.hexString(prefix: "0x", postfix: ";", uppercase: true) == "0xFF0855;")
            #expect(rgba.hexString(prefix: "0x", postfix: ";", uppercase: true) == "0xFF0855FA;")
        }

        @Test
        func hexStringWithFloatingPoint() {
            let rgb = RGB<Float>(red: 1, green: 0x08 / 0xFF, blue: 0x55 / 0xFF)
            let rgba = RGBA(rgb: rgb, alpha: 0xFA / 0xFF)

            #expect(rgb.hexString(prefix: "0x", postfix: ";", uppercase: true) == "0xFF0855;")
            #expect(rgba.hexString(prefix: "0x", postfix: ";", uppercase: true) == "0xFF0855FA;")
        }
    }
}
