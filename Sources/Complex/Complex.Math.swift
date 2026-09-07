extension Complex.Number {

    public struct Math {
        @usableFromInline
        let complex: Complex.Number<Scalar>

        @usableFromInline
        internal init(_ complex: Complex.Number<Scalar>) {
            self.complex = complex
        }
    }
}

extension Complex.Number.Math: Swift.Sendable where Scalar: Swift.Sendable {
}

extension Complex.Number {

    @inlinable
    public var math: Math {
        Math(self)
    }
}
