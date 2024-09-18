// FIXME: This compiler directive dance is only needed because the Swift 5.9 compiler seems to try to parse the `compiler(>=5.10)`
//        directive's contents when it's nested in another `#if`.
//        Swift 5.10 seems to fix this - revert to one big outer `#if canImport(CoreGraphics)` once Swift 5.9 support is dropped.
#if canImport(CoreGraphics)
public import CoreGraphics
#endif

#if canImport(CoreGraphics) && compiler(>=5.10) && hasFeature(StrictConcurrency) && hasFeature(GlobalConcurrency)
extension CGColorSpace {
    // There seems to be no constants for these in CoreGraphics...
    static nonisolated(unsafe) let genericGray: CFString = "kCGColorSpaceGenericGray" as CFString
    static nonisolated(unsafe) let genericRGB: CFString = "kCGColorSpaceGenericRGB" as CFString
}
#elseif canImport(CoreGraphics)
extension CGColorSpace {
    static let genericGray: CFString = "kCGColorSpaceGenericGray" as CFString
    static let genericRGB: CFString = "kCGColorSpaceGenericRGB" as CFString
}
#endif

#if canImport(CoreGraphics)
extension CGColorSpace {
    static func _require(named colorSpaceName: CFString, file: StaticString = #file, line: UInt = #line) -> CGColorSpace {
        guard let colorSpace = CGColorSpace(name: colorSpaceName)
        else { fatalError("Could not create color space named \(colorSpaceName)", file: file, line: line) }
        return colorSpace
    }
}

extension CGColor {
    @usableFromInline
    static func _makeRequired(in colorSpaceName: CFString, components: UnsafePointer<CGFloat>,
                              file: StaticString = #file, line: UInt = #line) -> CGColor {
        let colorSpace = CGColorSpace._require(named: colorSpaceName, file: file, line: line)
        guard let color = CGColor(colorSpace: colorSpace, components: components)
        else { fatalError("Could not create CGColor in \(colorSpace) with components \(components)") }
        return color
    }

    @usableFromInline
    func _requireCompontens(in range: some RangeExpression<Int>,
                            file: StaticString = #file,
                            line: UInt = #line) -> Array<CGFloat> {
        guard range.contains(numberOfComponents), let components
        else { fatalError("CGColor has no or an invalid number of components: \(self)", file: file, line: line) }
        return components
    }
}

@available(macOS 10.11, iOS 10, tvOS 10, watchOS 3, *)
extension CGColor {
    @usableFromInline
    func _requireConverted(to colorSpaceName: CFString, file: StaticString = #file, line: UInt = #line) -> CGColor {
        let colorSpace = CGColorSpace._require(named: colorSpaceName, file: file, line: line)
        guard let color = converted(to: colorSpace, intent: .defaultIntent, options: nil)
        else { fatalError("Could not convert CGColor \(self) to \(colorSpace) (\(colorSpaceName))", file: file, line: line) }
        return color
    }

    @inlinable
    func _requireColorSpace(named colorSpaceName: CFString, file: StaticString = #file, line: UInt = #line) -> CGColor {
        guard colorSpace?.name != colorSpaceName else { return self }
        return _requireConverted(to: colorSpaceName, file: file, line: line)
    }

    // Currently unused
//    @inlinable
//    func _requireColorSpace(in colorSpaceNames: Set<CFString>,
//                            convertingTo colorSpaceName: CFString,
//                            file: StaticString = #file, line: UInt = #line) -> CGColor {
//        guard colorSpace?.name.map(colorSpaceNames.contains) != true else { return self }
//        return _requireConverted(to: colorSpaceName, file: file, line: line)
//    }
}
#endif
