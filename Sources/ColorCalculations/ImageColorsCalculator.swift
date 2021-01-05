#if canImport(CoreImage)
import CoreImage
import CoreImage.CIFilterBuiltins
import ColorComponents

/// A calculator that calculates various colors for a given image.
public struct ImageColorsCalculator {
    /// The image of the calculator.
    public let image: CIImage

    private let context = CIContext()

    /// Creates a new calculator using the given image.
    /// - Parameter image: The image to calculate colors for.
    public init(image: CIImage) {
        self.image = image
    }

    private func rgba(for filter: CIFilter & CIAreaReductionFilter, in area: CGRect?) -> RGBA<UInt8> {
        filter.setDefaults()
        filter.inputImage = image
        filter.extent = area ?? image.extent
        let outputImg = filter.outputImage!
        assert(outputImg.extent.size == CGSize(width: 1, height: 1))
        var rgba = Array<UInt8>(repeating: 0, count: 4)
        context.render(outputImg,
                       toBitmap: &rgba,
                       rowBytes: rgba.count,
                       bounds: outputImg.extent,
                       format: .RGBA8,
                       colorSpace: nil)
        return RGBA(red: rgba[0], green: rgba[1], blue: rgba[2], alpha: rgba[3])
    }

    /// Calculates the average color for the image, optionally restricting it to a given rect.
    /// - Parameter rect: The rect to restrict the calculation to. If `nil`, the image's extent is used. Defaults to `nil`.
    /// - Returns: The average color of the image.
    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    public func averageColor(in rect: CGRect? = nil) -> RGBA<UInt8> {
        rgba(for: CIFilter.areaAverage(), in: rect)
    }

    /// Calculates the color with the maximum component values for the image, optionally restricting it to a given rect.
    /// - Parameter rect: The rect to restrict the calculation to. If `nil`, the image's extent is used. Defaults to `nil`.
    /// - Returns: The color with the maximum component values.
    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    public func maxComponentColor(in rect: CGRect? = nil) -> RGBA<UInt8> {
        rgba(for: CIFilter.areaMaximum(), in: rect)
    }

//    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
//    private func histogram(count: Int) -> [RGBA<Float>] {
//        let filter = CIFilter.areaHistogram()
//        filter.setDefaults()
//        filter.inputImage = image
//        filter.extent = image.extent
//        filter.count = count
//        filter.scale = 1
//        let outputImg = filter.outputImage!
//
//        let context = CIContext()
//        var rgba = Array<Float>(repeating: 0, count: count * 4)
//        context.render(outputImg,
//                       toBitmap: &rgba,
//                       rowBytes: rgba.count * MemoryLayout<Float>.size,
//                       bounds: outputImg.extent,
//                       format: .RGBAf,
//                       colorSpace: nil)
//        return stride(from: rgba.startIndex, to: rgba.endIndex, by: 4).map {
//            RGBA<Float>(red: rgba[$0],
//                        green: rgba[$0 + 1],
//                        blue: rgba[$0 + 2],
//                        alpha: rgba[$0 + 3])
//        }
//    }

//    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
//    public func colors(rasterCount: Int) -> [RGBA<UInt8>] {
//        let scaled = image.transformed(by: CGAffineTransform(scaleX: quality, y: quality))
//        let context = CIContext()
//        let size = floor(scaled.extent.width * scaled.extent.height)
//        var rgba = Array<UInt8>(repeating: 0, count: Int(size) * 4)
//        context.render(scaled,
//                       toBitmap: &rgba,
//                       rowBytes: rgba.count,
//                       bounds: scaled.extent,
//                       format: .RGBA8,
//                       colorSpace: nil)
//        return stride(from: rgba.startIndex, to: rgba.endIndex, by: 4).map {
//            RGBA<UInt8>(red: rgba[$0],
//                        green: rgba[$0 + 1],
//                        blue: rgba[$0 + 2],
//                        alpha: rgba[$0 + 3])
//        }
//    }
}
#endif
