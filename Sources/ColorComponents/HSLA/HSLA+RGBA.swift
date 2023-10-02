extension HSL where Value: BinaryFloatingPoint {
    /// Creates new HSL components using the given RGB components.
    /// - Parameter rgb: The RGB components to convert to HSL.
    public init(rgb: RGB<Value>) {
        let (hue, xValues, _) = rgb.hsbvValues
        let luminance = (xValues.min + xValues.max) / 2
        self.init(hue: hue,
                  saturation: luminance.isZero || luminance == 1 ? .zero : (xValues.max - luminance) / min(luminance, 1 - luminance),
                  luminance: luminance)
    }
}

extension HSLA where Value: BinaryFloatingPoint {
    /// Creates new HSLA components using the given RGBA components.
    /// - Parameter rgba: The RGBA components to convert to HSLA.
    /// - SeeAlso: ``HSL/init(rgb:)``
    @inlinable
    public init(rgba: RGBA<Value>) {
        self.init(hsl: HSL(rgb: rgba.rgb), alpha: rgba.alpha)
    }
}

extension HSL where Value: BinaryInteger {
    /// Creates new HSL components using the given RGB components.
    /// - Parameter rgb: The RGB components to convert to HSL.
    public init(rgb: RGB<Value>) {
        // FIXME: Can we perform a better conversion here?
        self.init(HSL<Double>(rgb: RGB<Double>(rgb)))
    }
}

extension HSLA where Value: BinaryInteger {
    /// Creates new HSLA components using the given RGBA components.
    /// - Parameter rgba: The RGBA components to convert to HSLA.
    /// - SeeAlso: ``HSL/init(rgb:)``
    @inlinable
    public init(rgba: RGBA<Value>) {
        self.init(hsl: HSL(rgb: rgba.rgb), alpha: rgba.alpha)
    }
}
