@inlinable
public func + (lhs: Complex.Real<Double>, rhs: Complex.Imaginary<Double>) -> Complex.Number<Double>
{
    Complex.Number(real: lhs, imaginary: rhs)
}

@inlinable
public func + (lhs: Complex.Imaginary<Double>, rhs: Complex.Real<Double>) -> Complex.Number<Double>
{
    Complex.Number(real: rhs, imaginary: lhs)
}

@inlinable
public func - (lhs: Complex.Real<Double>, rhs: Complex.Imaginary<Double>) -> Complex.Number<Double>
{
    Complex.Number(real: lhs, imaginary: -rhs)
}

@inlinable
public func - (lhs: Complex.Imaginary<Double>, rhs: Complex.Real<Double>) -> Complex.Number<Double>
{
    Complex.Number(real: -rhs, imaginary: lhs)
}

@inlinable
public func * (
    lhs: Complex.Real<Double>,
    rhs: Complex.Imaginary<Double>
) -> Complex.Imaginary<Double> {
    Complex.Imaginary(lhs._value * rhs._value)
}

@inlinable
public func * (
    lhs: Complex.Imaginary<Double>,
    rhs: Complex.Real<Double>
) -> Complex.Imaginary<Double> {
    Complex.Imaginary(lhs._value * rhs._value)
}

@inlinable
public func / (
    lhs: Complex.Real<Double>,
    rhs: Complex.Imaginary<Double>
) -> Complex.Imaginary<Double> {
    Complex.Imaginary(-lhs._value / rhs._value)
}

@inlinable
public func / (
    lhs: Complex.Imaginary<Double>,
    rhs: Complex.Real<Double>
) -> Complex.Imaginary<Double> {
    Complex.Imaginary(lhs._value / rhs._value)
}

@inlinable
public func + (lhs: Complex.Real<Float>, rhs: Complex.Imaginary<Float>) -> Complex.Number<Float> {
    Complex.Number(real: lhs, imaginary: rhs)
}

@inlinable
public func + (lhs: Complex.Imaginary<Float>, rhs: Complex.Real<Float>) -> Complex.Number<Float> {
    Complex.Number(real: rhs, imaginary: lhs)
}

@inlinable
public func - (lhs: Complex.Real<Float>, rhs: Complex.Imaginary<Float>) -> Complex.Number<Float> {
    Complex.Number(real: lhs, imaginary: -rhs)
}

@inlinable
public func - (lhs: Complex.Imaginary<Float>, rhs: Complex.Real<Float>) -> Complex.Number<Float> {
    Complex.Number(real: -rhs, imaginary: lhs)
}

@inlinable
public func * (lhs: Complex.Real<Float>, rhs: Complex.Imaginary<Float>) -> Complex.Imaginary<Float>
{
    Complex.Imaginary(lhs._value * rhs._value)
}

@inlinable
public func * (lhs: Complex.Imaginary<Float>, rhs: Complex.Real<Float>) -> Complex.Imaginary<Float>
{
    Complex.Imaginary(lhs._value * rhs._value)
}

@inlinable
public func / (lhs: Complex.Real<Float>, rhs: Complex.Imaginary<Float>) -> Complex.Imaginary<Float>
{
    Complex.Imaginary(-lhs._value / rhs._value)
}

@inlinable
public func / (lhs: Complex.Imaginary<Float>, rhs: Complex.Real<Float>) -> Complex.Imaginary<Float>
{
    Complex.Imaginary(lhs._value / rhs._value)
}
