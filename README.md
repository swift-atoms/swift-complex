
Scalar and componentwise closeness use Tolerance's validated absolute/relative allowances. Equal infinities match; NaN and unequal infinities do not. Invalid allowances return false through the existing nonthrowing convenience APIs. Closeness does not define hash identity or Equatable conformance.
