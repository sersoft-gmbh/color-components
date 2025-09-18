import Testing
import Numerics
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
#endif
import ColorComponents

extension CIEXYZATests {
    @Suite(.enabled(if: .appKitAvailable))
    struct AppKitTests {
        @Test
        func nsColorCreationWithFloatingPoint() throws {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
            let cieXYZ = CIE.XYZ<CGFloat>(x: 0.25, y: 0.5, z: 0.75)
            let cieXYZA = CIE.XYZA(xyz: cieXYZ, alpha: 0.25)
            let rgb = RGB(cieXYZ: cieXYZ)

            let opaqueColor = NSColor(cieXYZ)
            let alphaColor = NSColor(cieXYZA)

            #expect(opaqueColor.alphaComponent == 1)
            #expect(alphaColor.alphaComponent == cieXYZA.alpha)
            #expect(opaqueColor.redComponent == rgb.red)
            #expect(alphaColor.redComponent == rgb.red)
            #expect(opaqueColor.greenComponent == rgb.green)
            #expect(alphaColor.greenComponent == rgb.green)
            #expect(opaqueColor.blueComponent == rgb.blue)
            #expect(alphaColor.blueComponent == rgb.blue)
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

            let cieXYZ = CIE.XYZ<CGFloat>(color)
            let cieXYZA = CIE.XYZA<CGFloat>(color)

            let cieXYZViaRGB = CIE.XYZ(rgb: RGB<CGFloat>(color))

            #expect(cieXYZ.x == cieXYZViaRGB.x)
            #expect(cieXYZA.x == cieXYZViaRGB.x)
            #expect(cieXYZ.y == cieXYZViaRGB.y)
            #expect(cieXYZA.y == cieXYZViaRGB.y)
            #expect(cieXYZ.z == cieXYZViaRGB.z)
            #expect(cieXYZA.z == cieXYZViaRGB.z)
            #expect(cieXYZA.alpha == color.alphaComponent)
            #expect(CIE.XYZ<InexactFloat>(exactly: color) == nil)
            #expect(CIE.XYZA<InexactFloat>(exactly: color) == nil)
#endif
        }

        @Test
        func nsColorCreationWithInteger() throws {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
            let cieXYZ = CIE.XYZ<UInt8>(x: 0x30, y: 090, z: 0xA0)
            let cieXYZA = CIE.XYZA(xyz: cieXYZ, alpha: 0x40)

            let rgb = RGB(cieXYZ: CIE.XYZ<CGFloat>(cieXYZ))

            let opaqueColor = NSColor(cieXYZ)
            let alphaColor = NSColor(cieXYZA)

            #expect(opaqueColor.alphaComponent == 1)
            #expect(alphaColor.alphaComponent.isApproximatelyEqual(to: CGFloat(cieXYZA.alpha) / 0xFF, absoluteTolerance: .ulpOfOne))
            #expect(opaqueColor.redComponent.isApproximatelyEqual(to: rgb.red, absoluteTolerance: .ulpOfOne))
            #expect(alphaColor.redComponent.isApproximatelyEqual(to: rgb.red, absoluteTolerance: .ulpOfOne))
            #expect(opaqueColor.greenComponent.isApproximatelyEqual(to: rgb.green, absoluteTolerance: .ulpOfOne))
            #expect(alphaColor.greenComponent.isApproximatelyEqual(to: rgb.green, absoluteTolerance: .ulpOfOne))
            #expect(opaqueColor.blueComponent.isApproximatelyEqual(to: rgb.blue, absoluteTolerance: .ulpOfOne))
            #expect(alphaColor.blueComponent.isApproximatelyEqual(to: rgb.blue, absoluteTolerance: .ulpOfOne))
#endif
        }

        @Test
        func creationFromNSColorWithInteger() throws {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
            let color: NSColor
            if #available(macOS 10.12, *) {
                color = NSColor(red: 0.25, green: 0.5, blue: 0.75, alpha: 0.25)
            } else {
#if compiler(>=6.2)
                color = unsafe NSColor(colorSpace: .genericRGB, components: [0.25, 0.5, 0.75, 0.25], count: 4)
#else
                color = NSColor(colorSpace: .genericRGB, components: [0.25, 0.5, 0.75, 0.25], count: 4)
#endif
            }

            let cieXYZ = CIE.XYZ<UInt8>(color)
            let cieXYZA = CIE.XYZA<UInt8>(color)

            let cieXYZViaRGB = CIE.XYZ<UInt8>(CIE.XYZ(rgb: RGB<CGFloat>(color)))

            #expect(cieXYZ.x == cieXYZViaRGB.x)
            #expect(cieXYZA.x == cieXYZViaRGB.x)
            #expect(cieXYZ.y == cieXYZViaRGB.y)
            #expect(cieXYZA.y == cieXYZViaRGB.y)
            #expect(cieXYZ.z == cieXYZViaRGB.z)
            #expect(cieXYZA.z == cieXYZViaRGB.z)
            #expect(cieXYZA.alpha == UInt8(color.alphaComponent * 0xFF))
            #expect(CIE.XYZ<Int8>(exactly: color) == nil)
            #expect(CIE.XYZA<Int8>(exactly: color) == nil)
#endif
        }
    }
}
