import Testing

@testable import Complex

@Suite
struct `Complex values preserve their algebraic properties` {

    @Test
    func `A complex value is finite when both components are finite`() throws {
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
    func `A complex value is zero when both components are zero`() throws {
        let zero = Complex.Number<Double>.zero
        #expect(zero.isZero)

        let notZero = Complex.Number(0.0, 1e-100)
        #expect(!notZero.isZero)
    }

    @Test
    func `Normality accounts for both components`() throws {
        let normal = Complex.Number(1.0, 2.0)
        #expect(normal.isNormal)

        let subnormal = Complex.Number(Double.leastNonzeroMagnitude, 0.0)
        #expect(!subnormal.isNormal)

        let zero = Complex.Number<Double>.zero
        #expect(!zero.isNormal)
    }

    @Test
    func `Subnormal components are classified correctly`() throws {
        let subnormal = Complex.Number(Double.leastNonzeroMagnitude, 0.0)
        #expect(subnormal.isSubnormal)

        let normal = Complex.Number(1.0, 2.0)
        #expect(!normal.isSubnormal)

        let zero = Complex.Number<Double>.zero
        #expect(!zero.isSubnormal)
    }

    @Test
    func `Normalization preserves phase and produces unit magnitude`() throws {
        let z = Complex.Number(3.0, 4.0)
        let n = z.normalized!

        #expect(n.magnitude().equals.approximate(1.0, tolerance: 1e-10))

        #expect(
            try Tolerance<Double>(absolute: 1e-10).contains(
                n.polar.phase.underlying,
                z.polar.phase.underlying
            )
        )
    }

    @Test
    func `Zero has no normalized direction`() throws {
        let zero = Complex.Number<Double>.zero
        #expect(zero.normalized == nil)
    }

    @Test
    func `Infinity has no normalized direction`() throws {
        let inf = Complex.Number<Double>.infinity
        #expect(inf.normalized == nil)
    }

    @Test
    func `Magnitude is the Euclidean length`() throws {
        let z = Complex.Number(3.0, 4.0)
        #expect(z.magnitude().equals.approximate(5.0, tolerance: 1e-10))
    }

    @Test
    func `Squared magnitude is the sum of squared components`() throws {
        let z = Complex.Number(3.0, 4.0)
        #expect(z.magnitude.squared.equals.approximate(25.0, tolerance: 1e-10))
    }

    @Test
    func `Descriptions include the real and imaginary components`() throws {
        let z = Complex.Number(3.0, 4.0)
        #expect(z.description == "(3.0, 4.0)")

        let inf = Complex.Number<Double>.infinity
        #expect(inf.description == "inf")
    }

    @Test
    func `Absolute closeness respects its allowance`() throws {
        let z = Complex.Number(1.0, 2.0)
        let w = Complex.Number(1.0 + 1e-12, 2.0 + 1e-12)

        #expect(z.equals.approximate(w, tolerance: 1e-10))
        #expect(!z.equals.approximate(w, tolerance: 1e-15))
    }

    @Test
    func `Relative closeness scales with magnitude`() throws {
        let z = Complex.Number(1000.0, 2000.0)
        let w = Complex.Number(1000.1, 2000.1)

        #expect(z.equals.approximate(w, absolute: 0.0, relative: 1e-3))
        #expect(!z.equals.approximate(w, absolute: 0.0, relative: 1e-5))
    }

    @Test
    func `Componentwise closeness checks both components`() throws {
        let z = Complex.Number(1.0, 2.0)
        let w = Complex.Number(1.0 + 1e-12, 2.0 + 1e-12)

        #expect(z.equals.componentwise.approximate(w, tolerance: 1e-10))
        #expect(!z.equals.componentwise.approximate(w, tolerance: 1e-15))
    }
}
