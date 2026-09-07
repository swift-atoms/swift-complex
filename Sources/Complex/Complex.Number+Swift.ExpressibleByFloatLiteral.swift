extension Complex.Number: Swift.ExpressibleByFloatLiteral
where Scalar: Swift.ExpressibleByFloatLiteral & BinaryFloatingPoint {

    @inlinable
    public init(floatLiteral value: Scalar.FloatLiteralType) {
        self.init(Scalar(floatLiteral: value), .zero)
    }
}
