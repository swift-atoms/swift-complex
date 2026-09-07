public import Tolerance

extension Complex.Real {

    public struct Equals {
        @usableFromInline
        let real: Complex.Real<Scalar>

        @usableFromInline
        internal init(_ real: Complex.Real<Scalar>) {
            self.real = real
        }
    }
}

extension Complex.Real.Equals: Swift.Sendable where Scalar: Swift.Sendable {}

extension Complex.Real {

    @inlinable
    public var equals: Equals {
        Equals(self)
    }
}

extension Complex.Real.Equals where Scalar: BinaryFloatingPoint {

    @inlinable
    public func approximate(_ other: Complex.Real<Scalar>, tolerance: Complex.Real<Scalar>) -> Bool
    {
        (try? Tolerance<Scalar>(absolute: tolerance._value))?.contains(real._value, other._value) ?? false
    }

    @inlinable
    public func approximate(
        _ other: Complex.Real<Scalar>,
        absolute: Complex.Real<Scalar>,
        relative: Complex.Real<Scalar> = .zero
    ) -> Bool {
        (try? Tolerance<Scalar>(absolute: absolute._value, relative: relative._value))?
            .contains(real._value, other._value) ?? false
    }
}
