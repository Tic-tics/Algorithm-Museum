--almost fulfills 5.5
--technically does 2*n multiplications
function polynomialEval(x, poly)
  value = poly[0] or 0
  currentEXP = 1
  for exponent, coeficent in ipairs(poly) do
    currentEXP = currentEXP * x
    value = value + (coeficent * currentEXP)
  end
  return value
end

print(polynomialEval(2,{[0]=2,1,1}))
print(polynomialEval(5,{[0]=5}))