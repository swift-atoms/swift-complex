extension Complex {

    public struct Real<Scalar>: Sendable where Scalar: Sendable {
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

extension Complex.Real: Equatable where Scalar: Equatable {}
extension Complex.Real: Hashable where Scalar: Hashable {}

extension Complex.Real: Comparable where Scalar: Comparable {

    @inlinable
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.value < rhs.value
    }
}

extension Complex.Real: ExpressibleByIntegerLiteral where Scalar: ExpressibleByIntegerLiteral {

    @inlinable
    public init(integerLiteral value: Scalar.IntegerLiteralType) {
        self.init(Scalar(integerLiteral: value))
    }
}

extension Complex.Real: ExpressibleByFloatLiteral where Scalar: ExpressibleByFloatLiteral {

    @inlinable
    public init(floatLiteral value: Scalar.FloatLiteralType) {
        self.init(Scalar(floatLiteral: value))
    }
}

extension Complex.Real where Scalar: BinaryFloatingPoint {

    @inlinable
    public static var zero: Self { Self(0) }

    @inlinable
    public static var one: Self { Self(1) }
}

extension Complex.Real where Scalar: BinaryFloatingPoint {

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
    public var abs: Self { Self(Swift.abs(_value)) }
}

extension Complex.Real: CustomStringConvertible where Scalar: CustomStringConvertible {

    @inlinable
    public var description: String { _value.description }
}

extension Complex.Real: CustomDebugStringConvertible where Scalar: CustomDebugStringConvertible {

    @inlinable
    public var debugDescription: String { "Real(\(String(reflecting: _value)))" }
}

extension Double {

    @inlinable
    public var real: Complex.Real<Double> { .init(self) }

    @inlinable
    public var i: Complex.Imaginary<Double> { .init(self) }
}

extension Float {

    @inlinable
    public var real: Complex.Real<Float> { .init(self) }

    @inlinable
    public var i: Complex.Imaginary<Float> { .init(self) }
}
