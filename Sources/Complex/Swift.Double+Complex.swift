extension Swift.Double {

    @inlinable
    public var real: Complex.Real<Double> { .init(self) }

    @inlinable
    public var i: Complex.Imaginary<Double> { .init(self) }
}
