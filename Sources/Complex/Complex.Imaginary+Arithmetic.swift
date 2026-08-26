extension Complex.Imaginary where Scalar: BinaryFloatingPoint {

    @inlinable
    public static func + (lhs: Self, rhs: Self) -> Self {
        Self(lhs._value + rhs._value)
    }

    @inlinable
    public static func - (lhs: Self, rhs: Self) -> Self {
        Self(lhs._value - rhs._value)
    }

    @inlinable
    public static prefix func - (x: Self) -> Self {
        Self(-x._value)
    }

    @inlinable
    public static func += (lhs: inout Self, rhs: Self) {
        lhs._value += rhs._value
    }

    @inlinable
    public static func -= (lhs: inout Self, rhs: Self) {
        lhs._value -= rhs._value
    }

    @inlinable
    public static func * (lhs: Self, rhs: Self) -> Complex.Real<Scalar> {
        Complex.Real(-lhs._value * rhs._value)
    }

    @inlinable
    public static func / (lhs: Self, rhs: Self) -> Complex.Real<Scalar> {
        Complex.Real(lhs._value / rhs._value)
    }
}
