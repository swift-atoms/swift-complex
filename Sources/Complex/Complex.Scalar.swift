extension Complex.Number {

    public struct Operation {
        @usableFromInline
        let complex: Complex.Number<Scalar>

        @usableFromInline
        internal init(_ complex: Complex.Number<Scalar>) {
            self.complex = complex
        }
    }
}

extension Complex.Number.Operation: Swift.Sendable where Scalar: Swift.Sendable {}

extension Complex.Number {

    @inlinable
    public var scalar: Operation {
        Operation(self)
    }
}

extension Complex.Number.Operation where Scalar: BinaryFloatingPoint {

    @inlinable
    public func multiply(by value: Complex.Real<Scalar>) -> Complex.Number<Scalar> {
        Complex.Number(
            real: complex.real * value,
            imaginary: Complex.Imaginary(complex.imaginary._value * value._value)
        )
    }

    @inlinable
    public func divide(by value: Complex.Real<Scalar>) -> Complex.Number<Scalar> {
        Complex.Number(
            real: complex.real / value,
            imaginary: Complex.Imaginary(complex.imaginary._value / value._value)
        )
    }
}
