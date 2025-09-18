#if canImport(CoreImage)
public import CoreGraphics
internal import CoreImage
public import ColorComponents

extension ImageColorsCalculator {
    /// Describes the mode that is used to calculate color distances.
    public enum ColorDistanceMode: Sendable, Hashable {
        /// Unweighted, linear sRGB calculation.
        case linearSRGB
        /// Weighted sRGB calculation. R, G and B values are weighted to approximate human perception.
        case weightedSRGB
    }

    private func _prominentColorClusters<V>(as type: V.Type,
                                            in rect: CGRect?,
                                            distanceAs colorDistance: ColorDistanceMode,
                                            pixelLimit: Int,
                                            colorLimit: Int) -> Array<Cluster<SIMD3<V>>>
    where V: SIMDScalar, V: BinaryFloatingPoint
    {
        assert(pixelLimit > 0)
        assert(colorLimit > 0)
        let img = (rect.map(image.cropped(to:)) ?? image).limitedTo(pixelCount: pixelLimit)
        var pixels = Array<UInt8>(repeating: 0, count: Int(floor(img.extent.width * img.extent.height)) * 4)
#if compiler(>=6.2)
        unsafe context.render(img,
                              toBitmap: &pixels,
                              rowBytes: Int(floor(img.extent.width)) * 4,
                              bounds: img.extent,
                              format: .RGBA8,
                              colorSpace: nil)
#else
        context.render(img,
                       toBitmap: &pixels,
                       rowBytes: Int(floor(img.extent.width)) * 4,
                       bounds: img.extent,
                       format: .RGBA8,
                       colorSpace: nil)
#endif
        // FIXME: This check is currently a bit over-simplified. We should probably be more clever about this
        //        and only do it if there are no colors above the brightness limit...
        let ignoreBrightness = pixels.count <= 128 * 4
        // FIXME: There is room for improvement by not having to convert the colors during the distance calculation
        //        but doing so beforehand.
        let distanceCalculation: (SIMD3<V>, SIMD3<V>) -> V
        switch colorDistance {
        case .linearSRGB: distanceCalculation = { ($1.x - $0.x).squared() + ($1.y - $0.y).squared() + ($1.z - $0.z).squared() }
        case .weightedSRGB: distanceCalculation = { $0.sRGBColorDistance(to: $1) }
        }
        var randomGen = SystemRandomNumberGenerator()
        return (
            stride(from: pixels.startIndex, to: pixels.endIndex, by: 4)
                .lazy
                .map { RGBA<UInt8>(red: pixels[$0], green: pixels[$0 + 1], blue: pixels[$0 + 2], alpha: pixels[$0 + 3]) }
                .lazyFilter { $0.alpha == 0xFF } // only opaque colors are taken into account
                .map { RGB<V>($0.rgb) }
                .lazyFilter { ignoreBrightness || $0.brightness > 0.05 } // For large images, filter colors with a low brightness.
                .map { SIMD3<V>($0.red, $0.green, $0.blue) } as Array<SIMD3<V>>
        )
        .kMeansClustered(atMost: colorLimit, using: &randomGen, distance: distanceCalculation)
    }

    /// Calculates the most prominent colors in the image, optionally restricting it to a given rect.
    /// - Parameters:
    ///   - type: The floating point type in which the color components should be returned.
    ///   - rect: The rect to restrict the calculation to. If `nil`, the image's extent is used. Defaults to `nil`.
    ///   - colorDistance: The color distance calculation mode to use. Defaults to `.linearSRGB`.
    ///   - pixelLimit: The limit of pixels to process. Increasing this limit will also increase the computation time. Defaults to `1024`.
    ///   - colorLimit: The maximum number of colors to consider (cluster size). This will be the maximum size of the returned array. Defaults to `8`.
    /// - Returns: An array of the most prominent colors in the image, ordered by prominence (highest to lowest).
    public func prominentColors<V>(as type: V.Type = V.self,
                                   in rect: CGRect? = nil,
                                   distanceAs colorDistance: ColorDistanceMode = .linearSRGB,
                                   pixelLimit: Int = 1024,
                                   colorLimit: Int = 8) -> Array<RGB<V>>
    where V: SIMDScalar, V: BinaryFloatingPoint
    {
        _prominentColorClusters(as: type, in: rect, distanceAs: colorDistance, pixelLimit: pixelLimit, colorLimit: colorLimit)
            .sorted { $0.size > $1.size }
            .map { $0.centroid.asRGB() }
    }

    /// Calculates the color that is most prominent in the image, optionally restricting it to a given rect.
    /// - Parameters:
    ///   - type: The floating point type in which the color components should be returned.
    ///   - rect: The rect to restrict the calculation to. If `nil`, the image's extent is used. Defaults to `nil`.
    ///   - colorDistance: The color distance calculation mode to use. Defaults to `.linearSRGB`.
    ///   - pixelLimit: The limit of pixels to process. Increasing this limit will also increase the computation time. Defaults to `1024`.
    ///   - colorLimit: The maximum number of colors to consider (cluster size). Defaults to `8`.
    /// - Returns: The most prominent color in the image.
    public func mostProminentColor<V>(as type: V.Type = V.self,
                                      in rect: CGRect? = nil,
                                      distanceAs colorDistance: ColorDistanceMode = .linearSRGB,
                                      pixelLimit: Int = 1024,
                                      colorLimit: Int = 8) -> RGB<V>
    where V: SIMDScalar, V: BinaryFloatingPoint
    {
        _prominentColorClusters(as: type, in: rect, distanceAs: colorDistance, pixelLimit: pixelLimit, colorLimit: colorLimit)
            .max { $0.size < $1.size }
            .map { $0.centroid.asRGB() }
        ?? RGB<V>(red: .zero, green: .zero, blue: .zero)
    }
}

