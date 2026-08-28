import Tagged_Standard_Library_Integration
import Testing

@testable import Complex

@Suite
struct ComplexPolarTests {

    @Test
    func length() {

        let z = Complex.Number(3.0, 4.0)
        let len = z.polar.length
        #expect(len.underlying.equals.approximate(5.0, tolerance: 1e-10))
    }

    @Test
    func lengthStatic() {
        let z = Complex.Number(3.0, 4.0)
        let len = Complex.Number.Polar.length(of: z)
        #expect(len.underlying.equals.approximate(5.0, tolerance: 1e-10))
    }

    @Test
    func phase() {

        let z1 = Complex.Number(1.0, 1.0)
        let phase1 = z1.polar.phase
        #expect(phase1.underlying.equals.approximate(Double.pi / 4, tolerance: 1e-10))

        let z2 = Complex.Number(1.0, 0.0)
        let phase2 = z2.polar.phase
        #expect(phase2.underlying.equals.approximate(0.0, tolerance: 1e-15))

        let z3 = Complex.Number(0.0, 1.0)
        let phase3 = z3.polar.phase
        #expect(phase3.underlying.equals.approximate(Double.pi / 2, tolerance: 1e-10))
    }

    @Test
    func phaseStatic() {
        let z = Complex.Number(1.0, 1.0)
        let phase = Complex.Number.Polar.phase(of: z)
        #expect(phase.underlying.equals.approximate(Double.pi / 4, tolerance: 1e-10))
    }

    @Test
    func polarConstruction() {
        let length = Complex.Number<Double>.Modulus.Value(5.0)
        let phase: Radian<Double> = .pi.quarter

        let z = Complex.Number(length: length, phase: phase)

        let expectedValue = 5.0 * Double.math.sqrt(2.0) / 2.0
        #expect(z.real.equals.approximate(expectedValue.real, tolerance: 1e-10))
        #expect(z.imaginary.equals.approximate(expectedValue.i, tolerance: 1e-10))
    }

    @Test
    func polarRoundTrip() {
        let original = Complex.Number(3.0, 4.0)
        let length = original.polar.length
        let phase = original.polar.phase

        let reconstructed = Complex.Number(length: length, phase: phase)
        #expect(reconstructed.real.equals.approximate(original.real, tolerance: 1e-10))
        #expect(reconstructed.imaginary.equals.approximate(original.imaginary, tolerance: 1e-10))
    }

    @Test
    func squaredLength() {
        let z = Complex.Number(3.0, 4.0)
        let sq = z.polar.squared
        #expect(sq.equals.approximate(25.0, tolerance: 1e-10))
    }

    @Test
    func squaredLengthStatic() {
        let z = Complex.Number(3.0, 4.0)
        let sq = Complex.Number.Polar.squared(of: z)
        #expect(sq.equals.approximate(25.0, tolerance: 1e-10))
    }

    @Test
    func modulusArithmetic() {
        let m1 = Complex.Number<Double>.Modulus.Value(3.0)
        let m2 = Complex.Number<Double>.Modulus.Value(4.0)

        let sum = m1 + m2
        #expect(sum == 7.0)

        let diff = m2 - m1
        #expect(diff == 1.0)

        let product = m1 * m2
        #expect(product == 12.0)

        let quotient = m2 / m1
        #expect(quotient.underlying.equals.approximate(4.0 / 3.0, tolerance: 1e-10))
    }
}
