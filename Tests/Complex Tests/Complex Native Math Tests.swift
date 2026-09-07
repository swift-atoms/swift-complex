import Complex
import Testing
#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

@Suite struct `Native complex operations preserve numerical boundaries` {
    @Test func `Scaled norms agree with a platform oracle across binary exponents`() {
        var state: UInt64 = 0x3141592653589793
        func next() -> Double {
            state = state &* 6364136223846793005 &+ 1442695040888963407
            return Double(bitPattern: state & 0x7FEFFFFFFFFFFFFF)
        }
        for _ in 0..<6000 {
            let x = next(), y = next()
            let actual = Complex.Number(x, y).magnitude().value
            #if canImport(Darwin)
            let expected = Darwin.hypot(x, y)
            #elseif canImport(Glibc)
            let expected = Glibc.hypot(x, y)
            #endif
            #expect(actual == expected || abs(actual - expected) <= 2 * max(actual.ulp, expected.ulp))
        }
    }

    @Test func `Norms preserve subnormals and infinity dominates NaN`() {
        let tiny = Double.leastNonzeroMagnitude
        #expect(Complex.Number(tiny, 0.0).magnitude().value == tiny)
        #expect(Complex.Number(-0.0, -0.0).magnitude().value.sign == .plus)
        #expect(Complex.Number(Double.infinity, Double.nan).magnitude().value == .infinity)
        #expect(Complex.Number(Double.nan, Double.infinity).magnitude().value == .infinity)
        #expect(Complex.Number(Double.nan, 0.0).magnitude().value.isNaN)
        let large = Double.greatestFiniteMagnitude / 2
        #expect(Complex.Number(large, large).magnitude().value.isFinite)
    }

    @Test func `Square roots retain signed branch cut sides and handle infinite components`() {
        let upper = Complex.Number(-4.0, 0.0).math.sqrt()
        let lower = Complex.Number(-4.0, -0.0).math.sqrt()
        #expect(upper.real.value == 0 && upper.imaginary.value == 2)
        #expect(lower.real.value == 0 && lower.imaginary.value == -2)
        #expect(Complex.Number(-0.0, -0.0).math.sqrt().imaginary.value.sign == .minus)
        let positive = Complex.Number(Double.infinity, -0.0).math.sqrt()
        #expect(positive.real.value == .infinity && positive.imaginary.value.sign == .minus)
        let negative = Complex.Number(-Double.infinity, -0.0).math.sqrt()
        #expect(negative.real.value == 0 && negative.imaginary.value == -.infinity)
        let imaginary = Complex.Number(Double.nan, -Double.infinity).math.sqrt()
        #expect(imaginary.real.value == .infinity && imaginary.imaginary.value == -.infinity)
    }

    @Test func `Square roots remain finite at both ends of the scalar range`() {
        for value in [Double.leastNonzeroMagnitude, .leastNormalMagnitude, 1, .greatestFiniteMagnitude] {
            let root = Complex.Number(value, value).math.sqrt()
            #expect(root.isFinite && root.real.value > 0 && root.imaginary.value > 0)
            let ratio = root.imaginary.value / root.real.value
            #expect(abs(ratio - (Double(2).squareRoot() - 1)) < 1e-15)
        }
    }

    @Test func `Half precision arithmetic needs no elementary function conformance`() {
        let value = Complex.Number<Float16>(3, 4)
        #expect(value.magnitude().value == 5)
        #expect(value.math.sqrt() == Complex.Number<Float16>(2, 1))
        #expect(Complex.Number<Float16>(2, 3).math.pow(3) == Complex.Number<Float16>(-46, 9))
        #expect(Complex.Number<Float16>.i.math.pow(Int.min) == .one)
        #expect(Complex.Number<Float16>.zero.math.pow(0) == .one)
        #expect(Complex.Number<Float16>.zero.math.pow(-1).real.value == .infinity)
    }

    @Test func `Euclidean tolerance rejects overflow driven false matches`() {
        let huge = Double.greatestFiniteMagnitude
        let value = Complex.Number(huge, huge)
        #expect(!value.equals.approximate(-value, absolute: 0, relative: 0.5))
        #expect(value.equals.approximate(-value, absolute: 0, relative: 2))
        #expect(!value.equals.approximate(value, tolerance: -1))
        #expect(!value.equals.approximate(value, tolerance: Complex.Real(Double.nan)))
        #expect(!Complex.Number(huge, 1e-100).equals.approximate(Complex.Number(huge, 0.0), tolerance: 1e-101))
        #expect(Complex.Number(Double.infinity, 0.0).equals.approximate(Complex.Number(Double.infinity, 0.0), tolerance: 0))
    }

    @Test func `Zero root degrees are invalid and negative roots use reciprocals`() {
        let invalid = Complex.Number<Double>.zero.math.root(0)
        #expect(invalid.real.value.isNaN && invalid.imaginary.value.isNaN)
        #expect(Complex.Number<Double>.zero.math.root(-3).real.value == .infinity)
        #expect(Complex.Number(2.0, 0.0).math.root(-1) == Complex.Number(0.5, 0.0))
    }
}
