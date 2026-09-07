extension Complex.Imaginary: Swift.ExpressibleByFloatLiteral where Scalar: Swift.ExpressibleByFloatLiteral {

    @inlinable
    public init(floatLiteral value: Scalar.FloatLiteralType) {
        self.init(Scalar(floatLiteral: value))
    }
}
