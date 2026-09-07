extension Complex.Imaginary: Swift.CustomStringConvertible where Scalar: Swift.CustomStringConvertible {

    @inlinable
    public var description: String { "\(_value.description)i" }
}
