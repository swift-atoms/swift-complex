extension Complex.Number: Swift.ExpressibleByIntegerLiteral
where Scalar: Swift.ExpressibleByIntegerLiteral & BinaryFloatingPoint {

    @inlinable
    public init(integerLiteral value: Scalar.IntegerLiteralType) {
        self.init(Scalar(integerLiteral: value), .zero)
    }
}
