#!/usr/local/bin/lua -i
function palindrome(teststring)
  return teststring:lower() == teststring:lower():reverse()
end


function betterPalindrome(testString)
  return palindrome(testString:gsub('[%p%c%s]', ''))
end


function test()
  print("TESTING Palindrome()")
  print(palindrome("test"))
  print(palindrome("step on no pets"))
  print(palindrome("Bananab"))

  print("TESTING betterPalindrome()")
  print(betterPalindrome("test"))
  print(betterPalindrome("s!tep On no _pets"))
  print(betterPalindrome("Ban()ana=b"))
end