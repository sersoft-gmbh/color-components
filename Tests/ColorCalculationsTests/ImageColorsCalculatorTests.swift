import Testing
import ColorComponents
import ColorCalculations
#if canImport(CoreImage)
import CoreImage
fileprivate let coreImageAvailable = true
#else
fileprivate let coreImageAvailable = false
#endif
#if canImport(CoreGraphics)
import CoreGraphics
fileprivate let coreGraphicsAvailable = true
#else
fileprivate let coreGraphicsAvailable = false
#endif
#if canImport(UIKit)
import UIKit
fileprivate let uiKitAvailable = true
#else
fileprivate let uiKitAvailable = false
#endif
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
fileprivate let appKitAvailable = true
#else
fileprivate let appKitAvailable = false
#endif

@Suite
struct ImageColorsCalculatorTests {
    private let img1URL: URL
    private let img2URL: URL
    private let img3URL: URL
    private let img4URL: URL

    init() throws {
        img1URL = try #require(Bundle.module.url(forResource: "img1",
                                                 withExtension: "jpg",
                                                 subdirectory: "TestImages"))
        img2URL = try #require(Bundle.module.url(forResource: "img2",
                                                 withExtension: "jpg",
                                                 subdirectory: "TestImages"))
        img3URL = try #require(Bundle.module.url(forResource: "img3",
                                                 withExtension: "jpg",
                                                 subdirectory: "TestImages"))
        img4URL = try #require(Bundle.module.url(forResource: "img4",
                                                 withExtension: "jpg",
                                                 subdirectory: "TestImages"))
    }

    @Test(.enabled(if: coreImageAvailable))
    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    func averageColor() throws {
#if canImport(CoreImage)
        let img1 = try #require(CIImage(contentsOf: img1URL))
        let img2 = try #require(CIImage(contentsOf: img2URL))
        let img3 = try #require(CIImage(contentsOf: img3URL))
        let calculator1 = ImageColorsCalculator(image: img1)
        let calculator2 = ImageColorsCalculator(image: img2)
        let calculator3 = ImageColorsCalculator(image: img3)

        #expect(calculator1.averageColor() == RGBA(red: 91, green: 66, blue: 46, alpha: 0xFF))
        #expect(calculator2.averageColor(in: CGRect(origin: CGPoint(x: 2, y: 2), size: CGSize(width: 1, height: 1)))
                ==
                RGBA(red: 3, green: 2, blue: 3, alpha: 0xFF))

        let avgColor50_50 = calculator3.averageColor(in: CGRect(origin: CGPoint(x: 50, y: 50), size: CGSize(width: 1, height: 1)))
        #expect(abs(avgColor50_50.red.distance(to: 32)) <= 1)
        #expect(avgColor50_50.green == 30)
        #expect(avgColor50_50.blue == 28)
        #expect(avgColor50_50.alpha == 0xFF)
#endif
    }

    @Test(.enabled(if: coreImageAvailable))
    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    func maxComponentColor() throws {
#if canImport(CoreImage)
        let img1 = try #require(CIImage(contentsOf: img1URL))
        let img2 = try #require(CIImage(contentsOf: img2URL))
        let img3 = try #require(CIImage(contentsOf: img3URL))
        let calculator1 = ImageColorsCalculator(image: img1)
        let calculator2 = ImageColorsCalculator(image: img2)
        let calculator3 = ImageColorsCalculator(image: img3)

        #expect(calculator1.maxComponentColor() == RGBA(red: 255, green: 255, blue: 255, alpha: 0xFF))
        #expect(calculator2.maxComponentColor(in: CGRect(origin: CGPoint(x: 2, y: 2), size: CGSize(width: 1, height: 1)))
                ==
                RGBA(red: 3, green: 2, blue: 3, alpha: 0xFF))
        #expect(calculator3.maxComponentColor(in: CGRect(origin: CGPoint(x: 50, y: 50), size: CGSize(width: 1, height: 1)))
                ==
                RGBA(red: 32, green: 30, blue: 28, alpha: 0xFF))
