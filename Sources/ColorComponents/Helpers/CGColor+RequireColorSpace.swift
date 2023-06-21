#if canImport(CoreGraphics)
import CoreGraphics

extension CGColorSpace {
    // There seems to be no constants for these in CoreGraphics...
    static let genericGray: CFString = "kCGColorSpaceGenericGray" as CFString
    static let genericRGB: CFString = "kCGColorSpaceGenericRGB" as CFString
}

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
    func _requireCompontens<R: RangeExpression>(in range: R, file: StaticString = #file, line: UInt = #line) -> Array<CGFloat>
    where R.Bound == Int
    {
        guard range.contains(numberOfComponents), let components = components
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