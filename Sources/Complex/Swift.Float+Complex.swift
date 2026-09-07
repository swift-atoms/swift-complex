extension Swift.Float {

    @inlinable
    public var real: Complex.Real<Float> { .init(self) }

    @inlinable
    public var i: Complex.Imaginary<Float> { .init(self) }
}
