function palindrome(teststring)
  return teststring:lower() == teststring:lower():reverse()
end

print(palindrome("test"))
print(palindrome("step on no pets"))
print(palindrome("Bananab"))

function betterPalindrome(testString)
  return palindrome(testString:gsub('[%p%c%s]', ''))
end

print(betterPalindrome("test"))
print(betterPalindrome("s!tep On no _pets"))
print(betterPalindrome("Ban()ana=b"))