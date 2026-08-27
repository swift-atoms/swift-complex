public import Real
public import Tagged

extension Complex.Number {

    @inlinable
    public var polar: Polar { Polar(self) }
}

extension Complex.Number.Polar where Scalar: BinaryFloatingPoint & Numeric.Transcendental {

    @inlinable
    public static func length(of z: Complex.Number<Scalar>) -> Complex.Number<Scalar>.Modulus.Value
    {
        Complex.Number.Modulus.Value(_unchecked: Scalar._hypot(z.real._value, z.imaginary._value))
    }

    @inlinable
    public var length: Complex.Number<Scalar>.Modulus.Value {
        Self.length(of: complex)
    }

    @inlinable
    public static func squared(of z: Complex.Number<Scalar>) -> Scalar {
        z.real._value * z.real._value + z.imaginary._value * z.imaginary._value
    }

    @inlinable
    public var squared: Scalar {
        Self.squared(of: complex)
    }
}
