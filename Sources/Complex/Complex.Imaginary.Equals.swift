public import Tolerance

extension Complex.Imaginary {

    public struct Equals {
        @usableFromInline
        let imaginary: Complex.Imaginary<Scalar>

        @usableFromInline
        internal init(_ imaginary: Complex.Imaginary<Scalar>) {
            self.imaginary = imaginary
        }
    }
}

extension Complex.Imaginary.Equals: Swift.Sendable where Scalar: Swift.Sendable {}

extension Complex.Imaginary {

    @inlinable
    public var equals: Equals {
        Equals(self)
    }
}

extension Complex.Imaginary.Equals where Scalar: BinaryFloatingPoint {

    @inlinable
    public func approximate(
        _ other: Complex.Imaginary<Scalar>,
        tolerance: Complex.Real<Scalar>
    ) -> Bool {
        (try? Tolerance<Scalar>(absolute: tolerance._value))?.contains(imaginary._value, other._value) ?? false
    }

    @inlinable
    public func approximate(
        _ other: Complex.Imaginary<Scalar>,
        absolute: Complex.Real<Scalar>,
        relative: Complex.Real<Scalar> = .zero
    ) -> Bool {
        (try? Tolerance<Scalar>(absolute: absolute._value, relative: relative._value))?
            .contains(imaginary._value, other._value) ?? false
    }
}
