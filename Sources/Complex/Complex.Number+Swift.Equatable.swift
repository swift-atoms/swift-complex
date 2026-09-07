extension Complex.Number: Swift.Equatable where Scalar: Swift.Equatable {

    @inlinable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.real == rhs.real && lhs.imaginary == rhs.imaginary
    }
}
