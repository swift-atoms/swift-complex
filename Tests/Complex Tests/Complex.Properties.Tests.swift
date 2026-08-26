import Testing

@testable import Complex

@Suite
struct ComplexPropertiesTests {

    @Test
    func isFinite() {
        let finite = Complex.Number(1.0, 2.0)
        #expect(finite.isFinite)

        let infReal = Complex.Number(Double.infinity, 0.0)
        #expect(!infReal.isFinite)

        let infImag = Complex.Number(0.0, Double.infinity)
        #expect(!infImag.isFinite)

        let nan = Complex.Number(Double.nan, 0.0)
        #expect(!nan.isFinite)
    }

    @Test
    func isZero() {
        let zero = Complex.Number<Double>.zero
        #expect(zero.isZero)

        let notZero = Complex.Number(0.0, 1e-100)
        #expect(!notZero.isZero)
    }

    @Test
    func isNormal() {
        let normal = Complex.Number(1.0, 2.0)
        #expect(normal.isNormal)

        let subnormal = Complex.Number(Double.leastNonzeroMagnitude, 0.0)
        #expect(!subnormal.isNormal)

        let zero = Complex.Number<Double>.zero
        #expect(!zero.isNormal)
    }

    @Test
    func isSubnormal() {
        let subnormal = Complex.Number(Double.leastNonzeroMagnitude, 0.0)
        #expect(subnormal.isSubnormal)

        let normal = Complex.Number(1.0, 2.0)
        #expect(!normal.isSubnormal)

        let zero = Complex.Number<Double>.zero
        #expect(!zero.isSubnormal)
    }

    @Test
    func normalized() {
        let z = Complex.Number(3.0, 4.0)
        let n = z.normalized!

        #expect(n.magnitude().equals.approximate(1.0, tolerance: 1e-10))

        #expect(
            n.polar.phase.underlying.equals.approximate(
                z.polar.phase.underlying,
                tolerance: 1e-10
            )
        )
    }

    @Test
    func normalizedZero() {
        let zero = Complex.Number<Double>.zero
        #expect(zero.normalized == nil)
    }

    @Test
    func normalizedInfinity() {
        let inf = Complex.Number<Double>.infinity
        #expect(inf.normalized == nil)
    }

    @Test
    func magnitude() {
        let z = Complex.Number(3.0, 4.0)
        #expect(z.magnitude().equals.approximate(5.0, tolerance: 1e-10))
    }

    @Test
    func magnitudeSquared() {
        let z = Complex.Number(3.0, 4.0)
        #expect(z.magnitude.squared.equals.approximate(25.0, tolerance: 1e-10))
    }

    @Test
    func description() {
        let z = Complex.Number(3.0, 4.0)
        #expect(z.description == "(3.0, 4.0)")

        let inf = Complex.Number<Double>.infinity
        #expect(inf.description == "inf")
    }

    @Test
    func approximateEquality() {
        let z = Complex.Number(1.0, 2.0)
        let w = Complex.Number(1.0 + 1e-12, 2.0 + 1e-12)

        #expect(z.equals.approximate(w, tolerance: 1e-10))
        #expect(!z.equals.approximate(w, tolerance: 1e-15))
    }

    @Test
    func approximateEqualityRelative() {
        let z = Complex.Number(1000.0, 2000.0)
        let w = Complex.Number(1000.1, 2000.1)

        #expect(z.equals.approximate(w, absolute: 0.0, relative: 1e-3))
        #expect(!z.equals.approximate(w, absolute: 0.0, relative: 1e-5))
    }

    @Test
    func componentwiseApproximateEquality() {
        let z = Complex.Number(1.0, 2.0)
        let w = Complex.Number(1.0 + 1e-12, 2.0 + 1e-12)

        #expect(z.equals.componentwise.approximate(w, tolerance: 1e-10))
        #expect(!z.equals.componentwise.approximate(w, tolerance: 1e-15))
    }
}
