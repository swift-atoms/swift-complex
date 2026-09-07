#if !hasFeature(Embedded)
extension Complex.Number: Swift.Encodable where Scalar: Swift.Encodable {

        public func encode(to encoder: any Encoder) throws {
            var container = encoder.unkeyedContainer()
            try container.encode(real.value)
            try container.encode(imaginary.value)
        }
    }
#endif
