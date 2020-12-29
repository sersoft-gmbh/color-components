extension HSB where Value: BinaryFloatingPoint {
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
    @inlinable
    public init(rgba: RGBA<Value>) {
        self.init(hsb: HSB(rgb: rgba.rgb), alpha: rgba.alpha)
    }
}
