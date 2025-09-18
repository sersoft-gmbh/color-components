import Testing
import Numerics
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
#endif
import ColorComponents

extension HSLATests {
    @Suite(.enabled(if: .appKitAvailable))
    struct AppKitTests {
        @Test
        func nsColorCreationWithFloatingPoint() throws {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
            let hsl = HSL<CGFloat>(hue: 0.25, saturation: 0.5, luminance: 0.75)
            let hsla = HSLA(hsl: hsl, alpha: 0.25)

            let opaqueColor = NSColor(hsl)
            let alphaColor = NSColor(hsla)

            #expect(opaqueColor.alphaComponent == 1)
            #expect(alphaColor.alphaComponent == hsla.alpha)
            #expect(opaqueColor.hueComponent.isApproximatelyEqual(to: hsl.hue, absoluteTolerance: .ulpOfOne))
            #expect(alphaColor.hueComponent.isApproximatelyEqual(to: hsla.hue, absoluteTolerance: .ulpOfOne))
            #expect(opaqueColor.saturationComponent.isApproximatelyEqual(to: HSB(hsl: hsl).saturation, absoluteTolerance: .ulpOfOne))
            #expect(alphaColor.saturationComponent.isApproximatelyEqual(to: HSBA(hsla: hsla).saturation, absoluteTolerance: .ulpOfOne))
            #expect(opaqueColor.brightnessComponent == hsl.brightness)
            #expect(alphaColor.brightnessComponent == hsla.brightness)
#endif
        }

        @Test
        func creationFromNSColorWithFloatingPoint() throws {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
            let color: NSColor
            if #available(macOS 10.12, *) {
                color = NSColor(colorSpace: .genericRGB, hue: 0.25, saturation: 0.5, brightness: 0.75, alpha: 0.25)
            } else {
#if compiler(>=6.2)
                color = unsafe NSColor(colorSpace: .genericRGB, components: [0.5625, 0.75, 0.375, 0.25], count: 4)
#else
                color = NSColor(colorSpace: .genericRGB, components: [0.5625, 0.75, 0.375, 0.25], count: 4)
#endif
            }

            let hsl = HSL<CGFloat>(color)
            let hsla = HSLA<CGFloat>(color)

            #expect(hsl.hue == color.hueComponent)
            #expect(hsla.hue == color.hueComponent)
            #expect(hsl.saturation == HSL<CGFloat>(hsb: HSB(color)).saturation)
            #expect(hsla.saturation == HSLA<CGFloat>(hsba: HSBA(color)).saturation)
            #expect(hsl.brightness == color.brightnessComponent)
            #expect(hsla.brightness == color.brightnessComponent)
            #expect(hsla.alpha == color.alphaComponent)
            #expect(HSL<InexactFloat>(exactly: color) == nil)
            #expect(HSLA<InexactFloat>(exactly: color) == nil)
#endif
        }

        @Test
        func nsColorCreationWithInteger() throws {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
            let hsl = HSL<UInt8>(hue: 0x40, saturation: 0x80, luminance: 0xB0)
            let hsla = HSLA(hsl: hsl, alpha: 0x40)

            let opaqueColor = NSColor(hsl)
            let alphaColor = NSColor(hsla)

            #expect(opaqueColor.alphaComponent == 1)
            #expect(alphaColor.alphaComponent.isApproximatelyEqual(to: CGFloat(hsla.alpha) / 0xFF, absoluteTolerance: .ulpOfOne))
            #expect(opaqueColor.hueComponent.isApproximatelyEqual(to: CGFloat(hsl.hue) / 0xFF, absoluteTolerance: .ulpOfOne))
            #expect(alphaColor.hueComponent.isApproximatelyEqual(to: CGFloat(hsla.hue) / 0xFF, absoluteTolerance: .ulpOfOne))
            #expect(opaqueColor.saturationComponent.isApproximatelyEqual(to: HSB<CGFloat>(opaqueColor).saturation, absoluteTolerance: .ulpOfOne))
            #expect(alphaColor.saturationComponent.isApproximatelyEqual(to: HSBA<CGFloat>(alphaColor).saturation, absoluteTolerance: .ulpOfOne))
            #expect(opaqueColor.brightnessComponent.isApproximatelyEqual(to: HSB<CGFloat>(opaqueColor).brightness, absoluteTolerance: .ulpOfOne))
            #expect(alphaColor.brightnessComponent.isApproximatelyEqual(to: HSBA<CGFloat>(alphaColor).brightness, absoluteTolerance: .ulpOfOne))
#endif
        }

        @Test
        func creationFromNSColorWithInteger() throws {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
            let color: NSColor
            if #available(macOS 10.12, *) {
                color = NSColor(colorSpace: .genericRGB, hue: 0.25, saturation: 0.5, brightness: 0.75, alpha: 0.25)
            } else {
#if compiler(>=6.2)
                color = unsafe NSColor(colorSpace: .genericRGB, components: [0.5625, 0.75, 0.375, 0.25], count: 4)
#else
                color = NSColor(colorSpace: .genericRGB, components: [0.5625, 0.75, 0.375, 0.25], count: 4)
#endif
            }

            let hsl = HSL<UInt8>(color)
            let hsla = HSLA<UInt8>(color)

            #expect(hsl.hue == UInt8(color.hueComponent * 0xFF))
            #expect(hsla.hue == UInt8(color.hueComponent * 0xFF))
            #expect(hsl.saturation.isApproximatelyEqual(to: HSL<UInt8>(hsb: HSB(color)).saturation, absoluteTolerance: 1, norm: Double.init))
            #expect(hsla.saturation.isApproximatelyEqual(to: HSLA<UInt8>(hsba: HSBA(color)).saturation, absoluteTolerance: 1, norm: Double.init))
            #expect(hsl.luminance == HSL(hsb: HSB(color)).luminance)
            #expect(hsla.luminance == HSLA(hsba: HSBA(color)).luminance)
            #expect(hsla.alpha == UInt8(color.alphaComponent * 0xFF))
            #expect(HSL<Int8>(exactly: color) == nil)
            #expect(HSLA<Int8>(exactly: color) == nil)
#endif
        }
    }
}
