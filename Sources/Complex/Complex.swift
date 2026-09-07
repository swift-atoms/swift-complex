public enum Complex {}

extension Complex {

    public struct Number<Scalar>: Sendable where Scalar: Sendable {

        public var real: Real<Scalar>

        public var imaginary: Imaginary<Scalar>

        @inlinable
        public init(real: Real<Scalar>, imaginary: Imaginary<Scalar>) {
            self.real = real
            self.imaginary = imaginary
        }

        @inlinable
        public init(_ real: Scalar, _ imaginary: Scalar) {
            self.real = Real(real)
            self.imaginary = Imaginary(imaginary)
        }
    }
}

extension Complex.Number {

    @inlinable
    public var realValue: Scalar { real.value }

    @inlinable
    public var imaginaryValue: Scalar { imaginary.value }
}

extension Complex.Number where Scalar: BinaryFloatingPoint {

    @inlinable
    public static var zero: Self { Self(.zero, .zero) }

    @inlinable
    public static var one: Self { Self(1, .zero) }

    @inlinable
    public static var i: Self { Self(.zero, 1) }

    @inlinable
    public init(_ real: Scalar) {
        self.init(real, .zero)
    }
}
