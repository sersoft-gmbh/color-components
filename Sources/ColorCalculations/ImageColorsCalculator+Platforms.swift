#if canImport(CoreImage)
#if canImport(CoreGraphics)
public import CoreGraphics

extension ImageColorsCalculator {
    /// Creates a calculator using the given `CGImage`.
    /// - Parameter cgImage: The `CGImage` to convert to a `CIImage` for calculations.
    @inlinable
    public init(cgImage: CGImage) {
        self.init(image: CIImage(cgImage: cgImage))
    }
}
#endif

#if canImport(UIKit)
public import UIKit

extension ImageColorsCalculator {
    /// Creates a calculator using the given `UIImage`. Returns `nil` if the `UIImage` could not be converted to a `CIImage`.
    /// - Parameter uiImage: The `UIImage` to convert to a `CIImage` for calculations.
    public init?(uiImage: UIImage) {
        if let ciImage = uiImage.ciImage {
            self.init(image: ciImage)
        } else if let cgImage = uiImage.cgImage {
            self.init(cgImage: cgImage)
        } else {
            return nil
        }
    }
}
#endif

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
public import AppKit

extension ImageColorsCalculator {
    /// Creates a calculator using the given `NSImage`. Returns `nil` if the `NSImage` could not be converted to a `CIImage`.
    /// - Parameter nsImage: The `NSImage` to convert to a `CIImage` for calculations.
    public init?(nsImage: NSImage) {
        guard let cgImage = nsImage.cgImage(forProposedRect: nil, context: nil, hints: nil)
        else { return nil }
        self.init(cgImage: cgImage)
    }
}
#endif
#endif
