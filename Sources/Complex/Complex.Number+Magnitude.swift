extension Complex.Number where Scalar: BinaryFloatingPoint {
    /// A scaled Euclidean norm using Swift arithmetic and squareRoot.
    /// Infinity dominates NaN, matching the extended-real hypot convention.
    @inlinable
    internal static func _hypot(_ x: Scalar, _ y: Scalar) -> Scalar {
        if x.isInfinite || y.isInfinite { return .infinity }
        if x.isNaN || y.isNaN { return .nan }
        let large = max(x.magnitude, y.magnitude)
        guard large != 0 else { return 0 }
        let exponent = large.exponent
        let a = Scalar(sign: .plus, exponent: -exponent, significand: x.magnitude)
        let b = Scalar(sign: .plus, exponent: -exponent, significand: y.magnitude)
        let square = (a * a).addingProduct(b, b)
        return Scalar(sign: .plus, exponent: exponent, significand: square.squareRoot())
    }
}
