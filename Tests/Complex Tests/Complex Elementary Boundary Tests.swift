import Complex
import Testing

@Suite struct `Complex elementary functions preserve branch and range information` {
    @Test func `Logarithms distinguish zero poles and signed branch cut sides`() {
        let zero = Complex.Number(0.0, -0.0).math.log()
        #expect(zero.real.value == -.infinity && zero.imaginary.value.sign == .minus)
        let lower = Complex.Number(-0.0, -0.0).math.log()
        #expect(lower.real.value == -.infinity && lower.imaginary.value == -.pi)
        let pole = Complex.Number(-1.0, -0.0).math.log.one.plus()
        #expect(pole.real.value == -.infinity && pole.imaginary.value.sign == .minus)
        let infinite = Complex.Number(-Double.infinity, -0.0).math.log()
        #expect(infinite.real.value == .infinity && infinite.imaginary.value == -.pi)
        #expect(Complex.Number(Double.nan, 0.0).math.log().real.value.isNaN)
    }

    @Test func `Exponential limits preserve the real axis and a finite small component`() {
        let negative = Complex.Number(-Double.infinity, -0.0).math.exp()
        #expect(negative.real.value == 0 && negative.imaginary.value.sign == .minus)
        let positive = Complex.Number(Double.infinity, -0.0).math.exp()
        #expect(positive.real.value == .infinity && positive.imaginary.value == 0)
        let mixed = Complex.Number(1450.0, Double.leastNonzeroMagnitude).math.exp()
        #expect(mixed.real.value == .infinity)
        #expect(mixed.imaginary.value.isFinite && mixed.imaginary.value > 0)
        #expect(Complex.Number(-Double.infinity, Double.nan).math.exp() == .zero)
    }

    @Test func `Large negative hyperbolic arguments retain their component signs`() {
        let positive = Complex.Number(40.0, 1.0)
        let negative = Complex.Number(-40.0, 1.0)
        #expect(negative.math.cosh().real.value == positive.math.cosh().real.value)
        #expect(negative.math.cosh().imaginary.value == -positive.math.cosh().imaginary.value)
        #expect(negative.math.sinh().real.value == -positive.math.sinh().real.value)
        #expect(negative.math.sinh().imaginary.value == positive.math.sinh().imaginary.value)
        #expect(Complex.Number(1000.0, 0.0).math.cosh().imaginary.value == 0)
        #expect(Complex.Number(-1000.0, 0.0).math.sinh().imaginary.value == 0)
        let tangent = positive.math.tanh()
        #expect(tangent.real.value == 1 && tangent.imaginary.value > 0)
        #expect(negative.math.tanh().imaginary.value == tangent.imaginary.value)
    }
}
