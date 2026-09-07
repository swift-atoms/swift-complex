extension Complex.Real: Swift.CustomDebugStringConvertible where Scalar: Swift.CustomDebugStringConvertible {

    @inlinable
    public var debugDescription: String { "Real(\(String(reflecting: _value)))" }
}
