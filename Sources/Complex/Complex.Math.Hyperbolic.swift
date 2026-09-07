extension Complex.Number.Math
where Scalar: BinaryFloatingPoint & Trigonometry.`Protocol` & Exponential.`Protocol` {
    @inlinable
    public func cosh() -> Complex.Number<Scalar> {
        let x = complex.real._value, y = complex.imaginary._value
        let sign = Scalar(signOf: x, magnitudeOf: 1)
        if y == 0 { return Complex.Number(Scalar.cosh(x), x.isNaN ? y : sign * y) }
        if !y.isFinite {
            if x.isInfinite { return Complex.Number(.infinity, .nan) }
            if x == 0 { return Complex.Number(.nan, x) }
            return Complex.Number(.nan, .nan)
        }
        if x.isNaN { return Complex.Number(.nan, .nan) }
        if x.magnitude >= -Scalar.log(Scalar.ulpOfOne) {
            return Complex.Number(
                Complex.Number<Scalar>._exponentialComponent(Scalar.cos(y), exponent: x.magnitude, halved: true),
                Complex.Number<Scalar>._exponentialComponent(sign * Scalar.sin(y), exponent: x.magnitude, halved: true))
        }
        return Complex.Number(Scalar.cosh(x) * Scalar.cos(y), Scalar.sinh(x) * Scalar.sin(y))
    }

    @inlinable
    public func sinh() -> Complex.Number<Scalar> {
        let x = complex.real._value, y = complex.imaginary._value
        if y == 0 { return Complex.Number(Scalar.sinh(x), y) }
        if !y.isFinite {
            if x.isInfinite || x == 0 { return Complex.Number(x, .nan) }
            return Complex.Number(.nan, .nan)
        }
        if x.isNaN { return Complex.Number(.nan, .nan) }
        if x.magnitude >= -Scalar.log(Scalar.ulpOfOne) {
            let sign = Scalar(signOf: x, magnitudeOf: 1)
            return Complex.Number(
                Complex.Number<Scalar>._exponentialComponent(sign * Scalar.cos(y), exponent: x.magnitude, halved: true),
                Complex.Number<Scalar>._exponentialComponent(Scalar.sin(y), exponent: x.magnitude, halved: true))
        }
        return Complex.Number(Scalar.sinh(x) * Scalar.cos(y), Scalar.cosh(x) * Scalar.sin(y))
    }

    @inlinable
    public func tanh() -> Complex.Number<Scalar> {
        let x = complex.real._value, y = complex.imaginary._value
        if y == 0 { return Complex.Number(Scalar.tanh(x), y) }
        if x.isInfinite {
            let phase = y.isFinite ? Scalar.sin(y) * Scalar.cos(y) : 0
            return Complex.Number(Scalar(signOf: x, magnitudeOf: 1), Scalar(signOf: phase, magnitudeOf: 0))
        }
        guard complex.isFinite else { return Complex.Number(.nan, .nan) }
        if x.magnitude >= -Scalar.log(Scalar.ulpOfOne) {
            let decay = Scalar.exp(-2 * x.magnitude)
            let sine = Scalar.sin(y), cosine = Scalar.cos(y)
            let denominator = 1 + 2 * (cosine * cosine - sine * sine) * decay + decay * decay
            let real = Scalar(signOf: x, magnitudeOf: (1 - decay * decay) / denominator)
            return Complex.Number(real, 4 * sine * cosine * decay / denominator)
        }
        return complex.math.sinh() / complex.math.cosh()
    }
}
