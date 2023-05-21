extension HSB where Value: BinaryFloatingPoint {
    /// Creates new HSB components using the given RGB components.
    /// - Parameter rgb: The RGB components to convert to HSB.
    public init(rgb: RGB<Value>) {
        let (hue, xValues, delta) = rgb.hsbvValues
        self.init(hue: hue,
                  saturation: xValues.max.isZero ? .zero : delta / xValues.max,
                  brightness: xValues.max)
    }
}

extension HSBA where Value: BinaryFloatingPoint {
    /// Creates new HSBA components using the given RGBA components.
    /// - Parameter rgba: The RGBA components to convert to HSBA.
    /// - SeeAlso: `HSB.init(rgb:)`
    @inlinable
    public init(rgba: RGBA<Value>) {
        self.init(hsb: HSB(rgb: rgba.rgb), alpha: rgba.alpha)
    }
}

extension HSB where Value: BinaryInteger {
    /// Creates new HSB components using the given RGB components.
    /// - Parameter rgb: The RGB components to convert to HSB.
    public init(rgb: RGB<Value>) {
        // FIXME: Can we perform a better conversion here?
        self.init(HSB<Double>(rgb: RGB<Double>(rgb)))
    }
}

extension HSBA where Value: BinaryInteger {
    /// Creates new HSBA components using the given RGBA components.
    /// - Parameter rgba: The RGBA components to convert to HSBA.
    /// - SeeAlso: `HSB.init(rgb:)`
    @inlinable
    public init(rgba: RGBA<Value>) {
        self.init(hsb: HSB(rgb: rgba.rgb), alpha: rgba.alpha)
    }
}
