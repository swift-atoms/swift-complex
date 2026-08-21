extension Complex.Real {

    public struct Equals {
        @usableFromInline
        let real: Complex.Real<Scalar>

        @usableFromInline
        internal init(_ real: Complex.Real<Scalar>) {
            self.real = real
        }
    }
}

extension Complex.Real.Equals: Sendable where Scalar: Sendable {}

extension Complex.Real {

    @inlinable
    public var equals: Equals {
        Equals(self)
    }
}

extension Complex.Real.Equals where Scalar: BinaryFloatingPoint {

    @inlinable
    public func approximate(_ other: Complex.Real<Scalar>, tolerance: Complex.Real<Scalar>) -> Bool
    {
        abs(real._value - other._value) <= tolerance._value
    }

    @inlinable
    public func approximate(
        _ other: Complex.Real<Scalar>,
        absolute: Complex.Real<Scalar>,
        relative: Complex.Real<Scalar> = .zero
    ) -> Bool {
        let diff = abs(real._value - other._value)
        let scale = max(abs(real._value), abs(other._value))
        return diff <= absolute._value + relative._value * scale
    }
}
