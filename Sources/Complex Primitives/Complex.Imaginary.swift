extension Complex {

    public struct Imaginary<Scalar>: Sendable where Scalar: Sendable {
        @usableFromInline
        internal var _value: Scalar

        @inlinable
        public var value: Scalar {
            @inline(always) get { _value }
            @inline(always) set { _value = newValue }
        }

        @inlinable
        public init(_ value: Scalar) {
            self._value = value
        }
    }
}

extension Complex.Imaginary: Equatable where Scalar: Equatable {}
extension Complex.Imaginary: Hashable where Scalar: Hashable {}

extension Complex.Imaginary: ExpressibleByIntegerLiteral where Scalar: ExpressibleByIntegerLiteral {

    @inlinable
    public init(integerLiteral value: Scalar.IntegerLiteralType) {
        self.init(Scalar(integerLiteral: value))
    }
}

extension Complex.Imaginary: ExpressibleByFloatLiteral where Scalar: ExpressibleByFloatLiteral {

    @inlinable
    public init(floatLiteral value: Scalar.FloatLiteralType) {
        self.init(Scalar(floatLiteral: value))
    }
}

extension Complex.Imaginary where Scalar: BinaryFloatingPoint {

    @inlinable
    public static var i: Self { Self(1) }

    @inlinable
    public static var zero: Self { Self(0) }
}

extension Complex.Imaginary where Scalar: BinaryFloatingPoint {

    @inlinable
    public var isFinite: Bool { _value.isFinite }

    @inlinable
    public var isZero: Bool { _value == 0 }

    @inlinable
    public var isNormal: Bool { _value.isNormal }

    @inlinable
    public var isSubnormal: Bool { _value.isSubnormal }

    @inlinable
    public var isNaN: Bool { _value.isNaN }

    @inlinable
    public var isInfinite: Bool { _value.isInfinite }

    @inlinable
    public var sign: FloatingPointSign { _value.sign }

    @inlinable
    public var abs: Complex.Real<Scalar> { Complex.Real(Swift.abs(_value)) }
}

extension Complex.Imaginary: CustomStringConvertible where Scalar: CustomStringConvertible {

    @inlinable
    public var description: String { "\(_value.description)i" }
}

extension Complex.Imaginary: CustomDebugStringConvertible
where Scalar: CustomDebugStringConvertible {

    @inlinable
    public var debugDescription: String { "Imaginary(\(String(reflecting: _value)))" }
}
