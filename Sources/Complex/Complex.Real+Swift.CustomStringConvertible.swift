extension Complex.Real: Swift.CustomStringConvertible where Scalar: Swift.CustomStringConvertible {

    @inlinable
    public var description: String { _value.description }
}
