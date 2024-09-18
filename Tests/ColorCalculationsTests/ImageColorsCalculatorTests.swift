import XCTest
import XCHelpers
import ColorComponents
import ColorCalculations
#if canImport(CoreImage)
import CoreImage
#endif
#if canImport(CoreGraphics)
import CoreGraphics
#endif
#if canImport(UIKit)
import UIKit
#endif
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
#endif

final class ImageColorsCalculatorTests: XCTestCase {
    private let img1URL = Bundle.module.url(forResource: "img1",
                                            withExtension: "jpg",
                                            subdirectory: "TestImages")!
    private let img2URL = Bundle.module.url(forResource: "img2",
                                            withExtension: "jpg",
                                            subdirectory: "TestImages")!
    private let img3URL = Bundle.module.url(forResource: "img3",
                                            withExtension: "jpg",
                                            subdirectory: "TestImages")!
    private let img4URL = Bundle.module.url(forResource: "img4",
                                            withExtension: "jpg",
                                            subdirectory: "TestImages")!

    func testAverageColor() throws {
#if !canImport(CoreImage)
        try skipUnavailableAPI()
#else
        guard #available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *) else {
            try skipUnavailableAPI()
        }
        let img1 = try XCTUnwrap(CIImage(contentsOf: img1URL))
        let img2 = try XCTUnwrap(CIImage(contentsOf: img2URL))
        let img3 = try XCTUnwrap(CIImage(contentsOf: img3URL))
        let calculator1 = ImageColorsCalculator(image: img1)
        let calculator2 = ImageColorsCalculator(image: img2)
        let calculator3 = ImageColorsCalculator(image: img3)

        XCTAssertEqual(calculator1.averageColor(), RGBA(red: 91, green: 66, blue: 46, alpha: 0xFF))
        XCTAssertEqual(calculator2.averageColor(in: CGRect(origin: CGPoint(x: 2, y: 2),
                                                           size: CGSize(width: 1, height: 1))),
                       RGBA(red: 3, green: 2, blue: 3, alpha: 0xFF))

        let avgColor50_50 = calculator3.averageColor(in: CGRect(origin: CGPoint(x: 50, y: 50),
                                                                size: CGSize(width: 1, height: 1)))
        XCTAssertEqual(avgColor50_50.red, 32, accuracy: 1)
        XCTAssertEqual(avgColor50_50.green, 30)
        XCTAssertEqual(avgColor50_50.blue, 28)
        XCTAssertEqual(avgColor50_50.alpha, 0xFF)
#endif
    }

    func testMaxComponentColor() throws {
#if !canImport(CoreImage)
        try skipUnavailableAPI()
#else
        guard #available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *) else {
            try skipUnavailableAPI()
        }
        let img1 = try XCTUnwrap(CIImage(contentsOf: img1URL))
        let img2 = try XCTUnwrap(CIImage(contentsOf: img2URL))
        let img3 = try XCTUnwrap(CIImage(contentsOf: img3URL))
        let calculator1 = ImageColorsCalculator(image: img1)
        let calculator2 = ImageColorsCalculator(image: img2)
        let calculator3 = ImageColorsCalculator(image: img3)

        XCTAssertEqual(calculator1.maxComponentColor(), RGBA(red: 255, green: 255, blue: 255, alpha: 0xFF))
        XCTAssertEqual(calculator2.maxComponentColor(in: CGRect(origin: CGPoint(x: 2, y: 2),
                                                                size: CGSize(width: 1, height: 1))),
                       RGBA(red: 3, green: 2, blue: 3, alpha: 0xFF))
        XCTAssertEqual(calculator3.maxComponentColor(in: CGRect(origin: CGPoint(x: 50, y: 50),
                                                                size: CGSize(width: 1, height: 1))),
                       RGBA(red: 32, green: 30, blue: 28, alpha: 0xFF))
