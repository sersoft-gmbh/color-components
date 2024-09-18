#if canImport(AppKit) && !targetEnvironment(macCatalyst)
public import AppKit

@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension NSColor {
    @inlinable
    convenience init(colorSpace: NSColorSpace, components: Array<CGFloat>) {
        self.init(colorSpace: colorSpace, components: components, count: components.count)
    }

    @usableFromInline
    func _requireConverted(to targetColorSpace: NSColorSpace, file: StaticString = #file, line: UInt = #line) -> NSColor {
        guard let converted = usingColorSpace(targetColorSpace)
        else { fatalError("Could not convert NSColor \(self) to \(targetColorSpace)", file: file, line: line) }
        return converted
    }

    // Currently unused
//    @inlinable
//    func _requireColorSpace(_ targetColorSpace: NSColorSpace, file: StaticString = #file, line: UInt = #line) -> NSColor {
//        guard type != .componentBased || colorSpace != targetColorSpace else { return self }
//        return _requireConverted(to: targetColorSpace, file: file, line: line)
//    }

    @inlinable
    func _requireColorSpace(in targetColorSpaces: Set<NSColorSpace>,
                            convertingTo targetColorSpace: NSColorSpace,
                            file: StaticString = #file, line: UInt = #line) -> NSColor {
        guard type != .componentBased || !targetColorSpaces.contains(colorSpace) else { return self }
        return _requireConverted(to: targetColorSpace, file: file, line: line)
    }
}
#endif
