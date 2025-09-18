import Testing
import Numerics
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
#endif
import ColorComponents

extension HSBATests {
    @Suite(.enabled(if: .appKitAvailable))
    struct AppKitTests {
        @Test
        func nsColorCreationWithFloatingPoint() throws {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
            let hsb = HSB<CGFloat>(hue: 0.25, saturation: 0.5, brightness: 0.75)
            let hsba = HSBA(hsb: hsb, alpha: 0.25)

            let opaqueColor = NSColor(hsb)
            let alphaColor = NSColor(hsba)

            #expect(opaqueColor.alphaComponent == 1)
            #expect(alphaColor.alphaComponent == hsba.alpha)
            #expect(opaqueColor.hueComponent == hsb.hue)
            #expect(alphaColor.hueComponent == hsba.hue)
            #expect(opaqueColor.saturationComponent == hsb.saturation)
            #expect(alphaColor.saturationComponent == hsba.saturation)
            #expect(opaqueColor.brightnessComponent == hsb.brightness)
            #expect(alphaColor.brightnessComponent == hsba.brightness)
#endif
        }

        @Test
        func creationFromNSColorWithFloatingPoint() throws {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
            let color: NSColor
            if #available(macOS 10.12, *) {
                color = NSColor(colorSpace: .genericRGB, hue: 0.25, saturation: 0.5, brightness: 0.75, alpha: 0.25)
            } else {
#if compiler(>=6.2) && hasFeature(StrictMemorySafety)
                color = unsafe NSColor(colorSpace: .genericRGB, components: [0.5625, 0.75, 0.375, 0.25], count: 4)
#else
                color = NSColor(colorSpace: .genericRGB, components: [0.5625, 0.75, 0.375, 0.25], count: 4)
#endif
            }

            let hsb = HSB<CGFloat>(color)
            let hsba = HSBA<CGFloat>(color)

            #expect(hsb.hue == color.hueComponent)
            #expect(hsba.hue == color.hueComponent)
            #expect(hsb.saturation == color.saturationComponent)
            #expect(hsba.saturation == color.saturationComponent)
            #expect(hsb.brightness == color.brightnessComponent)
            #expect(hsba.brightness == color.brightnessComponent)
            #expect(hsba.alpha == color.alphaComponent)
            #expect(HSB<InexactFloat>(exactly: color) == nil)
            #expect(HSBA<InexactFloat>(exactly: color) == nil)
#endif
        }

        @Test
        func nsColorCreationWithInteger() throws {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
            let hsb = HSB<UInt8>(hue: 0x40, saturation: 0x80, brightness: 0xB0)
            let hsba = HSBA(hsb: hsb, alpha: 0x40)

            let opaqueColor = NSColor(hsb)
            let alphaColor = NSColor(hsba)

            #expect(opaqueColor.alphaComponent == 1)
            #expect(alphaColor.alphaComponent.isApproximatelyEqual(to: CGFloat(hsba.alpha) / 0xFF, absoluteTolerance: .ulpOfOne))
            #expect(opaqueColor.hueComponent.isApproximatelyEqual(to: CGFloat(hsb.hue) / 0xFF, absoluteTolerance: .ulpOfOne))
            #expect(alphaColor.hueComponent.isApproximatelyEqual(to: CGFloat(hsba.hue) / 0xFF, absoluteTolerance: .ulpOfOne))
            #expect(opaqueColor.saturationComponent.isApproximatelyEqual(to: CGFloat(hsb.saturation) / 0xFF, absoluteTolerance: .ulpOfOne))
            #expect(alphaColor.saturationComponent.isApproximatelyEqual(to: CGFloat(hsba.saturation) / 0xFF, absoluteTolerance: .ulpOfOne))
            #expect(opaqueColor.brightnessComponent.isApproximatelyEqual(to: CGFloat(hsb.brightness) / 0xFF, absoluteTolerance: .ulpOfOne))
            #expect(alphaColor.brightnessComponent.isApproximatelyEqual(to: CGFloat(hsba.brightness) / 0xFF, absoluteTolerance: .ulpOfOne))
#endif
        }

        @Test
        func creationFromNSColorWithInteger() throws {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
            let color: NSColor
            if #available(macOS 10.12, *) {
                color = NSColor(colorSpace: .genericRGB, hue: 0.25, saturation: 0.5, brightness: 0.75, alpha: 0.25)
            } else {
#if compiler(>=6.2) && hasFeature(StrictMemorySafety)
                color = unsafe NSColor(colorSpace: .genericRGB, components: [0.5625, 0.75, 0.375, 0.25], count: 4)
#else
                color = NSColor(colorSpace: .genericRGB, components: [0.5625, 0.75, 0.375, 0.25], count: 4)
#endif
            }

            let hsb = HSB<UInt8>(color)
            let hsba = HSBA<UInt8>(color)

            #expect(hsb.hue == UInt8(color.hueComponent * 0xFF))
            #expect(hsba.hue == UInt8(color.hueComponent * 0xFF))
            #expect(hsb.saturation == UInt8(color.saturationComponent * 0xFF))
            #expect(hsba.saturation == UInt8(color.saturationComponent * 0xFF))
            #expect(hsb.brightness == UInt8(color.brightnessComponent * 0xFF))
            #expect(hsba.brightness == UInt8(color.brightnessComponent * 0xFF))
            #expect(hsba.alpha == UInt8(color.alphaComponent * 0xFF))
            #expect(HSB<Int8>(exactly: color) == nil)
            #expect(HSBA<Int8>(exactly: color) == nil)
#endif
        }
    }
}
