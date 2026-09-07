extension Complex.Imaginary: Swift.CustomDebugStringConvertible
where Scalar: Swift.CustomDebugStringConvertible {

    @inlinable
    public var debugDescription: String { "Imaginary(\(String(reflecting: _value)))" }
}
