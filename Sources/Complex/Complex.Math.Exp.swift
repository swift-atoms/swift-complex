public import Numeric

extension Complex.Number.Math {

    public struct Exp {
        @usableFromInline
        let complex: Complex.Number<Scalar>

        @usableFromInline
        internal init(_ complex: Complex.Number<Scalar>) {
            self.complex = complex
        }
    }
}

extension Complex.Number.Math.Exp: Sendable where Scalar: Sendable {}

extension Complex.Number.Math {

    @inlinable
    public var exp: Exp {
        Exp(complex)
    }
}

extension Complex.Number.Math.Exp {

    public struct Minus {
        @usableFromInline
        let complex: Complex.Number<Scalar>

        @usableFromInline
        internal init(_ complex: Complex.Number<Scalar>) {
            self.complex = complex
        }
    }
}

extension Complex.Number.Math.Exp.Minus: Sendable where Scalar: Sendable {}

extension Complex.Number.Math.Exp {

    @inlinable
    public var minus: Minus {
        Minus(complex)
    }
}

extension Complex.Number.Math.Exp where Scalar: BinaryFloatingPoint & Numeric.Transcendental {

    @inlinable
    public func callAsFunction() -> Complex.Number<Scalar> {
        let z = complex
        guard z.isFinite else { return z }

        let x = z.real._value
        let y = z.imaginary._value

        guard x < Scalar._log(Scalar.greatestFiniteMagnitude) - 1 else {

            let half = Scalar._exp(x / 2)
            let phase = Complex.Number(Scalar._cos(y), Scalar._sin(y))
            return phase.scalar.multiply(by: Complex.Real(half)).scalar.multiply(
                by: Complex.Real(half)
            )
        }

        return Complex.Number(
            Scalar._cos(y),
            Scalar._sin(y)
        ).scalar.multiply(by: Complex.Real(Scalar._exp(x)))
    }
}

extension Complex.Number.Math.Exp.Minus where Scalar: BinaryFloatingPoint & Numeric.Transcendental {

    @inlinable
    public func one() -> Complex.Number<Scalar> {
        let z = complex
        guard z.isFinite else { return z }

        let x = z.real._value
        let y = z.imaginary._value

        guard x < Scalar._log(Scalar.greatestFiniteMagnitude) - 1 else {
            let half = Scalar._exp(x / 2)
            let phase = Complex.Number(Scalar._cos(y), Scalar._sin(y))
            return phase.scalar.multiply(by: Complex.Real(half)).scalar.multiply(
                by: Complex.Real(half)
            )
        }

        let sinHalfY = Scalar._sin(y / 2)
        let cosm1 = -2 * sinHalfY * sinHalfY

        let realPart = Scalar._expm1(x) * Scalar._cos(y) + cosm1

        let imagPart = Scalar._exp(x) * Scalar._sin(y)

        return Complex.Number(realPart, imagPart)
    }
}