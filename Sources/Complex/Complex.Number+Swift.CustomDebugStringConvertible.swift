#if !hasFeature(Embedded)
extension Complex.Number: Swift.CustomDebugStringConvertible {

        public var debugDescription: String {
            "Complex.Number<\(Scalar.self)>(\(String(reflecting: real._value)), \(String(reflecting: imaginary._value)))"
        }
    }
#endif
