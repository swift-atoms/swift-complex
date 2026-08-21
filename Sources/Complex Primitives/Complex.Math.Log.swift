extension Complex.Number.Math {

    public struct Log {
        @usableFromInline
        let complex: Complex.Number<Scalar>

        @usableFromInline
        internal init(_ complex: Complex.Number<Scalar>) {
            self.complex = complex
        }
    }
}

extension Complex.Number.Math.Log: Sendable where Scalar: Sendable {}

extension Complex.Number.Math {

    @inlinable
    public var log: Log {
        Log(complex)
    }
}

extension Complex.Number.Math.Log {

    public struct One {
        @usableFromInline
        let complex: Complex.Number<Scalar>

        @usableFromInline
        internal init(_ complex: Complex.Number<Scalar>) {
            self.complex = complex
        }
    }
}

extension Complex.Number.Math.Log.One: Sendable where Scalar: Sendable {}

extension Complex.Number.Math.Log {

    @inlinable
    public var one: One {
        One(complex)
    }
}

extension Complex.Number.Math.Log where Scalar: BinaryFloatingPoint & Numeric.Transcendental {

    @inlinable
    public func callAsFunction() -> Complex.Number<Scalar> {
        let z = complex

        guard z.isFinite && !z.isZero else { return .infinity }

        let x = z.real._value
        let y = z.imaginary._value

        let phase = Scalar._atan2(y, x)

        let u = max(abs(x), abs(y))
        let v = min(abs(x), abs(y))

        let r = v / u
        if u >= 1 || u >= u * u + v * v {
            return Complex.Number(
                Scalar._log(u) + Scalar._log1p(r * r) / 2,
                phase
            )
        }

        let (a, b) = Numeric.Augmented.product(u, u)
        let (c, d) = Numeric.Augmented.product(v, v)
        var (s, e) = Numeric.Augmented.sum(large: Scalar(-1), small: a)
        s = (s + c) + e + b + d

        return Complex.Number(
            Scalar._log1p(s) / 2,
            phase
        )
    }
}

extension Complex.Number.Math.Log.One where Scalar: BinaryFloatingPoint & Numeric.Transcendental {

    @inlinable
    public func plus() -> Complex.Number<Scalar> {
        let z = complex

        let x = z.real._value
        let y = z.imaginary._value

        guard 2 * abs(x) < 1 && abs(y) < 1 else {
            let one = Complex.Number<Scalar>.one
            return (one + z).math.log()
        }

        let onePlusX = 1 + x
        let phase = Scalar._atan2(y, onePlusX)

        let xp2 = Numeric.Augmented.sum(large: Scalar(2), small: x)
        let a = Numeric.Augmented.product(x, xp2.head)
        let y2 = Numeric.Augmented.product(y, y)
        let s = (a.head + y2.head + a.tail + y2.tail) + x * xp2.tail

        return Complex.Number(
            Scalar._log1p(s) / 2,
            phase
        )
    }
}
