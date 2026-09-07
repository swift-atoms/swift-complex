public import Tolerance

extension Complex.Number {

    public struct Equals {
        @usableFromInline
        let complex: Complex.Number<Scalar>

        @usableFromInline
        internal init(_ complex: Complex.Number<Scalar>) {
            self.complex = complex
        }
    }
}

extension Complex.Number.Equals: Swift.Sendable where Scalar: Swift.Sendable {}

extension Complex.Number {

    @inlinable
    public var equals: Equals {
        Equals(self)
    }
}

extension Complex.Number.Equals where Scalar: BinaryFloatingPoint {
    @inlinable
    public func approximate(
        _ other: Complex.Number<Scalar>,
        tolerance: Complex.Real<Scalar>
    ) -> Bool {
        approximate(other, absolute: tolerance)
    }


    @inlinable
    public func approximate(
        _ other: Complex.Number<Scalar>,
        absolute: Complex.Real<Scalar>,
        relative: Complex.Real<Scalar> = .zero
    ) -> Bool {
        guard let allowance = try? Tolerance<Scalar>(absolute: absolute._value, relative: relative._value) else { return false }
        if complex == other { return true }
        guard complex.isFinite && other.isFinite else { return false }
        let x = complex.real._value, y = complex.imaginary._value
        let u = other.real._value, v = other.imaginary._value
        let dx = x - u, dy = y - v
        let distance = Complex.Number<Scalar>._hypot(dx, dy)
        if distance.isFinite && distance <= allowance.absolute { return true }
        if allowance.relative == 0 { return false }
        let scale = max(max(x.magnitude, y.magnitude), max(u.magnitude, v.magnitude))
        guard scale != 0 else { return true }
        let sx = dx.isFinite ? dx / scale : x / scale - u / scale
        let sy = dy.isFinite ? dy / scale : y / scale - v / scale
        let scaledDistance = Complex.Number<Scalar>._hypot(sx, sy)
        let scaledLength = max(
            Complex.Number<Scalar>._hypot(x / scale, y / scale),
            Complex.Number<Scalar>._hypot(u / scale, v / scale))
        return scaledDistance <= allowance.absolute / scale + allowance.relative * scaledLength
    }
}

extension Complex.Number.Equals {

    public struct Componentwise {
        @usableFromInline
        let complex: Complex.Number<Scalar>

        @usableFromInline
        internal init(_ complex: Complex.Number<Scalar>) {
            self.complex = complex
        }
    }
}

extension Complex.Number.Equals.Componentwise: Swift.Sendable where Scalar: Swift.Sendable {}

extension Complex.Number.Equals {

    @inlinable
    public var componentwise: Componentwise {
        Componentwise(complex)
    }
}

extension Complex.Number.Equals.Componentwise where Scalar: BinaryFloatingPoint {

    @inlinable
    public func approximate(
        _ other: Complex.Number<Scalar>,
        tolerance: Complex.Real<Scalar>
    ) -> Bool {
        guard let allowance = try? Tolerance<Scalar>(absolute: tolerance._value) else { return false }
        return allowance.contains(complex.real._value, other.real._value)
            && allowance.contains(complex.imaginary._value, other.imaginary._value)
    }
}
