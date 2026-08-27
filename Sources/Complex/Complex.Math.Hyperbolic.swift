public import Real

extension Complex.Number.Math where Scalar: BinaryFloatingPoint & Numeric.Transcendental {

    @inlinable
    public func cosh() -> Complex.Number<Scalar> {
        let z = complex
        guard z.isFinite else { return z }

        let x = z.real._value
        let y = z.imaginary._value

        let threshold = -Scalar._log(Scalar.ulpOfOne)
        guard abs(x) < threshold else {
            let phase = Complex.Number(Scalar._cos(y), Scalar._sin(y))
            let first = Scalar._exp(abs(x) / 2)
            let second = first / 2
            return phase.scalar.multiply(by: Complex.Real(first)).scalar.multiply(
                by: Complex.Real(second)
            )
        }

        return Complex.Number(
            Scalar._cosh(x) * Scalar._cos(y),
            Scalar._sinh(x) * Scalar._sin(y)
        )
    }

    @inlinable
    public func sinh() -> Complex.Number<Scalar> {
        let z = complex
        guard z.isFinite else { return z }

        let x = z.real._value
        let y = z.imaginary._value

        let threshold = -Scalar._log(Scalar.ulpOfOne)
        guard abs(x) < threshold else {
            let phase = Complex.Number(Scalar._cos(y), Scalar._sin(y))
            let first = Scalar._exp(abs(x) / 2)
            let second = Scalar(signOf: x, magnitudeOf: first / 2)
            return phase.scalar.multiply(by: Complex.Real(first)).scalar.multiply(
                by: Complex.Real(second)
            )
        }

        return Complex.Number(
            Scalar._sinh(x) * Scalar._cos(y),
            Scalar._cosh(x) * Scalar._sin(y)
        )
    }

    @inlinable
    public func tanh() -> Complex.Number<Scalar> {
        let z = complex
        guard z.isFinite else { return z }

        let x = z.real._value
        let y = z.imaginary._value

        let threshold = -Scalar._log(Scalar.ulpOfOne)
        guard abs(x) < threshold else {
            return Complex.Number(
                Scalar(signOf: x, magnitudeOf: 1),
                Scalar(signOf: y, magnitudeOf: 0)
            )
        }

        return z.math.sinh() / z.math.cosh()
    }
}