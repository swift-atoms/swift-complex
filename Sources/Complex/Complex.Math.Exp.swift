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

extension Complex.Number.Math.Exp: Swift.Sendable where Scalar: Swift.Sendable {}

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

extension Complex.Number.Math.Exp.Minus: Swift.Sendable where Scalar: Swift.Sendable {}

extension Complex.Number.Math.Exp {

    @inlinable
    public var minus: Minus {
        Minus(complex)
    }
}

extension Complex.Number.Math.Exp
where Scalar: BinaryFloatingPoint & Trigonometry.Circular & Exponential.`Protocol` {
    @inlinable
    public func callAsFunction() -> Complex.Number<Scalar> {
        let x = complex.real._value, y = complex.imaginary._value
        if y == 0 { return Complex.Number(Scalar.exp(x), y) }
        if !y.isFinite {
            if x == -.infinity { return .zero }
            if x == .infinity { return Complex.Number(.infinity, .nan) }
            return Complex.Number(.nan, .nan)
        }
        if x.isNaN { return Complex.Number(.nan, .nan) }
        return Complex.Number(
            Complex.Number<Scalar>._exponentialComponent(Scalar.cos(y), exponent: x),
            Complex.Number<Scalar>._exponentialComponent(Scalar.sin(y), exponent: x))
    }
}

extension Complex.Number.Math.Exp.Minus
where Scalar: BinaryFloatingPoint & Trigonometry.Circular & Exponential.`Protocol` {
    @inlinable
    public func one() -> Complex.Number<Scalar> {
        let x = complex.real._value, y = complex.imaginary._value
        if y == 0 { return Complex.Number(Scalar.expm1(x), y) }
        if !complex.isFinite || x >= Scalar.log(Scalar.greatestFiniteMagnitude) - 1 {
            let value = complex.math.exp()
            return Complex.Number(value.real._value - 1, value.imaginary._value)
        }
        let sinHalfY = Scalar.sin(y / 2)
        let cosm1 = -2 * sinHalfY * sinHalfY
        let real = Scalar.expm1(x) * Scalar.cos(y) + cosm1
        let imaginary = Scalar.exp(x) * Scalar.sin(y)
        return Complex.Number(real, imaginary)
    }
}
