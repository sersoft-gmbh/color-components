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
        XCTAssertEqual(calculator3.averageColor(in: CGRect(origin: CGPoint(x: 50, y: 50),
                                                           size: CGSize(width: 1, height: 1))),
                       RGBA(red: 32, green: 30, blue: 28, alpha: 0xFF))
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

    func testCGImageInitializer() throws {
        #if !canImport(CoreGraphics)
        try skipUnavailableAPI()
        #else
        let cgImage = CGImage(jpegDataProviderSource: img1URL.path.withCString { CGDataProvider(filename: $0)! },
                              decode: nil, shouldInterpolate: false, intent: .defaultIntent)!
        let calculator = ImageColorsCalculator(cgImage: cgImage)
        XCTAssertNotNil(calculator)
        #endif
    }

    func testUIImageInitializer() throws {
        #if !canImport(UIKit)
        try skipUnavailableAPI()
        #else
        final class NonCIUIImage: UIImage {
            override var ciImage: CIImage? { nil }
        }
        
        let uiImage = UIImage(contentsOfFile: img1URL.path)!
        let calculator = ImageColorsCalculator(uiImage: uiImage)
        XCTAssertNotNil(calculator)
        let uiImage2 = NonCIUIImage(contentsOfFile: img2URL.path)!
        let calculator2 = ImageColorsCalculator(uiImage: uiImage2)
        XCTAssertNotNil(calculator2)
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
