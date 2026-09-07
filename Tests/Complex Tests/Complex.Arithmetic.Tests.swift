import Testing

@testable import Complex

@Suite
struct `Complex arithmetic preserves Cartesian algebraic identities` {

    @Test
    func `Complex construction preserves both Cartesian components`() {
        let z = Complex.Number(3.0, 4.0)
        #expect(z.real == 3.0)
        #expect(z.imaginary == 4.0)
    }

    @Test
    func `Real construction supplies a zero imaginary component`() {
        let z = Complex.Number<Double>(5.0)
        #expect(z.real == 5.0)
        #expect(z.imaginary == 0.0)
    }

    @Test
    func `Complex constants represent zero one and the imaginary unit`() {
        let zero = Complex.Number<Double>.zero
        #expect(zero.real == 0.0)
        #expect(zero.imaginary == 0.0)

        let one = Complex.Number<Double>.one
        #expect(one.real == 1.0)
        #expect(one.imaginary == 0.0)

        let i = Complex.Number<Double>.i
        #expect(i.real == 0.0)
        #expect(i.imaginary == 1.0)
    }

    @Test
    func `Complex addition sums the corresponding components`() {
        let z = Complex.Number(1.0, 2.0)
        let w = Complex.Number(3.0, 4.0)
        let sum = z + w
        #expect(sum.real == 4.0)
        #expect(sum.imaginary == 6.0)
    }

    @Test
    func `Adding a real value changes only the real component`() {
        let z = Complex.Number(1.0, 2.0)
        let sum1 = z + 5.0.real
        #expect(sum1.real == 6.0)
        #expect(sum1.imaginary == 2.0)

        let sum2 = 5.0.real + z
        #expect(sum2.real == 6.0)
        #expect(sum2.imaginary == 2.0)
    }

    @Test
    func `Complex subtraction subtracts the corresponding components`() {
        let z = Complex.Number(5.0, 7.0)
        let w = Complex.Number(2.0, 3.0)
        let diff = z - w
        #expect(diff.real == 3.0)
        #expect(diff.imaginary == 4.0)
    }

    @Test
    func `Complex negation reverses both component signs`() {
        let z = Complex.Number(3.0, -4.0)
        let neg = -z
        #expect(neg.real == -3.0)
        #expect(neg.imaginary == 4.0)
    }

    @Test
    func `Complex multiplication distributes across real and imaginary components`() {

        let z = Complex.Number(1.0, 2.0)
        let w = Complex.Number(3.0, 4.0)
        let product = z * w
        #expect(product.real.equals.approximate(-5.0, tolerance: 1e-10))
        #expect(product.imaginary.equals.approximate(10.0, tolerance: 1e-10))
    }

    @Test
    func `Multiplying by a real value scales both components`() {
        let z = Complex.Number(2.0, 3.0)
        let product = z * 2.0.real
        #expect(product.real == 4.0)
        #expect(product.imaginary == 6.0)
    }

    @Test
    func `Squaring the imaginary unit produces negative one`() {
        let i = Complex.Number<Double>.i
        let iSquared = i * i
        #expect(iSquared.real.equals.approximate(-1.0, tolerance: 1e-15))
        #expect(iSquared.imaginary.equals.approximate(0.0, tolerance: 1e-15))
    }

    @Test
    func `Complex division produces the expected Cartesian quotient`() {

        let z = Complex.Number(3.0, 4.0)
        let w = Complex.Number(1.0, 2.0)
        let quotient = z / w
        #expect(quotient.real.equals.approximate((11.0 / 5.0).real, tolerance: 1e-10))
        #expect(quotient.imaginary.equals.approximate((-2.0 / 5.0).i, tolerance: 1e-10))
    }

    @Test
    func `Dividing by a real value scales both components`() {
        let z = Complex.Number(4.0, 6.0)
        let quotient = z / 2.0.real
        #expect(quotient.real == 2.0)
        #expect(quotient.imaginary == 3.0)
    }

    @Test
    func `Complex conjugation reverses the imaginary sign and is involutive`() {
        let z = Complex.Number(3.0, 4.0)

        let conj1 = Complex.Number.conjugate(of: z)
        #expect(conj1.real == 3.0)
        #expect(conj1.imaginary == -4.0)

        let conj2 = z.conjugate
        #expect(conj2 == conj1)

        #expect(conj1.conjugate == z)
    }

    @Test
    func `Multiplication by the conjugate produces the squared magnitude`() {

        let z = Complex.Number(3.0, 4.0)
        let product = z * z.conjugate
        #expect(product.real.equals.approximate(25.0, tolerance: 1e-10))
        #expect(product.imaginary.equals.approximate(0.0, tolerance: 1e-15))
    }

    @Test
    func `Complex reciprocals multiply with their original value to produce one`() {
        let z = Complex.Number(3.0, 4.0)

        let recip1 = Complex.Number.reciprocal(of: z)

        let product = z * recip1
        #expect(product.real.equals.approximate(1.0, tolerance: 1e-10))
        #expect(product.imaginary.equals.approximate(0.0, tolerance: 1e-10))

        let recip2 = z.reciprocal
        #expect(recip1 == recip2)
    }
}
