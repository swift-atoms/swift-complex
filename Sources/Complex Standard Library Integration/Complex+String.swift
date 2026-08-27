public import Complex

extension Complex.Number where Scalar: BinaryFloatingPoint {

    public var description: String {
        guard isFinite else { return "inf" }
        return "(\(real._value), \(imaginary._value))"
    }
}

#if !hasFeature(Embedded)
    extension Complex.Number: CustomDebugStringConvertible {

        public var debugDescription: String {
            "Complex.Number<\(Scalar.self)>(\(String(reflecting: real._value)), \(String(reflecting: imaginary._value)))"
        }
    }
#endif