public import Numeric

extension Complex.Number.Math where Scalar: BinaryFloatingPoint & Numeric.Transcendental {

    @inlinable
    public func acos() -> Complex.Number<Scalar> {
        let z = complex
        let one = Complex.Number<Scalar>.one

        let sqrt1mz = (one - z).math.sqrt()
        let sqrt1pz = (one + z).math.sqrt()

        let realPart = 2 * Scalar._atan2(sqrt1mz.real._value, sqrt1pz.real._value)
        let imagPart = Scalar._asinh((sqrt1pz.conjugate * sqrt1mz).imaginary._value)

        return Complex.Number(realPart, imagPart)
    }

    @inlinable
    public func asin() -> Complex.Number<Scalar> {
        let z = complex
        let one = Complex.Number<Scalar>.one

        let sqrt1mz = (one - z).math.sqrt()
        let sqrt1pz = (one + z).math.sqrt()

        let realPart = Scalar._atan2(z.real._value, (sqrt1mz * sqrt1pz).real._value)
        let imagPart = Scalar._asinh((sqrt1mz.conjugate * sqrt1pz).imaginary._value)

        return Complex.Number(realPart, imagPart)
    }

    @inlinable
    public func atan() -> Complex.Number<Scalar> {

        let iz = Complex.Number(-complex.imaginary._value, complex.real._value)
        let w = iz.math.atanh()

        return Complex.Number(w.imaginary._value, -w.real._value)
    }

    @inlinable
    public func acosh() -> Complex.Number<Scalar> {
        let z = complex
        let one = Complex.Number<Scalar>.one

        let sqrtZm1 = (z - one).math.sqrt()
        let sqrtZp1 = (z + one).math.sqrt()

        let realPart = Scalar._asinh((sqrtZm1.conjugate * sqrtZp1).real._value)
        let imagPart = 2 * Scalar._atan2(sqrtZm1.imaginary._value, sqrtZp1.real._value)

        return Complex.Number(realPart, imagPart)
    }

    @inlinable
    public func asinh() -> Complex.Number<Scalar> {

        let iz = Complex.Number(-complex.imaginary._value, complex.real._value)
        let w = iz.math.asin()

        return Complex.Number(w.imaginary._value, -w.real._value)
    }

    @inlinable
    public func atanh() -> Complex.Number<Scalar> {
        let z = complex
        let logOnePlusZ = z.math.log.one.plus()
        let logOneMinusZ = (-z).math.log.one.plus()
        return (logOnePlusZ - logOneMinusZ).scalar.divide(by: Complex.Real(Scalar(2)))
    }
}