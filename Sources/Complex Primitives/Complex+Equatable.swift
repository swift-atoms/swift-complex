extension Complex.Number: Equatable where Scalar: Equatable {

    @inlinable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.real == rhs.real && lhs.imaginary == rhs.imaginary
    }
}
