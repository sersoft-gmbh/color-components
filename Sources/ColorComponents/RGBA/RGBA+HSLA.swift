extension RGB where Value: BinaryFloatingPoint {
    /// Creates new RGB components using the given HSL components.
    /// - Parameter hsl: The HSL components to convert to RGB.
    public init(hsl: HSL<Value>) {
        let chroma = (1 - abs(2 * hsl.luminance - 1)) * hsl.saturation
        self.init(hue: hsl.hue, chroma: chroma, match: hsl.luminance - chroma / 2)
    }
}

extension RGBA where Value: BinaryFloatingPoint {
    /// Creates new RGBA components using the given HSLA components.
    /// - Parameter hsla: The HSLA components to convert to RGBA.
    /// - SeeAlso: `RGB.init(hsl:)`
    @inlinable
    public init(hsla: HSLA<Value>) {
        self.init(rgb: RGB(hsl: hsla.hsl), alpha: hsla.alpha)
    }
}

extension RGB where Value: BinaryInteger {
    /// Creates new RGB components using the given HSL components.
    /// - Parameter hsl: The HSL components to convert to RGB.
    public init(hsl: HSL<Value>) {
        // FIXME: Can we perform a better conversion here?
        self.init(RGB<Double>(hsl: HSL<Double>(hsl)))
    }
}

extension RGBA where Value: BinaryInteger {
    /// Creates new RGBA components using the given HSLA components.
    /// - Parameter hsla: The HSLA components to convert to RGBA.
    /// - SeeAlso: `RGB.init(hsl:)`
    @inlinable
    public init(hsla: HSLA<Value>) {
        self.init(rgb: RGB(hsl: hsla.hsl), alpha: hsla.alpha)
    }
}
