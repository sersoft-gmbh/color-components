extension RGB where Value: BinaryFloatingPoint {
    /// Creates new RGB components using the given CIE.XYZ components.
    /// - Parameter cieXYZ: The CIE.XYZ components to convert to RGB.
    public init(cieXYZ: CIE.XYZ<Value>) {
        /*
         [ R ]     [  3.240479 -1.537150 -0.498535 ]  [ X ]
         [ G ]  =  [ -0.969256  1.875992  0.041556 ]  [ Y ]
         [ B ]     [  0.055648 -0.204043  1.057311 ]  [ Z ]
         */
        self.init(red: min(max(3.240479 * cieXYZ.x + -1.537150 * cieXYZ.y + -0.498535 * cieXYZ.z, 0), 1),
                  green: min(max(-0.969256 * cieXYZ.x + 1.875992 * cieXYZ.y + 0.041556 * cieXYZ.z, 0), 1),
                  blue: min(max(0.055648 * cieXYZ.x + -0.204043 * cieXYZ.y + 1.057311 * cieXYZ.z, 0), 1))
    }
}

extension RGB where Value: BinaryInteger {
    /// Creates new RGB components using the given CIE.XYZ components.
    /// - Parameter hsb: The CIE.XYZ components to convert to RGB.
    public init(cieXYZ: CIE.XYZ<Value>) {
        // FIXME: Is there a better way to convert this?
        self.init(RGB<Double>(cieXYZ: CIE.XYZ<Double>(cieXYZ)))
    }
}

extension RGBA where Value: BinaryFloatingPoint {
    /// Creates new RGBA components using the given CIE.XYZA components.
    /// - Parameter cieXYZA: The CIE.XYZA components to convert to RGBA.
    @inlinable
    public init(cieXYZA: CIE.XYZA<Value>) {
        self.init(rgb: RGB(cieXYZ: cieXYZA.xyz), alpha: cieXYZA.alpha)
    }
}

extension RGBA where Value: BinaryInteger {
    /// Creates new RGBA components using the given CIE.XYZA components.
    /// - Parameter cieXYZA: The CIE.XYZA components to convert to RGBA.
    @inlinable
    public init(cieXYZA: CIE.XYZA<Value>) {
        self.init(rgb: RGB(cieXYZ: cieXYZA.xyz), alpha: cieXYZA.alpha)
    }
}
