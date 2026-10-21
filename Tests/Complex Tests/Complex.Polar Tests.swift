import Tagged
import Testing

@testable import Complex

@Suite
struct `Complex polar coordinates describe length and phase` {

    @Test
    func `Polar length is the Euclidean modulus`() throws {

        let z = Complex.Number(3.0, 4.0)
        let len = z.polar.length
        #expect(try Tolerance<Double>(absolute: 1e-10).contains(len.underlying, 5.0))
    }

    @Test
    func `Static polar length is the Euclidean modulus`() throws {
        let z = Complex.Number(3.0, 4.0)
        let len = Complex.Number.Polar.length(of: z)
        #expect(try Tolerance<Double>(absolute: 1e-10).contains(len.underlying, 5.0))
    }

    @Test
    func `Polar phase identifies the direction`() throws {

        let z1 = Complex.Number(1.0, 1.0)
        let phase1 = z1.polar.phase
        #expect(try Tolerance<Double>(absolute: 1e-10).contains(phase1.underlying, Double.pi / 4))

        let z2 = Complex.Number(1.0, 0.0)
        let phase2 = z2.polar.phase
        #expect(try Tolerance<Double>(absolute: 1e-15).contains(phase2.underlying, 0.0))

        let z3 = Complex.Number(0.0, 1.0)
        let phase3 = z3.polar.phase
        #expect(try Tolerance<Double>(absolute: 1e-10).contains(phase3.underlying, Double.pi / 2))
    }

    @Test
    func `Static polar phase identifies the direction`() throws {
        let z = Complex.Number(1.0, 1.0)
        let phase = Complex.Number.Polar.phase(of: z)
        #expect(try Tolerance<Double>(absolute: 1e-10).contains(phase.underlying, Double.pi / 4))
    }

    @Test
    func `Polar construction produces Cartesian components`() throws {
        let length = Complex.Number<Double>.Modulus.Value(5.0)
        let phase: Radian<Double> = .pi.quarter

        let z = Complex.Number(length: length, phase: phase)

        let expectedValue = 5.0 * Double(2).squareRoot() / 2.0
        #expect(z.real.equals.approximate(expectedValue.real, tolerance: 1e-10))
        #expect(z.imaginary.equals.approximate(expectedValue.i, tolerance: 1e-10))
    }

    @Test
    func `Polar conversion round trips the original value`() throws {
        let original = Complex.Number(3.0, 4.0)
        let length = original.polar.length
        let phase = original.polar.phase

        let reconstructed = Complex.Number(length: length, phase: phase)
        #expect(reconstructed.real.equals.approximate(original.real, tolerance: 1e-10))
        #expect(reconstructed.imaginary.equals.approximate(original.imaginary, tolerance: 1e-10))
    }

    @Test
    func `Squared polar length avoids a square root`() throws {
        let z = Complex.Number(3.0, 4.0)
        let sq = z.polar.squared
        #expect(try Tolerance<Double>(absolute: 1e-10).contains(sq, 25.0))
    }

    @Test
    func `Static squared length avoids a square root`() throws {
        let z = Complex.Number(3.0, 4.0)
        let sq = Complex.Number.Polar.squared(of: z)
        #expect(try Tolerance<Double>(absolute: 1e-10).contains(sq, 25.0))
    }

    @Test
    func `Modulus values support scalar arithmetic`() throws {
        let m1 = Complex.Number<Double>.Modulus.Value(3.0)
        let m2 = Complex.Number<Double>.Modulus.Value(4.0)

        let sum = m1 + m2
        #expect(sum == 7.0)

        let diff = m2 - m1
        #expect(diff == 1.0)

        let product = m1 * m2
        #expect(product == 12.0)

        let quotient = m2 / m1
        #expect(try Tolerance<Double>(absolute: 1e-10).contains(quotient.underlying, 4.0 / 3.0))
    }
}
