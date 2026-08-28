extension Complex.Number.Math {

    public struct Pow {
        @usableFromInline
        let complex: Complex.Number<Scalar>

        @usableFromInline
        internal init(_ complex: Complex.Number<Scalar>) {
            self.complex = complex
        }
    }
}

extension Complex.Number.Math.Pow: Sendable where Scalar: Sendable {}

extension Complex.Number.Math {

    @inlinable
    public var pow: Pow {
        Pow(complex)
    }
}

extension Complex.Number.Math where Scalar: BinaryFloatingPoint & Numeric.Transcendental {

    @inlinable
    public func sqrt() -> Complex.Number<Scalar> {
        let z = complex
        let lenSquared = z.magnitude.squared

        if lenSquared.isNormal {

            let norm = Scalar._sqrt(lenSquared._value)
            let u = Scalar._sqrt((norm + z.real.abs._value) / 2)
            let v = z.imaginary._value / (2 * u)

            guard z.real.sign == .plus else {
                return Complex.Number(abs(v), Scalar(signOf: z.imaginary._value, magnitudeOf: u))
            }
            return Complex.Number(u, v)
        }

        if z.isZero { return Complex.Number(0, z.imaginary._value) }
        if !z.isFinite { return z }

        let scale = max(abs(z.real._value), abs(z.imaginary._value))
        let scaled = z.scalar.divide(by: Complex.Real(scale))
        return scaled.math.sqrt().scalar.multiply(by: Complex.Real(Scalar._sqrt(scale)))
    }

    @inlinable
    public func root(_ n: Int) -> Complex.Number<Scalar> {
        let z = complex
        if z.isZero { return .zero }
        return z.math.log().scalar.divide(by: Complex.Real(Scalar(n))).math.exp()
    }
}

extension Complex.Number.Math.Pow where Scalar: BinaryFloatingPoint & Numeric.Transcendental {

    @inlinable
    public func callAsFunction(_ w: Complex.Number<Scalar>) -> Complex.Number<Scalar> {
        let z = complex
        if z.isZero {
            return w.real._value > 0 ? .zero : .infinity
        }
        return (w * z.math.log()).math.exp()
    }

    @inlinable
    public func callAsFunction(_ n: Int) -> Complex.Number<Scalar> {
        let z = complex
        if z.isZero {
            if n < 0 { return .infinity }
            if n == 0 { return .one }
            return .zero
        }

        return z.math.log().scalar.multiply(by: Complex.Real(Scalar(n))).math.exp()
    }
}
