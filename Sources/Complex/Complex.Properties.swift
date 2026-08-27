public import Numeric

extension Complex.Number where Scalar: BinaryFloatingPoint {

    @inlinable
    public var isFinite: Bool {
        real.isFinite && imaginary.isFinite
    }

    @inlinable
    public var isZero: Bool {
        real.isZero && imaginary.isZero
    }

    @inlinable
    public var isNormal: Bool {
        isFinite && (real.isNormal || imaginary.isNormal)
    }

    @inlinable
    public var isSubnormal: Bool {
        isFinite && !isNormal && !isZero
    }

    @inlinable
    public static var infinity: Self {
        Self(.infinity, 0)
    }
}

extension Complex.Number where Scalar: BinaryFloatingPoint & Numeric.Transcendental {

    @inlinable
    public var normalized: Self? {
        let length = magnitude()._value
        if length.isNormal {
            return Self(real._value / length, imaginary._value / length)
        }
        if isZero || !isFinite {
            return nil
        }

        let scale = max(abs(real._value), abs(imaginary._value))
        return Self(real._value / scale, imaginary._value / scale).normalized
    }
}