// This fixes builds on Xcode 15+ - which somehow has issues distinguishing calls to `filter`...
// 09/25: Still needed for Xcode 26 / Swift 6.2 - in release mode
fileprivate extension LazySequenceProtocol {
    @_transparent
    func lazyFilter(_ isIncluded: @escaping (Elements.Element) -> Bool) -> LazyFilterSequence<Elements> {
        filter(isIncluded)
    }
}

fileprivate extension CIImage {
    func limitedTo(pixelCount: Int) -> CIImage {
        guard case let pixelCountF = CGFloat(pixelCount),
              case let actualPixelCount = extent.size.width * extent.size.height,
              actualPixelCount > pixelCountF
        else { return self }
        let ratio = extent.size.width / extent.size.height
        let maxWidth = (ratio * pixelCountF).squareRoot()
        let maxHeight = pixelCountF / maxWidth
        return transformed(by: .init(scaleX: maxWidth / extent.size.width,
                                     y: maxHeight / extent.size.height))
    }
}

fileprivate extension Numeric {
    @inline(__always)
    func squared() -> Self { self * self }
}

fileprivate extension RGB where Value: UnsignedInteger {
    func sRGBColorDistance<D>(to other: Self, in _: D.Type = D.self) -> D
    where D: BinaryFloatingPoint
    {
        let rM = D(red) + D(other.red) / 2
        let pR = (2 + rM / 256) * D(abs(red.distance(to: other.red))).squared()
        let pG = 4 * D(abs(green.distance(to: other.green))).squared()
        let pB = (2 + (255 - rM) / 256) * D(abs(blue.distance(to: other.blue))).squared()
        return (pR + pG + pB).squareRoot()
    }
}

fileprivate extension SIMD3 where Scalar: BinaryFloatingPoint {
    func asRGB() -> RGB<Scalar> { .init(red: x, green: y, blue: z) }

    private func asRGB<I: BinaryInteger>(of _: I.Type = I.self) -> RGB<I> {
        RGB<I>(asRGB())
    }

    func sRGBColorDistance(to other: Self) -> Scalar {
        asRGB(of: UInt8.self).sRGBColorDistance(to: other.asRGB())
    }
}

fileprivate struct Cluster<Vec: SIMD> where Vec.Scalar: BinaryFloatingPoint {
    var centroid: Vec
    var size: Vec.Scalar

    static var zero: Cluster { .init(centroid: .zero, size: .zero) }
}

extension Cluster: Sendable where Vec: Sendable, Vec.Scalar: Sendable {}

fileprivate extension RandomAccessCollection
where Index: FixedWidthInteger, Element: SIMD, Element.Scalar: BinaryFloatingPoint
{
    // The algorithm is described here: http://users.eecs.northwestern.edu/~wkliao/Kmeans/
    // We made a few adjustments, though:
    // - We have an iteration limit of 1024 iterations
    // - We stop after the first iteration that didn't have any errors (thus saving us the treshold).
    // - We dynamically lower `k` if the count is less than the desired `k`.
    func kMeansClustered(atMost maxK: Int,
                         using randomNumberGenerator: inout some RandomNumberGenerator,
                         distance: (Element, Element) -> some Comparable) -> Array<Cluster<Element>> {
        guard !isEmpty else { return .init() }

        var clusters = randomElements(count: Swift.min(maxK, count), using: &randomNumberGenerator)
            .map { Cluster(centroid: $0, size: .zero) }
        var memberships = Array<Int>(repeating: -1, count: count)
        var (errors, iters) = (0, 0)
        repeat {
            defer { iters += 1 }
            errors = 0
            var newClusters = Array<Cluster<Element>>(repeating: .zero, count: clusters.count)

            enumerated().forEach {
                let idx = clusters.nearestClusterIndex(for: $0.element, distance: distance)
                if memberships[$0.offset] != idx {
                    errors += 1
                    memberships[$0.offset] = idx
                }
                newClusters[idx].size += 1
                newClusters[idx].centroid += $0.element
            }
            newClusters.enumerated().forEach {
                clusters[$0.offset].size = $0.element.size
                if $0.element.size > 0 {
                    clusters[$0.offset].centroid = $0.element.centroid / $0.element.size
                }
            }
        } while errors > 0 && iters < 1024
#if DEBUG
        if iters >= 1024 {
            print("[ColorCalculator.prominentColors]: Exceeded clustering iteration limit...")
        }
#endif
        return clusters
    }
}

fileprivate extension RandomAccessCollection {
    func nearestClusterIndex<Vec>(for point: Vec, distance: (Vec, Vec) -> some Comparable) -> Index
    where Element == Cluster<Vec>
    {
        withoutActuallyEscaping(distance) { distance in
            indices
                .lazy
                .map { (idx: $0, dist: distance(point, self[$0].centroid)) }
                .min { $0.dist < $1.dist }!
                .idx
        }
    }
}

fileprivate extension RandomAccessCollection where Index: FixedWidthInteger {
    func randomElements(count elemCount: Int,
                        using randomGenerator: inout some RandomNumberGenerator) -> Array<Element> {
        guard !isEmpty else { return .init() }
        guard count > elemCount else { return Array(self) }

        // We collect the indices in a set, but the elements in an array to keep the random ordering.
        var indices = Set<Index>(minimumCapacity: elemCount)
        var elements = Array<Element>()
        elements.reserveCapacity(elemCount)
        let indexRange = startIndex..<endIndex
        while elements.count < elemCount {
            let idx = Index.random(in: indexRange, using: &randomGenerator)
            if indices.insert(idx).inserted {
                elements.append(self[idx])
            }
        }

        return elements
    }
}
#endif
