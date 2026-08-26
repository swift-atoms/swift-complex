extension Complex.Imaginary {

    public struct Equals {
        @usableFromInline
        let imaginary: Complex.Imaginary<Scalar>

        @usableFromInline
        internal init(_ imaginary: Complex.Imaginary<Scalar>) {
            self.imaginary = imaginary
        }
    }
}

extension Complex.Imaginary.Equals: Sendable where Scalar: Sendable {}

extension Complex.Imaginary {

    @inlinable
    public var equals: Equals {
        Equals(self)
    }
}

extension Complex.Imaginary.Equals where Scalar: BinaryFloatingPoint {

    @inlinable
    public func approximate(
        _ other: Complex.Imaginary<Scalar>,
        tolerance: Complex.Real<Scalar>
    ) -> Bool {
        abs(imaginary._value - other._value) <= tolerance._value
    }

    @inlinable
    public func approximate(
        _ other: Complex.Imaginary<Scalar>,
        absolute: Complex.Real<Scalar>,
        relative: Complex.Real<Scalar> = .zero
    ) -> Bool {
        let diff = abs(imaginary._value - other._value)
        let scale = max(abs(imaginary._value), abs(other._value))
        return diff <= absolute._value + relative._value * scale
    }
}
