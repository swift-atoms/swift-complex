import Complex
import Numeric
import Numeric_Standard_Library_Integration
import Tagged
import Testing

@testable import Complex

@Suite
struct `Complex.Number division` {

    let tolerance: Complex.Real<Double> = 1e-10

    @Test
    func `basic division`() {
        let z = Complex.Number(3.0, 4.0)
        let w = Complex.Number(1.0, 2.0)
        let result = z / w

        let product = result * w
        #expect(product.equals.approximate(z, tolerance: tolerance))
    }

    @Test
    func `division by one`() {
        let z = Complex.Number(3.0, 4.0)
        let result = z / Complex.Number<Double>.one
        #expect(result.equals.approximate(z, tolerance: tolerance))
    }

    @Test
    func `division by i`() {

        let z = Complex.Number(3.0, 4.0)
        let result = z / Complex.Number<Double>.i

        let expected = Complex.Number(4.0, -3.0)
        #expect(result.equals.approximate(expected, tolerance: tolerance))
    }

    @Test
    func `division by zero`() {
        let z = Complex.Number(1.0, 2.0)
        let result = z / Complex.Number<Double>.zero
        #expect(!result.isFinite)
    }

    @Test
    func `zero divided by non zero`() {
        let result = Complex.Number<Double>.zero / Complex.Number(1.0, 2.0)
        #expect(result.equals.approximate(Complex.Number<Double>.zero, tolerance: tolerance))
    }

    @Test
    func `division with large denominator`() {

        let large = Double.greatestFiniteMagnitude / 4
        let z = Complex.Number(large, large)
        let w = Complex.Number(large, large)
        let result = z / w

        #expect(result.equals.approximate(Complex.Number<Double>.one, tolerance: 1e-5))
    }

    @Test
    func `division with small denominator`() {

        let small = Double.leastNormalMagnitude * 4
        let z = Complex.Number(1.0, 1.0)
        let w = Complex.Number(small, small)
        let result = z / w

        #expect(result.isFinite)
        #expect(result.magnitude() > 1.0)
    }

    @Test
    func `division preserves scale`() {

        let z = Complex.Number(3.0, 4.0)
        let w = Complex.Number(1.0, 2.0)
        let t: Complex.Real<Double> = Complex.Real(1e100)

        let result1 = z / w
        let result2 = z.scalar.multiply(by: t) / w.scalar.multiply(by: t)

        #expect(result1.equals.approximate(result2, tolerance: 1e-5))
    }

    @Test
    func `multiplication division inverse`() {
        let z = Complex.Number(3.0, 4.0)
        let w = Complex.Number(1.0, 2.0)

        let product = z * w
        let result = product / w
        #expect(result.equals.approximate(z, tolerance: tolerance))
    }

    @Test
    func `reciprocal consistency`() {
        let w = Complex.Number(1.0, 2.0)

        let recip1 = Complex.Number<Double>.one / w
        let recip2 = w.reciprocal
        #expect(recip1.equals.approximate(recip2, tolerance: tolerance))
    }
}
