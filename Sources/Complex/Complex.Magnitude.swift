extension Complex.Number {

    public struct Magnitude {
        @usableFromInline
        let complex: Complex.Number<Scalar>

        @usableFromInline
        internal init(_ complex: Complex.Number<Scalar>) {
            self.complex = complex
        }
    }
}

extension Complex.Number.Magnitude: Sendable where Scalar: Sendable {}

extension Complex.Number {

    @inlinable
    public var magnitude: Magnitude {
        Magnitude(self)
    }
}

extension Complex.Number.Magnitude where Scalar: BinaryFloatingPoint & Numeric.Transcendental {

    @inlinable
    public func callAsFunction() -> Complex.Real<Scalar> {
        Complex.Real(Scalar._hypot(complex.real._value, complex.imaginary._value))
    }

    @inlinable
    public var squared: Complex.Real<Scalar> {
        Complex.Real(
            complex.real._value * complex.real._value + complex.imaginary._value
                * complex.imaginary._value
        )
    }
}
