f = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, x -> x
end

fizzbuzz = fn n -> f.(rem(n, 3), rem(n, 5), n) end
