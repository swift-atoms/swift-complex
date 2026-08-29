public import Dimension
public import Dimension_Tagged
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
    public static func phase(of z: Complex.Number<Scalar>) -> Radian<Scalar> {
        Radian(_unchecked: Scalar._atan2(z.imaginary._value, z.real._value))
    }

    @inlinable
    public var phase: Radian<Scalar> {
        Self.phase(of: complex)
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

extension Complex.Number where Scalar: BinaryFloatingPoint & Numeric.Transcendental {

    @inlinable
    public init(length: Complex.Number<Scalar>.Modulus.Value, phase: Radian<Scalar>) {
        let r = length.underlying
        let theta = phase.underlying
        self.init(
            r * Scalar._cos(theta),
            r * Scalar._sin(theta)
        )
    }
}
