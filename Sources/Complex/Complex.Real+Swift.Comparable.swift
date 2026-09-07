extension Complex.Real: Swift.Comparable where Scalar: Swift.Comparable {

    @inlinable
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.value < rhs.value
    }
}
