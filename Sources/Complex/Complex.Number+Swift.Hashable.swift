extension Complex.Number: Swift.Hashable where Scalar: Swift.Hashable {

    @inlinable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(real)
        hasher.combine(imaginary)
    }
}
