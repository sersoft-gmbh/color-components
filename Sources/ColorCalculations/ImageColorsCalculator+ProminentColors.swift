import CoreImage
import ColorComponents

extension ImageColorsCalculator {
    /// Calculates the most prominent colors in the image, optionally restricting it to a given rect.
    /// - Parameters:
    ///   - rect: The rect to restrict the calculation to. If `nil`, the image's extent is used. Defaults to `nil`.
    ///   - pixelLimit: The limit of pixels to process. Increasing this limit will also increase the computation time. Defaults to `2048`.
    /// - Returns: An array of the most prominent colors in the image, ordered by prominence (highest to lowest).
    func prominentColors<V>(as _: V.Type = V.self, in rect: CGRect? = nil, pixelLimit: Int = 2048) -> [RGB<V>]
    where V: SIMDScalar, V: BinaryFloatingPoint
    {
        assert(pixelLimit > 0)
        let img = (rect.map(image.cropped(to:)) ?? image).limitedTo(pixelCount: pixelLimit)
        var pixels = Array<UInt8>(repeating: 0, count: Int(floor(img.extent.width * img.extent.height)) * 4)
        context.render(img,
                       toBitmap: &pixels,
                       rowBytes: Int(floor(img.extent.width)) * 4,
                       bounds: img.extent,
                       format: .RGBA8,
                       colorSpace: nil)
        func pow2(_ base: V) -> V { base * base }
        return (stride(from: pixels.startIndex, to: pixels.endIndex, by: 4)
            .lazy
            .filter { pixels[$0 + 3] == 0xFF } // only opaque colors are taken into account
            .map {
                SIMD3<V>(V(pixels[$0 + 0]) / 0xFF,
                         V(pixels[$0 + 1]) / 0xFF,
                         V(pixels[$0 + 2]) / 0xFF)
            } as Array<SIMD3<V>>)
            .kMeansClustered(atMost: pixelLimit / 64) { pow2($1.x - $0.x) + pow2($1.y - $0.y) + pow2($1.z - $0.z) }
            .sorted { $0.size > $1.size }
            .map { RGB<V>(red: $0.centroid.x, green: $0.centroid.y, blue: $0.centroid.z) }
    }

    /// Calculates the color that is most prominent in the image, optionally restricting it to a given rect.
    /// - Parameters:
    ///   - rect: The rect to restrict the calculation to. If `nil`, the image's extent is used. Defaults to `nil`.
    ///   - pixelLimit: The limit of pixels to process. Increasing this limit will also increase the computation time. Defaults to `2048`.
    /// - Returns: The most prominent color in the image.
    public func mostProminentColor<V>(as _: V.Type = V.self,
                                      in rect: CGRect? = nil,
                                      pixelLimit: Int = 2048) -> RGB<V>
    where V: SIMDScalar, V: BinaryFloatingPoint
    {
        prominentColors(in: rect, pixelLimit: pixelLimit).first ?? RGB<V>(red: 0, green: 0, blue: 0)
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

fileprivate struct Cluster<Vec: SIMD> where Vec.Scalar: FloatingPoint, Vec.Scalar: ExpressibleByFloatLiteral {
    var centroid: Vec
    var size: Vec.Scalar

    static var zero: Cluster { .init(centroid: .zero, size: 0) }
}

fileprivate extension RandomAccessCollection
where Index: FixedWidthInteger, Element: SIMD, Element.Scalar: FloatingPoint, Element.Scalar: ExpressibleByFloatLiteral
{
    // See http://users.eecs.northwestern.edu/~wkliao/Kmeans/
    func kMeansClustered(atMost maxK: Int, threshold: Element.Scalar = 0.001, distance: (Element, Element) -> Element.Scalar) -> [Cluster<Element>] {
        var clusters = randomElements(count: Swift.min(maxK, count)).map { Cluster(centroid: $0, size: 0) }
        var memberships = Array<Int>(repeating: -1, count: count)
        var (error, prevError): (Element.Scalar, Element.Scalar) = (0, 0)
        repeat {
            error = 0
            var newClusters = Array<Cluster<Element>>(repeating: .zero, count: clusters.count)

            enumerated().forEach {
                let idx = clusters.nearestClusterIndex(for: $0.element, distance: distance)
                if memberships[$0.offset] != idx {
                    error += 1
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
            prevError = error
        } while abs(error - prevError) > threshold

        return clusters
    }
}

fileprivate extension RandomAccessCollection {
    func nearestClusterIndex<Vec>(for point: Vec, distance: (Vec, Vec) -> Vec.Scalar) -> Index
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
    func randomElements(count elemCount: Int) -> [Element] {
        guard !isEmpty else { return [] }
        guard count > elemCount else { return Array(self) }

        var indices = Set<Index>()
        indices.reserveCapacity(elemCount)
        let indexRange = startIndex..<endIndex
        var randomGen = SystemRandomNumberGenerator()
        while indices.count < elemCount {
            indices.insert(.random(in: indexRange, using: &randomGen))
        }

        return indices.map { self[$0] }
    }
}
