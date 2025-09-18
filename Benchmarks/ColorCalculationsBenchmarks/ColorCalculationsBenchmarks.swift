import Benchmark
import ColorCalculations

#if canImport(CoreImage)
import CoreImage
fileprivate let coreImageAvailable = true
#else
fileprivate let coreImageAvailable = false
#endif

fileprivate func createImage4() -> CIImage? {
    let img4URL = Bundle.module.url(forResource: "img4",
                                    withExtension: "jpg",
                                    subdirectory: "TestImages")
    return img4URL.flatMap { CIImage(contentsOf: $0) }
}

let benchmarks: @Sendable () -> Void = {
    let apiAvailable = if #available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *) { true } else { false }

    Benchmark("ProminentColorsWithLinearSRGBDifference",
              configuration: .init(
                metrics: .default + .memory,
                skip: !coreImageAvailable || !apiAvailable
              )) { benchmark in
        guard #available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *) else { return }
#if canImport(CoreImage)
        guard let img = createImage4() else {
            benchmark.error("Could not create CIImage!")
            return
        }
        benchmark.startMeasurement()
        _ = ImageColorsCalculator(image: img)
            .mostProminentColor(as: Float.self, distanceAs: .linearSRGB)
        benchmark.stopMeasurement()
#endif
    }

    Benchmark("ProminentColorsWithWeightedSRGBDifference",
              configuration: .init(
                metrics: .default + .memory,
                skip: !coreImageAvailable || !apiAvailable
              )) { benchmark in
        guard #available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *) else { return }
#if canImport(CoreImage)
        guard let img = createImage4() else {
            benchmark.error("Could not create CIImage!")
            return
        }
        benchmark.startMeasurement()
        _ = ImageColorsCalculator(image: img)
            .mostProminentColor(as: Float.self, distanceAs: .weightedSRGB)
        benchmark.stopMeasurement()
#endif
    }
}
