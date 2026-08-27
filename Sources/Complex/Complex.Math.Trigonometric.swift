public import Real

extension Complex.Number.Math {

    public struct Cos {
        @usableFromInline
        let complex: Complex.Number<Scalar>

        @usableFromInline
        internal init(_ complex: Complex.Number<Scalar>) {
            self.complex = complex
        }
    }
}

extension Complex.Number.Math.Cos: Sendable where Scalar: Sendable {}

extension Complex.Number.Math {

    @inlinable
    public var cos: Cos {
        Cos(complex)
    }
}

extension Complex.Number.Math.Cos {

    public struct Minus {
        @usableFromInline
        let complex: Complex.Number<Scalar>

        @usableFromInline
        internal init(_ complex: Complex.Number<Scalar>) {
            self.complex = complex
        }
    }
}

extension Complex.Number.Math.Cos.Minus: Sendable where Scalar: Sendable {}

extension Complex.Number.Math.Cos {

    @inlinable
    public var minus: Minus {
        Minus(complex)
    }
}

extension Complex.Number.Math.Cos where Scalar: BinaryFloatingPoint & Numeric.Transcendental {

    @inlinable
    public func callAsFunction() -> Complex.Number<Scalar> {

        let iz = Complex.Number(-complex.imaginary._value, complex.real._value)
        return iz.math.cosh()
    }
}

extension Complex.Number.Math.Cos.Minus where Scalar: BinaryFloatingPoint & Numeric.Transcendental {

    @inlinable
    public func one() -> Complex.Number<Scalar> {
        let halfZ = complex.scalar.divide(by: Complex.Real(Scalar(2)))
        let sinHalf = halfZ.math.sin()
        return (sinHalf * sinHalf).scalar.multiply(by: Complex.Real(Scalar(-2)))
    }
}

extension Complex.Number.Math where Scalar: BinaryFloatingPoint & Numeric.Transcendental {

    @inlinable
    public func sin() -> Complex.Number<Scalar> {

        let iz = Complex.Number(-complex.imaginary._value, complex.real._value)
        let w = iz.math.sinh()

        return Complex.Number(w.imaginary._value, -w.real._value)
    }

    @inlinable
    public func tan() -> Complex.Number<Scalar> {

        let iz = Complex.Number(-complex.imaginary._value, complex.real._value)
        let w = iz.math.tanh()

        return Complex.Number(w.imaginary._value, -w.real._value)
    }
}