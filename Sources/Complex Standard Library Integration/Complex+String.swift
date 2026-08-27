public import Complex

extension Complex.Number where Scalar: BinaryFloatingPoint {

    public var description: String {
        guard isFinite else { return "inf" }
        return "(\(real.value), \(imaginary.value))"
    }
}

#if !hasFeature(Embedded)
    extension Complex.Number: CustomDebugStringConvertible {

        public var debugDescription: String {
            "Complex.Number<\(Scalar.self)>(\(String(reflecting: real.value)), \(String(reflecting: imaginary.value)))"
        }
    }
#endif