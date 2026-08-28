extension Numeric.Relaxed {

    @inlinable
    public static func sum(
        _ a: Complex.Number<Double>,
        _ b: Complex.Number<Double>
    ) -> Complex.Number<Double> {
        Complex.Number(
            Self.sum(a.real._value, b.real._value),
            Self.sum(a.imaginary._value, b.imaginary._value)
        )
    }

    @inlinable
    public static func product(
        _ a: Complex.Number<Double>,
        _ b: Complex.Number<Double>
    ) -> Complex.Number<Double> {

        Complex.Number(
            Self.sum(
                Self.product(a.real._value, b.real._value),
                -Self.product(a.imaginary._value, b.imaginary._value)
            ),
            Self.sum(
                Self.product(a.real._value, b.imaginary._value),
                Self.product(a.imaginary._value, b.real._value)
            )
        )
    }

    @inlinable
    public static func multiplyAdd(
        _ a: Complex.Number<Double>,
        _ b: Complex.Number<Double>,
        _ c: Complex.Number<Double>
    ) -> Complex.Number<Double> {
        sum(product(a, b), c)
    }

    @inlinable
    public static func product(
        _ z: Complex.Number<Double>,
        _ s: Double
    ) -> Complex.Number<Double> {
        Complex.Number(
            Self.product(z.real._value, s),
            Self.product(z.imaginary._value, s)
        )
    }

    @inlinable
    public static func product(
        _ s: Double,
        _ z: Complex.Number<Double>
    ) -> Complex.Number<Double> {
        product(z, s)
    }
}

extension Numeric.Relaxed {

    @inlinable
    public static func sum(
        _ a: Complex.Number<Float>,
        _ b: Complex.Number<Float>
    ) -> Complex.Number<Float> {
        Complex.Number(
            Self.sum(a.real._value, b.real._value),
            Self.sum(a.imaginary._value, b.imaginary._value)
        )
    }

    @inlinable
    public static func product(
        _ a: Complex.Number<Float>,
        _ b: Complex.Number<Float>
    ) -> Complex.Number<Float> {
        Complex.Number(
            Self.sum(
                Self.product(a.real._value, b.real._value),
                -Self.product(a.imaginary._value, b.imaginary._value)
            ),
            Self.sum(
                Self.product(a.real._value, b.imaginary._value),
                Self.product(a.imaginary._value, b.real._value)
            )
        )
    }

    @inlinable
    public static func multiplyAdd(
        _ a: Complex.Number<Float>,
        _ b: Complex.Number<Float>,
        _ c: Complex.Number<Float>
    ) -> Complex.Number<Float> {
        sum(product(a, b), c)
    }

    @inlinable
    public static func product(
        _ z: Complex.Number<Float>,
        _ s: Float
    ) -> Complex.Number<Float> {
        Complex.Number(
            Self.product(z.real._value, s),
            Self.product(z.imaginary._value, s)
        )
    }

    @inlinable
    public static func product(
        _ s: Float,
        _ z: Complex.Number<Float>
    ) -> Complex.Number<Float> {
        product(z, s)
    }
}
