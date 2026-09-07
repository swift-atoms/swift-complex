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

extension Complex.Number.Math.Pow: Swift.Sendable where Scalar: Swift.Sendable {}

extension Complex.Number.Math {

    @inlinable
    public var pow: Pow {
        Pow(complex)
    }
}

extension Complex.Number.Math where Scalar: BinaryFloatingPoint {

    @inlinable
    public func sqrt() -> Complex.Number<Scalar> {
        let x = complex.real._value
        let y = complex.imaginary._value
        if y.isInfinite { return Complex.Number(.infinity, y) }
        if x.isInfinite {
            if x.sign == .plus {
                return Complex.Number(.infinity, y.isNaN ? .nan : Scalar(signOf: y, magnitudeOf: 0))
            }
            return Complex.Number(y.isNaN ? .nan : 0, Scalar(signOf: y, magnitudeOf: .infinity))
        }
        if x.isNaN || y.isNaN { return Complex.Number(.nan, .nan) }
        if complex.isZero { return Complex.Number(0, y) }

        let scale = max(x.magnitude, y.magnitude)
        let exponent = scale.exponent
        let evenExponent = exponent - (exponent & 1)
        let a = Scalar(sign: .plus, exponent: -evenExponent, significand: x.magnitude)
        let b = Scalar(sign: .plus, exponent: -evenExponent, significand: y.magnitude)
        let norm = Complex.Number<Scalar>._hypot(a, b)
        let root = ((norm + a) / 2).squareRoot()
        let large = Scalar(sign: .plus, exponent: evenExponent / 2, significand: root)
        let small = y.magnitude / (2 * large)
        return x.sign == .minus
            ? Complex.Number(small, Scalar(signOf: y, magnitudeOf: large))
            : Complex.Number(large, Scalar(signOf: y, magnitudeOf: small))
    }
}

extension Complex.Number.Math
where Scalar: BinaryFloatingPoint & Trigonometry.Circular & Exponential.`Protocol` {

    @inlinable
    public func root(_ n: Int) -> Complex.Number<Scalar> {
        if n == 0 { return Complex.Number(.nan, .nan) }
        if n == 1 { return complex }
        if n == 2 { return sqrt() }
        if n == -1 { return Complex.Number<Scalar>.one / complex }
        if complex.isZero { return n < 0 ? .infinity : .zero }
        return complex.math.log().scalar.divide(by: Complex.Real(Scalar(n))).math.exp()
    }
}

extension Complex.Number.Math.Pow
where Scalar: BinaryFloatingPoint & Trigonometry.Circular & Exponential.`Protocol` {
    @inlinable
    public func callAsFunction(_ w: Complex.Number<Scalar>) -> Complex.Number<Scalar> {
        let z = complex
        if z.isZero { return w.real._value > 0 ? .zero : .infinity }
        return (w * z.math.log()).math.exp()
    }
}

extension Complex.Number.Math.Pow where Scalar: BinaryFloatingPoint {

    @inlinable
    public func callAsFunction(_ n: Int) -> Complex.Number<Scalar> {
        if n == 0 { return .one }
        if complex.isZero { return n < 0 ? .infinity : .zero }
        var exponent = n.magnitude
        var factor = n < 0 ? Complex.Number<Scalar>.one / complex : complex
        var result = Complex.Number<Scalar>.one
        while exponent != 0 {
            if exponent & 1 != 0 { result *= factor }
            exponent >>= 1
            if exponent != 0 { factor *= factor }
        }
        return result
    }
}
