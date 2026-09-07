extension Complex.Imaginary: Swift.ExpressibleByIntegerLiteral where Scalar: Swift.ExpressibleByIntegerLiteral {

    @inlinable
    public init(integerLiteral value: Scalar.IntegerLiteralType) {
        self.init(Scalar(integerLiteral: value))
    }
}
