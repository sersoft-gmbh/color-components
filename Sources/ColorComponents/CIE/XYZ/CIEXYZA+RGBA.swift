extension CIE.XYZ where Value: BinaryFloatingPoint {
    /// Creates new XYZ components using the given RGB components.
    /// - Parameter rgb: The RGB components to convert to XYZ.
    public init(rgb: RGB<Value>) {
        /*
         [ X ]     [  0.412453  0.357580  0.180423 ]  [ R ]
         [ Y ]  =  [  0.212671  0.715160  0.072169 ]  [ G ]
         [ Z ]     [  0.019334  0.119193  0.950227 ]  [ B ]
         */
        self.init(x: min(max(0.412453 * rgb.red + 0.357580 * rgb.green + 0.180423 * rgb.blue, 0), 1),
                  y: min(max(0.212671 * rgb.red + 0.715160 * rgb.green + 0.072169 * rgb.blue, 0), 1),
                  z: min(max(0.019334 * rgb.red + 0.119193 * rgb.green + 0.950227 * rgb.blue, 0), 1))
    }
}

extension CIE.XYZA where Value: BinaryFloatingPoint {
    /// Creates new XYZA components using the given RGBA components.
    /// - Parameter rgba: The XYZA components to convert to XYZA.
    /// - SeeAlso: ``CIE.XYZ.init(rgb:)``
    @inlinable
    public init(rgba: RGBA<Value>) {
        self.init(xyz: CIE.XYZ(rgb: rgba.rgb), alpha: rgba.alpha)
    }
}

extension CIE.XYZ where Value: BinaryInteger {
    /// Creates new HSB components using the given RGB components.
    /// - Parameter rgb: The RGB components to convert to CIE.XYZ.
    public init(rgb: RGB<Value>) {
        // FIXME: Can we perform a better conversion here?
        self.init(CIE.XYZ<Double>(rgb: RGB<Double>(rgb)))
    }
}

extension CIE.XYZA where Value: BinaryInteger {
    /// Creates new CIE.XYZ components using the given RGBA components.
    /// - Parameter rgba: The RGBA components to convert to CIE.XYZ.
    /// - SeeAlso: ``CIE.XYZ.init(rgb:)``
    @inlinable
    public init(rgba: RGBA<Value>) {
        self.init(xyz: CIE.XYZ(rgb: rgba.rgb), alpha: rgba.alpha)
    }
}
