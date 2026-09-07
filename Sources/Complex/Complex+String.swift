extension Complex.Number where Scalar: BinaryFloatingPoint {

    public var description: String {
        guard isFinite else { return "inf" }
        return "(\(real._value), \(imaginary._value))"
    }
}
