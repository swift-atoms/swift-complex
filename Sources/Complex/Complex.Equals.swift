extension Complex.Number {

    public struct Equals {
        @usableFromInline
        let complex: Complex.Number<Scalar>

        @usableFromInline
        internal init(_ complex: Complex.Number<Scalar>) {
            self.complex = complex
        }
    }
}

extension Complex.Number.Equals: Sendable where Scalar: Sendable {}

extension Complex.Number {

    @inlinable
    public var equals: Equals {
        Equals(self)
    }
}

extension Complex.Number.Equals where Scalar: BinaryFloatingPoint & Numeric.Transcendental {

    @inlinable
    public func approximate(
        _ other: Complex.Number<Scalar>,
        tolerance: Complex.Real<Scalar>
    ) -> Bool {
        (complex - other).magnitude() <= tolerance
    }

    @inlinable
    public func approximate(
        _ other: Complex.Number<Scalar>,
        absolute: Complex.Real<Scalar>,
        relative: Complex.Real<Scalar> = .zero
    ) -> Bool {
        let diff = (complex - other).magnitude()
        let scale = max(complex.magnitude(), other.magnitude())
        return diff <= absolute + relative * scale
    }
}

extension Complex.Number.Equals {

    public struct Componentwise {
        @usableFromInline
        let complex: Complex.Number<Scalar>

        @usableFromInline
        internal init(_ complex: Complex.Number<Scalar>) {
            self.complex = complex
        }
    }
}

extension Complex.Number.Equals.Componentwise: Sendable where Scalar: Sendable {}

extension Complex.Number.Equals {

    @inlinable
    public var componentwise: Componentwise {
        Componentwise(complex)
    }
}

extension Complex.Number.Equals.Componentwise where Scalar: BinaryFloatingPoint {

    @inlinable
    public func approximate(
        _ other: Complex.Number<Scalar>,
        tolerance: Complex.Real<Scalar>
    ) -> Bool {
        abs(complex.real._value - other.real._value) <= tolerance._value
            && abs(complex.imaginary._value - other.imaginary._value) <= tolerance._value
    }
}
