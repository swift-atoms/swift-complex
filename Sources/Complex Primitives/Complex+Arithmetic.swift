extension Complex.Number where Scalar: BinaryFloatingPoint {

    @inlinable
    public static func + (lhs: Self, rhs: Self) -> Self {
        Self(real: lhs.real + rhs.real, imaginary: lhs.imaginary + rhs.imaginary)
    }

    @inlinable
    public static func += (lhs: inout Self, rhs: Self) {
        lhs = lhs + rhs
    }

    @inlinable
    public static func + (lhs: Self, rhs: Complex.Real<Scalar>) -> Self {
        Self(real: lhs.real + rhs, imaginary: lhs.imaginary)
    }

    @inlinable
    public static func + (lhs: Complex.Real<Scalar>, rhs: Self) -> Self {
        Self(real: lhs + rhs.real, imaginary: rhs.imaginary)
    }

    @inlinable
    public static func + (lhs: Self, rhs: Complex.Imaginary<Scalar>) -> Self {
        Self(real: lhs.real, imaginary: lhs.imaginary + rhs)
    }

    @inlinable
    public static func + (lhs: Complex.Imaginary<Scalar>, rhs: Self) -> Self {
        Self(real: rhs.real, imaginary: lhs + rhs.imaginary)
    }

    @inlinable
    public static func - (lhs: Self, rhs: Self) -> Self {
        Self(real: lhs.real - rhs.real, imaginary: lhs.imaginary - rhs.imaginary)
    }

    @inlinable
    public static func -= (lhs: inout Self, rhs: Self) {
        lhs = lhs - rhs
    }

    @inlinable
    public static func - (lhs: Self, rhs: Complex.Real<Scalar>) -> Self {
        Self(real: lhs.real - rhs, imaginary: lhs.imaginary)
    }

    @inlinable
    public static func - (lhs: Complex.Real<Scalar>, rhs: Self) -> Self {
        Self(real: lhs - rhs.real, imaginary: -rhs.imaginary)
    }

    @inlinable
    public static func - (lhs: Self, rhs: Complex.Imaginary<Scalar>) -> Self {
        Self(real: lhs.real, imaginary: lhs.imaginary - rhs)
    }

    @inlinable
    public static func - (lhs: Complex.Imaginary<Scalar>, rhs: Self) -> Self {
        Self(real: -rhs.real, imaginary: lhs - rhs.imaginary)
    }

    @inlinable
    public static prefix func - (z: Self) -> Self {
        Self(real: -z.real, imaginary: -z.imaginary)
    }

    @inlinable
    public static func * (lhs: Self, rhs: Self) -> Self {
        let a = lhs.real._value
        let b = lhs.imaginary._value
        let c = rhs.real._value
        let d = rhs.imaginary._value
        return Self(a * c - b * d, a * d + b * c)
    }

    @inlinable
    public static func *= (lhs: inout Self, rhs: Self) {
        lhs = lhs * rhs
    }

    @inlinable
    public static func * (lhs: Self, rhs: Complex.Real<Scalar>) -> Self {
        Self(real: lhs.real * rhs, imaginary: Complex.Imaginary(lhs.imaginary._value * rhs._value))
    }

    @inlinable
    public static func * (lhs: Complex.Real<Scalar>, rhs: Self) -> Self {
        rhs * lhs
    }

    @inlinable
    public static func * (lhs: Self, rhs: Complex.Imaginary<Scalar>) -> Self {
        let a = lhs.real._value
        let b = lhs.imaginary._value
        let d = rhs._value
        return Self(-b * d, a * d)
    }

    @inlinable
    public static func * (lhs: Complex.Imaginary<Scalar>, rhs: Self) -> Self {
        rhs * lhs
    }

    @inlinable
    public static func / (lhs: Self, rhs: Self) -> Self {
        let lengthSquared =
            rhs.real._value * rhs.real._value + rhs.imaginary._value * rhs.imaginary._value
        guard lengthSquared.isNormal else {
            return rescaledDivide(lhs, rhs)
        }

        let a = lhs.real._value
        let b = lhs.imaginary._value
        let c = rhs.real._value
        let d = rhs.imaginary._value
        return Self(
            (a * c + b * d) / lengthSquared,
            (b * c - a * d) / lengthSquared
        )
    }

    @usableFromInline
    @inline(never)
    internal static func rescaledDivide(_ z: Self, _ w: Self) -> Self {
        if w.isZero { return .infinity }
        if !z.isFinite || !w.isFinite {
            return .zero
        }

        let wMagnitude = max(w.real.abs._value, w.imaginary.abs._value)

        if wMagnitude < Scalar.leastNormalMagnitude {
            let s: Scalar = 1 / (Scalar(Scalar.radix) * Scalar.leastNormalMagnitude)
            let wPrime = Self(w.real._value * s, w.imaginary._value * s)
            let zPrime = Self(z.real._value * s, z.imaginary._value * s)
            return Self.rescaledDivide(zPrime, wPrime)
        }

        let s = Scalar(
            sign: .plus,
            exponent: -3 * wMagnitude.exponent / 4,
            significand: 1
        )
        let wPrime = Self(w.real._value * s, w.imaginary._value * s)
        let zPrime = Self(z.real._value * s, z.imaginary._value * s)
        let wPrimeLengthSq =
            wPrime.real._value * wPrime.real._value + wPrime.imaginary._value
            * wPrime.imaginary._value
        let a = zPrime.real._value
        let b = zPrime.imaginary._value
        let c = wPrime.real._value
        let d = wPrime.imaginary._value
        return Self(
            (a * c + b * d) / wPrimeLengthSq,
            (b * c - a * d) / wPrimeLengthSq
        )
    }

    @inlinable
    public static func /= (lhs: inout Self, rhs: Self) {
        lhs = lhs / rhs
    }

    @inlinable
    public static func / (lhs: Self, rhs: Complex.Real<Scalar>) -> Self {
        Self(real: lhs.real / rhs, imaginary: Complex.Imaginary(lhs.imaginary._value / rhs._value))
    }

    @inlinable
    public static func / (lhs: Complex.Real<Scalar>, rhs: Self) -> Self {
        Self(lhs._value, 0) / rhs
    }

    @inlinable
    public static func / (lhs: Self, rhs: Complex.Imaginary<Scalar>) -> Self {
        let a = lhs.real._value
        let b = lhs.imaginary._value
        let d = rhs._value
        return Self(b / d, -a / d)
    }

    @inlinable
    public static func / (lhs: Complex.Imaginary<Scalar>, rhs: Self) -> Self {
        Self(0, lhs._value) / rhs
    }

    @inlinable
    public static func conjugate(of z: Self) -> Self {
        Self(real: z.real, imaginary: -z.imaginary)
    }

    @inlinable
    public var conjugate: Self {
        Self.conjugate(of: self)
    }

    @inlinable
    public static func reciprocal(of z: Self) -> Self {
        let a = z.real._value
        let b = z.imaginary._value
        let denom = a * a + b * b
        return Self(a / denom, -b / denom)
    }

    @inlinable
    public var reciprocal: Self {
        Self.reciprocal(of: self)
    }
}
