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

extension Complex.Real: Swift.Equatable where Scalar: Swift.Equatable {}

extension Complex.Real: Swift.Hashable where Scalar: Swift.Hashable {}

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