#endif
    }

    @Test(.enabled(if: coreImageAvailable))
    func mostProminentColor() throws {
#if canImport(CoreImage)
        let img1 = try #require(CIImage(contentsOf: img1URL))
        let img2 = try #require(CIImage(contentsOf: img2URL))
        let img3 = try #require(CIImage(contentsOf: img3URL))
        let img4 = try #require(CIImage(contentsOf: img4URL))
        let calculator1 = ImageColorsCalculator(image: img1)
        let calculator2 = ImageColorsCalculator(image: img2)
        let calculator3 = ImageColorsCalculator(image: img3)
        let calculator4 = ImageColorsCalculator(image: img4)

        //#if os(iOS)
        //        let c1 = UIColor(calculator1.mostProminentColor(as: Float.self))
        //        let c2 = UIColor(calculator2.mostProminentColor(as: Float.self))
        //        let c3 = UIColor(calculator3.mostProminentColor(as: Float.self))
        //        let c4 = UIColor(calculator4.mostProminentColor(as: Float.self))
        //#endif

        //        let color1: RGB<Float> = calculator1.mostProminentColor()
        //        #expect(color1.red.isApproximatelyEqual(to: 75 / 0xFF, absoluteTolerance: 15 / 0xFF))
        //        #expect(color1.green.isApproximatelyEqual(to: 26 / 0xFF, absoluteTolerance: 7 / 0xFF))
        //        #expect(color1.blue.isApproximatelyEqual(to: 15 / 0xFF, absoluteTolerance: 5 / 0xFF))
        #expect(!calculator1.prominentColors(as: Float.self).isEmpty)
        #expect(!calculator4.prominentColors(as: Float.self).isEmpty)
        #expect(RGB<UInt8>(calculator2.mostProminentColor(as: Float.self,
                                                          in: CGRect(origin: CGPoint(x: 630, y: 200),
                                                                     size: CGSize(width: 1, height: 1))))
                ==
                RGB(red: 4, green: 1, blue: 3))

        let mostPromColor50_50 = calculator3.mostProminentColor(as: Float.self,
                                                                in: CGRect(origin: CGPoint(x: 50, y: 50),
                                                                           size: CGSize(width: 1, height: 1)))
        #expect(abs((mostPromColor50_50.red * 0xFF).distance(to: 32)) <= 1)
        #expect(mostPromColor50_50.green == (30 / 0xFF) as Float)
        #expect(mostPromColor50_50.blue == (28 / 0xFF) as Float)
#endif
    }

    @Test(.enabled(if: coreImageAvailable && coreGraphicsAvailable))
    func cgImageInitializer() throws {
#if canImport(CoreImage) && canImport(CoreGraphics)
#if compiler(>=6.2)
        let cgImageDataProvider = try #require(unsafe CGDataProvider(filename: img1URL.path))
#else
        let cgImageDataProvider = try #require(CGDataProvider(filename: img1URL.path))
#endif
        let cgImage = try #require({
            CGImage(jpegDataProviderSource: cgImageDataProvider, decode: nil, shouldInterpolate: false, intent: .defaultIntent)
        }())
        let calculator: ImageColorsCalculator? = ImageColorsCalculator(cgImage: cgImage)
        #expect(calculator != nil)
#endif
    }

    @Test(.enabled(if: coreImageAvailable && uiKitAvailable))
    @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
    func uiImageInitializer() async throws {
#if canImport(CoreImage) && canImport(UIKit)
        final class NonBackingUIImage: UIImage, @unchecked Sendable {
            override var ciImage: CIImage? { nil }
            override var cgImage: CGImage? { nil }
        }

        final class NonCGUIImage: UIImage, @unchecked Sendable {
            override var cgImage: CGImage? { nil }
        }

        final class NonCIUIImage: UIImage, @unchecked Sendable {
            override var ciImage: CIImage? { nil }
        }

        let uiImage = try #require(UIImage(contentsOfFile: img1URL.path))
        #expect(ImageColorsCalculator(uiImage: uiImage) != nil)
        let uiImage2 = try await MainActor.run { [img2URL] in try #require(NonCIUIImage(contentsOfFile: img2URL.path)) }
        #expect(ImageColorsCalculator(uiImage: uiImage2) != nil)
        let uiImage3 = try await MainActor.run { [img1URL] in try NonCGUIImage(ciImage: #require(CIImage(contentsOf: img1URL))) }
        #expect(ImageColorsCalculator(uiImage: uiImage3) != nil)
        let uiImage4 = try await MainActor.run { [img1URL] in try #require(NonBackingUIImage(contentsOfFile: img1URL.path)) }
        #expect(ImageColorsCalculator(uiImage: uiImage4) == nil)
#endif
    }

    @Test(.enabled(if: coreImageAvailable && appKitAvailable))
    func nsImageInitializer() throws {
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
        let nsImage = try #require(NSImage(contentsOf: img3URL))
        #expect(ImageColorsCalculator(nsImage: nsImage) != nil)
#endif
    }
}
