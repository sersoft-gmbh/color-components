extension HSB where Value: BinaryFloatingPoint {
    /// Creates new HSB components using the given RGB components.
    /// - Parameter rgb: The RGB components to convert to HSB.
    public init(rgb: RGB<Value>) {
        let maxVal = max(rgb.red, rgb.green, rgb.blue)
        let delta = maxVal - min(rgb.red, rgb.green, rgb.blue)
        let hue: Value
        if delta.isZero {
            hue = .zero
        } else {
            switch maxVal {
            case rgb.red:   hue =     (rgb.green - rgb.blue)  / delta
            case rgb.green: hue = 2 + (rgb.blue  - rgb.red)   / delta
            case rgb.blue:  hue = 4 + (rgb.red   - rgb.green) / delta
            default: fatalError("max(r, g, b) must be one of r, g, b!")
            }
        }
        self.init(hue: hue / 6, saturation: maxVal.isZero ? .zero : delta / maxVal, brightness: maxVal)
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
