#if !hasFeature(Embedded)
extension Complex.Number: Swift.Decodable where Scalar: Swift.Decodable {

        public init(from decoder: any Decoder) throws {
            var container = try decoder.unkeyedContainer()
            let real = try container.decode(Scalar.self)
            let imaginary = try container.decode(Scalar.self)
            self.init(real, imaginary)
        }
    }
#endif
