extension Complex.Number {

    public struct Polar {
        @usableFromInline
        let complex: Complex.Number<Scalar>

        @usableFromInline
        internal init(_ complex: Complex.Number<Scalar>) {
            self.complex = complex
        }
    }
}

extension Complex.Number.Polar: Sendable where Scalar: Sendable {}
