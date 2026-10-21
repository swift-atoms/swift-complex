import Testing

@testable import Complex

@Suite
struct `Complex division preserves quotients across scale and boundary values` {

    let tolerance: Complex.Real<Double> = 1e-10

    @Test
    func `Multiplying a complex quotient by its divisor recovers the numerator`() {
        let z = Complex.Number(3.0, 4.0)
        let w = Complex.Number(1.0, 2.0)
        let result = z / w

        let product = result * w
        #expect(product.equals.approximate(z, tolerance: tolerance))
    }

    @Test
    func `Complex division by one preserves the numerator`() {
        let z = Complex.Number(3.0, 4.0)
        let result = z / Complex.Number<Double>.one
        #expect(result.equals.approximate(z, tolerance: tolerance))
    }

    @Test
    func `Division by the imaginary unit rotates the Cartesian components`() {

        let z = Complex.Number(3.0, 4.0)
        let result = z / Complex.Number<Double>.i

        let expected = Complex.Number(4.0, -3.0)
        #expect(result.equals.approximate(expected, tolerance: tolerance))
    }

    @Test
    func `Complex division by zero produces a nonfinite result`() {
        let z = Complex.Number(1.0, 2.0)
        let result = z / Complex.Number<Double>.zero
        #expect(!result.isFinite)
    }

    @Test
    func `Zero divided by a nonzero complex value remains zero`() {
        let result = Complex.Number<Double>.zero / Complex.Number(1.0, 2.0)
        #expect(result.equals.approximate(Complex.Number<Double>.zero, tolerance: tolerance))
    }

    @Test
    func `Equal large complex values divide to one`() {

        let large = Double.greatestFiniteMagnitude / 4
        let z = Complex.Number(large, large)
        let w = Complex.Number(large, large)
        let result = z / w

        #expect(result.equals.approximate(Complex.Number<Double>.one, tolerance: 1e-5))
    }

    @Test
    func `Complex division by a small denominator retains a finite quotient`() {

        let small = Double.leastNormalMagnitude * 4
        let z = Complex.Number(1.0, 1.0)
        let w = Complex.Number(small, small)
        let result = z / w

        #expect(result.isFinite)
        #expect(result.magnitude() > 1.0)
    }

    @Test
    func `Scaling both complex operands preserves their quotient`() {

        let z = Complex.Number(3.0, 4.0)
        let w = Complex.Number(1.0, 2.0)
        let t: Complex.Real<Double> = Complex.Real(1e100)

        let result1 = z / w
        let result2 = z.scalar.multiply(by: t) / w.scalar.multiply(by: t)

        #expect(result1.equals.approximate(result2, tolerance: 1e-5))
    }

    @Test
    func `Complex division reverses multiplication by the divisor`() {
        let z = Complex.Number(3.0, 4.0)
        let w = Complex.Number(1.0, 2.0)

        let product = z * w
        let result = product / w
        #expect(result.equals.approximate(z, tolerance: tolerance))
    }

    @Test
    func `Complex reciprocals agree with division of one`() {
        let w = Complex.Number(1.0, 2.0)

        let recip1 = Complex.Number<Double>.one / w
        let recip2 = w.reciprocal
        #expect(recip1.equals.approximate(recip2, tolerance: tolerance))
    }
}
