import Testing

@testable import Complex

@Suite
struct ComplexArithmeticTests {

    @Test
    func construction() {
        let z = Complex.Number(3.0, 4.0)
        #expect(z.real == 3.0)
        #expect(z.imaginary == 4.0)
    }

    @Test
    func realConstruction() {
        let z = Complex.Number<Double>(5.0)
        #expect(z.real == 5.0)
        #expect(z.imaginary == 0.0)
    }

    @Test
    func staticProperties() {
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
    func addition() {
        let z = Complex.Number(1.0, 2.0)
        let w = Complex.Number(3.0, 4.0)
        let sum = z + w
        #expect(sum.real == 4.0)
        #expect(sum.imaginary == 6.0)
    }

    @Test
    func additionWithReal() {
        let z = Complex.Number(1.0, 2.0)
        let sum1 = z + 5.0.real
        #expect(sum1.real == 6.0)
        #expect(sum1.imaginary == 2.0)

        let sum2 = 5.0.real + z
        #expect(sum2.real == 6.0)
        #expect(sum2.imaginary == 2.0)
    }

    @Test
    func subtraction() {
        let z = Complex.Number(5.0, 7.0)
        let w = Complex.Number(2.0, 3.0)
        let diff = z - w
        #expect(diff.real == 3.0)
        #expect(diff.imaginary == 4.0)
    }

    @Test
    func negation() {
        let z = Complex.Number(3.0, -4.0)
        let neg = -z
        #expect(neg.real == -3.0)
        #expect(neg.imaginary == 4.0)
    }

    @Test
    func multiplication() {

        let z = Complex.Number(1.0, 2.0)
        let w = Complex.Number(3.0, 4.0)
        let product = z * w
        #expect(product.real.equals.approximate(-5.0, tolerance: 1e-10))
        #expect(product.imaginary.equals.approximate(10.0, tolerance: 1e-10))
    }

    @Test
    func multiplicationWithReal() {
        let z = Complex.Number(2.0, 3.0)
        let product = z * 2.0.real
        #expect(product.real == 4.0)
        #expect(product.imaginary == 6.0)
    }

    @Test
    func iSquaredIsMinusOne() {
        let i = Complex.Number<Double>.i
        let iSquared = i * i
        #expect(iSquared.real.equals.approximate(-1.0, tolerance: 1e-15))
        #expect(iSquared.imaginary.equals.approximate(0.0, tolerance: 1e-15))
    }

    @Test
    func division() {

        let z = Complex.Number(3.0, 4.0)
        let w = Complex.Number(1.0, 2.0)
        let quotient = z / w
        #expect(quotient.real.equals.approximate((11.0 / 5.0).real, tolerance: 1e-10))
        #expect(quotient.imaginary.equals.approximate((-2.0 / 5.0).i, tolerance: 1e-10))
    }

    @Test
    func divisionByReal() {
        let z = Complex.Number(4.0, 6.0)
        let quotient = z / 2.0.real
        #expect(quotient.real == 2.0)
        #expect(quotient.imaginary == 3.0)
    }

    @Test
    func conjugate() {
        let z = Complex.Number(3.0, 4.0)

        let conj1 = Complex.Number.conjugate(of: z)
        #expect(conj1.real == 3.0)
        #expect(conj1.imaginary == -4.0)

        let conj2 = z.conjugate
        #expect(conj2 == conj1)

        #expect(conj1.conjugate == z)
    }

    @Test
    func conjugateProduct() {

        let z = Complex.Number(3.0, 4.0)
        let product = z * z.conjugate
        #expect(product.real.equals.approximate(25.0, tolerance: 1e-10))
        #expect(product.imaginary.equals.approximate(0.0, tolerance: 1e-15))
    }

    @Test
    func reciprocal() {
        let z = Complex.Number(3.0, 4.0)

        let recip1 = Complex.Number.reciprocal(of: z)

        let product = z * recip1
        #expect(product.real.equals.approximate(1.0, tolerance: 1e-10))
        #expect(product.imaginary.equals.approximate(0.0, tolerance: 1e-10))

        let recip2 = z.reciprocal
        #expect(recip1 == recip2)
    }
}
