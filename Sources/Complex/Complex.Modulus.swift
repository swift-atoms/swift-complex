public import Tagged

extension Complex.Number {

    public enum Modulus {}
}

extension Complex.Number.Modulus {

    public typealias Value = Tagged<Complex.Number<Scalar>.Modulus, Scalar>
}

extension Tagged where Tag == Complex.Number<Underlying>.Modulus, Underlying: AdditiveArithmetic {

    @inlinable
    public static func + (lhs: Self, rhs: Self) -> Self {
        Self(_unchecked: lhs.underlying + rhs.underlying)
    }

    @inlinable
    public static func - (lhs: Self, rhs: Self) -> Self {
        Self(_unchecked: lhs.underlying - rhs.underlying)
    }
}

extension Tagged where Tag == Complex.Number<Underlying>.Modulus, Underlying: Swift.Numeric {

    @inlinable
    public static func * (lhs: Self, rhs: Self) -> Self {
        Self(_unchecked: lhs.underlying * rhs.underlying)
    }
}

extension Tagged where Tag == Complex.Number<Underlying>.Modulus, Underlying: FloatingPoint {

    @inlinable
    public static func / (lhs: Self, rhs: Self) -> Self {
        Self(_unchecked: lhs.underlying / rhs.underlying)
    }
}