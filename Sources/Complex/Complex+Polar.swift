public import Angle
public import Tagged

extension Complex.Number {

    @inlinable
    public var polar: Polar { Polar(self) }
}

extension Complex.Number.Polar where Scalar: BinaryFloatingPoint {

    @inlinable
    public static func length(of z: Complex.Number<Scalar>) -> Complex.Number<Scalar>.Modulus.Value
    {
        Complex.Number.Modulus.Value(_unchecked: Complex.Number<Scalar>._hypot(z.real._value, z.imaginary._value))
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

extension Complex.Number where Scalar: BinaryFloatingPoint & Trigonometry.Circular {

    @inlinable
    public init(length: Complex.Number<Scalar>.Modulus.Value, phase: Radian<Scalar>) {
        let r = length.underlying
        let theta = phase.underlying
        self.init(
            r * Scalar.cos(theta),
            r * Scalar.sin(theta)
        )
    }
}

extension Complex.Number.Polar where Scalar: BinaryFloatingPoint & Trigonometry.Circular {
    @inlinable
    public static func phase(of z: Complex.Number<Scalar>) -> Radian<Scalar> {
        Radian(_unchecked: Scalar.atan2(z.imaginary._value, z.real._value))
    }

    @inlinable
    public var phase: Radian<Scalar> {
        Self.phase(of: complex)
    }

}