#endif
    }

    func testMostProminentColor() throws {
#if !canImport(CoreImage)
        try skipUnavailableAPI()
#else
        let img1 = try XCTUnwrap(CIImage(contentsOf: img1URL))
        let img2 = try XCTUnwrap(CIImage(contentsOf: img2URL))
        let img3 = try XCTUnwrap(CIImage(contentsOf: img3URL))
        let img4 = try XCTUnwrap(CIImage(contentsOf: img4URL))
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
        //        XCTAssertEqual(color1.red, 75 / 0xFF, accuracy: 15 / 0xFF)
        //        XCTAssertEqual(color1.green, 26 / 0xFF, accuracy: 7 / 0xFF)
        //        XCTAssertEqual(color1.blue, 15 / 0xFF, accuracy: 5 / 0xFF)
        XCTAssertFalse(calculator1.prominentColors(as: Float.self).isEmpty)
        XCTAssertFalse(calculator4.prominentColors(as: Float.self).isEmpty)
        XCTAssertEqual(RGB<UInt8>(calculator2.mostProminentColor(as: Float.self,
                                                                 in: CGRect(origin: CGPoint(x: 630, y: 200),
                                                                            size: CGSize(width: 1, height: 1)))),
                       RGB(red: 4, green: 1, blue: 3))

        let mostPromColor50_50 = calculator3.mostProminentColor(as: Float.self,
                                                                in: CGRect(origin: CGPoint(x: 50, y: 50),
                                                                           size: CGSize(width: 1, height: 1)))
        XCTAssertEqual(mostPromColor50_50.red * 0xFF, 32, accuracy: 1)
        XCTAssertEqual(mostPromColor50_50.green, 30 / 0xFF)
        XCTAssertEqual(mostPromColor50_50.blue, 28 / 0xFF)
#endif
    }

    func testProminentColorsPerformanceWithLinearSRGBDifference() throws {
#if !canImport(CoreImage)
        try skipUnavailableAPI()
#else
        guard #available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *) else {
            throw XCTSkip("Performance measurements not present")
        }
        let img = try XCTUnwrap(CIImage(contentsOf: img4URL))
        measure(metrics: [XCTMemoryMetric(), XCTClockMetric()]) {
            _ = ImageColorsCalculator(image: img)
                .mostProminentColor(as: Float.self, distanceAs: .linearSRGB)
        }
#endif
    }

    func testProminentColorsPerformanceWithWeightedSRGBDifference() throws {
#if !canImport(CoreImage)
        try skipUnavailableAPI()
#else
        guard #available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *) else {
            throw XCTSkip("Performance measurements not present")
        }
        let img = try XCTUnwrap(CIImage(contentsOf: img4URL))
        measure(metrics: [XCTMemoryMetric(), XCTClockMetric()]) {
            _ = ImageColorsCalculator(image: img)
                .mostProminentColor(as: Float.self, distanceAs: .weightedSRGB)
        }
#endif
    }

    func testCGImageInitializer() throws {
#if !canImport(CoreImage) || !canImport(CoreGraphics)
        try skipUnavailableAPI()
#else
        let cgImage = CGImage(jpegDataProviderSource: img1URL.path.withCString { CGDataProvider(filename: $0)! },
                              decode: nil, shouldInterpolate: false, intent: .defaultIntent)!
        let calculator = ImageColorsCalculator(cgImage: cgImage)
        XCTAssertNotNil(calculator)
#endif
    }

    func testUIImageInitializer() async throws {
#if !canImport(CoreImage) || !canImport(UIKit)
        try skipUnavailableAPI()
#else
        guard #available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *) else {
            throw XCTSkip("MainActor not present")
        }

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

        let uiImage = try XCTUnwrap(UIImage(contentsOfFile: img1URL.path))
        let calculator = ImageColorsCalculator(uiImage: uiImage)
        XCTAssertNotNil(calculator)
        let uiImage2 = try await MainActor.run { [img2URL] in try XCTUnwrap(NonCIUIImage(contentsOfFile: img2URL.path)) }
        let calculator2 = ImageColorsCalculator(uiImage: uiImage2)
        XCTAssertNotNil(calculator2)
        let uiImage3 = try await MainActor.run { [img1URL] in try NonCGUIImage(ciImage: XCTUnwrap(CIImage(contentsOf: img1URL))) }
        let calculator3 = ImageColorsCalculator(uiImage: uiImage3)
        XCTAssertNotNil(calculator3)
        let uiImage4 = try await MainActor.run { [img1URL] in try XCTUnwrap(NonBackingUIImage(contentsOfFile: img1URL.path)) }
        let calculator4 = ImageColorsCalculator(uiImage: uiImage4)
        XCTAssertNil(calculator4)
#endif
    }

    func testNSImageInitializer() throws {
#if !canImport(AppKit) && !targetEnvironment(macCatalyst)
        try skipUnavailableAPI()
#else
        let nsImage = NSImage(contentsOf: img3URL)!
        let calculator = ImageColorsCalculator(nsImage: nsImage)
        XCTAssertNotNil(calculator)
#endif
    }
}
