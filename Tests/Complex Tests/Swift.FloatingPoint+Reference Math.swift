// Test-only reference backend. Production conformances belong to the higher Numeric package.
public import Trigonometry
public import Exponential
#if canImport(Darwin)
import Darwin
extension Swift.Double: @retroactive Trigonometry.`Protocol`, @retroactive Exponential.`Protocol` {
    public static func sin(_ x: Double) -> Double { Darwin.sin(x) }
    public static func cos(_ x: Double) -> Double { Darwin.cos(x) }
    public static func tan(_ x: Double) -> Double { Darwin.tan(x) }
    public static func asin(_ x: Double) -> Double { Darwin.asin(x) }
    public static func acos(_ x: Double) -> Double { Darwin.acos(x) }
    public static func atan(_ x: Double) -> Double { Darwin.atan(x) }
    public static func atan2(_ y: Double, _ x: Double) -> Double { Darwin.atan2(y, x) }
    public static func sinh(_ x: Double) -> Double { Darwin.sinh(x) }
    public static func cosh(_ x: Double) -> Double { Darwin.cosh(x) }
    public static func tanh(_ x: Double) -> Double { Darwin.tanh(x) }
    public static func asinh(_ x: Double) -> Double { Darwin.asinh(x) }
    public static func acosh(_ x: Double) -> Double { Darwin.acosh(x) }
    public static func atanh(_ x: Double) -> Double { Darwin.atanh(x) }
    public static func exp(_ x: Double) -> Double { Darwin.exp(x) }
    public static func expm1(_ x: Double) -> Double { Darwin.expm1(x) }
    public static func exp2(_ x: Double) -> Double { Darwin.exp2(x) }
    public static func log(_ x: Double) -> Double { Darwin.log(x) }
    public static func log1p(_ x: Double) -> Double { Darwin.log1p(x) }
    public static func log2(_ x: Double) -> Double { Darwin.log2(x) }
    public static func log10(_ x: Double) -> Double { Darwin.log10(x) }
}
extension Swift.Float: @retroactive Trigonometry.`Protocol`, @retroactive Exponential.`Protocol` {
    public static func sin(_ x: Float) -> Float { Darwin.sinf(x) }
    public static func cos(_ x: Float) -> Float { Darwin.cosf(x) }
    public static func tan(_ x: Float) -> Float { Darwin.tanf(x) }
    public static func asin(_ x: Float) -> Float { Darwin.asinf(x) }
    public static func acos(_ x: Float) -> Float { Darwin.acosf(x) }
    public static func atan(_ x: Float) -> Float { Darwin.atanf(x) }
    public static func atan2(_ y: Float, _ x: Float) -> Float { Darwin.atan2f(y, x) }
    public static func sinh(_ x: Float) -> Float { Darwin.sinhf(x) }
    public static func cosh(_ x: Float) -> Float { Darwin.coshf(x) }
    public static func tanh(_ x: Float) -> Float { Darwin.tanhf(x) }
    public static func asinh(_ x: Float) -> Float { Darwin.asinhf(x) }
    public static func acosh(_ x: Float) -> Float { Darwin.acoshf(x) }
    public static func atanh(_ x: Float) -> Float { Darwin.atanhf(x) }
    public static func exp(_ x: Float) -> Float { Darwin.expf(x) }
    public static func expm1(_ x: Float) -> Float { Darwin.expm1f(x) }
    public static func exp2(_ x: Float) -> Float { Darwin.exp2f(x) }
    public static func log(_ x: Float) -> Float { Darwin.logf(x) }
    public static func log1p(_ x: Float) -> Float { Darwin.log1pf(x) }
    public static func log2(_ x: Float) -> Float { Darwin.log2f(x) }
    public static func log10(_ x: Float) -> Float { Darwin.log10f(x) }
}
#elseif canImport(Glibc)
import Glibc
extension Swift.Double: @retroactive Trigonometry.`Protocol`, @retroactive Exponential.`Protocol` {
    public static func sin(_ x: Double) -> Double { Glibc.sin(x) }
    public static func cos(_ x: Double) -> Double { Glibc.cos(x) }
    public static func tan(_ x: Double) -> Double { Glibc.tan(x) }
    public static func asin(_ x: Double) -> Double { Glibc.asin(x) }
    public static func acos(_ x: Double) -> Double { Glibc.acos(x) }
    public static func atan(_ x: Double) -> Double { Glibc.atan(x) }
    public static func atan2(_ y: Double, _ x: Double) -> Double { Glibc.atan2(y, x) }
    public static func sinh(_ x: Double) -> Double { Glibc.sinh(x) }
    public static func cosh(_ x: Double) -> Double { Glibc.cosh(x) }
    public static func tanh(_ x: Double) -> Double { Glibc.tanh(x) }
    public static func asinh(_ x: Double) -> Double { Glibc.asinh(x) }
    public static func acosh(_ x: Double) -> Double { Glibc.acosh(x) }
    public static func atanh(_ x: Double) -> Double { Glibc.atanh(x) }
    public static func exp(_ x: Double) -> Double { Glibc.exp(x) }
    public static func expm1(_ x: Double) -> Double { Glibc.expm1(x) }
    public static func exp2(_ x: Double) -> Double { Glibc.exp2(x) }
    public static func log(_ x: Double) -> Double { Glibc.log(x) }
    public static func log1p(_ x: Double) -> Double { Glibc.log1p(x) }
    public static func log2(_ x: Double) -> Double { Glibc.log2(x) }
    public static func log10(_ x: Double) -> Double { Glibc.log10(x) }
}
extension Swift.Float: @retroactive Trigonometry.`Protocol`, @retroactive Exponential.`Protocol` {
    public static func sin(_ x: Float) -> Float { Glibc.sinf(x) }
    public static func cos(_ x: Float) -> Float { Glibc.cosf(x) }
    public static func tan(_ x: Float) -> Float { Glibc.tanf(x) }
    public static func asin(_ x: Float) -> Float { Glibc.asinf(x) }
    public static func acos(_ x: Float) -> Float { Glibc.acosf(x) }
    public static func atan(_ x: Float) -> Float { Glibc.atanf(x) }
    public static func atan2(_ y: Float, _ x: Float) -> Float { Glibc.atan2f(y, x) }
    public static func sinh(_ x: Float) -> Float { Glibc.sinhf(x) }
    public static func cosh(_ x: Float) -> Float { Glibc.coshf(x) }
    public static func tanh(_ x: Float) -> Float { Glibc.tanhf(x) }
    public static func asinh(_ x: Float) -> Float { Glibc.asinhf(x) }
    public static func acosh(_ x: Float) -> Float { Glibc.acoshf(x) }
    public static func atanh(_ x: Float) -> Float { Glibc.atanhf(x) }
    public static func exp(_ x: Float) -> Float { Glibc.expf(x) }
    public static func expm1(_ x: Float) -> Float { Glibc.expm1f(x) }
    public static func exp2(_ x: Float) -> Float { Glibc.exp2f(x) }
    public static func log(_ x: Float) -> Float { Glibc.logf(x) }
    public static func log1p(_ x: Float) -> Float { Glibc.log1pf(x) }
    public static func log2(_ x: Float) -> Float { Glibc.log2f(x) }
    public static func log10(_ x: Float) -> Float { Glibc.log10f(x) }
}
#else
#error("A test-only reference math backend is required on this platform")
#endif
