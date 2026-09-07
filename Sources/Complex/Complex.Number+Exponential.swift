extension Complex.Number where Scalar: BinaryFloatingPoint & Exponential.`Protocol` {
    /// Scales an exponential component without overflowing exp(x) before a small coefficient applies.
    @inlinable
    internal static func _exponentialComponent(_ coefficient: Scalar, exponent: Scalar, halved: Bool = false) -> Scalar {
        if coefficient == 0 { return coefficient }
        if exponent < Scalar.log(Scalar.greatestFiniteMagnitude) - 1 {
            let magnitude = Scalar.exp(exponent)
            return coefficient * (halved ? magnitude / 2 : magnitude)
        }
        let half = Scalar.exp(exponent / 2)
        if half.isFinite { return (coefficient * half) * (halved ? half / 2 : half) }
        let adjusted = exponent + Scalar.log(coefficient.magnitude) - (halved ? Scalar.log(2) : 0)
        return Scalar(signOf: coefficient, magnitudeOf: Scalar.exp(adjusted))
    }
}
