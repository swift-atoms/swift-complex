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

extension Complex.Number.Math.Log: Swift.Sendable where Scalar: Swift.Sendable {}

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

extension Complex.Number.Math.Log.One: Swift.Sendable where Scalar: Swift.Sendable {}

extension Complex.Number.Math.Log {

    @inlinable
    public var one: One {
        One(complex)
    }
}

extension Complex.Number.Math.Log where Scalar: BinaryFloatingPoint & Trigonometry.Circular & Exponential.`Protocol` {

    @inlinable
    public func callAsFunction() -> Complex.Number<Scalar> {
        let z = complex

        let x = z.real._value
        let y = z.imaginary._value

        let phase = Scalar.atan2(y, x)
        if x.isInfinite || y.isInfinite { return Complex.Number(.infinity, phase) }
        if x.isNaN || y.isNaN { return Complex.Number(.nan, .nan) }
        if z.isZero { return Complex.Number(-.infinity, phase) }

        let u = max(abs(x), abs(y))
        let v = min(abs(x), abs(y))

        let r = v / u
        if u >= 1 || u >= u * u + v * v {
            return Complex.Number(
                Scalar.log(u) + Scalar.log1p(r * r) / 2,
                phase
            )
        }

        let (a, b) = Multiplication.augmented(u, u)
        let (c, d) = Multiplication.augmented(v, v)
        var (s, e) = Addition.augmented(large: Scalar(-1), small: a)
        s = (s + c) + e + b + d

        return Complex.Number(
            Scalar.log1p(s) / 2,
            phase
        )
    }
}

extension Complex.Number.Math.Log.One where Scalar: BinaryFloatingPoint & Trigonometry.Circular & Exponential.`Protocol` {

    @inlinable
    public func plus() -> Complex.Number<Scalar> {
        let z = complex

        let x = z.real._value
        let y = z.imaginary._value

        guard 2 * abs(x) < 1 && abs(y) < 1 else {
            return Complex.Number(1 + x, y).math.log()
        }

        let onePlusX = 1 + x
        let phase = Scalar.atan2(y, onePlusX)

        let xp2 = Addition.augmented(large: Scalar(2), small: x)
        let a = Multiplication.augmented(x, xp2.head)
        let y2 = Multiplication.augmented(y, y)
        let s = (a.head + y2.head + a.tail + y2.tail) + x * xp2.tail

        return Complex.Number(
            Scalar.log1p(s) / 2,
            phase
        )
    }
}
