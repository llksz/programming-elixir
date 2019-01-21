defmodule Chop do
 
  def guess(actual, lower .. upper) when lower <= upper and actual in lower .. upper do
    current = mid(lower, upper)
    IO.puts("Is it #{current}")
    guess_helper(actual, lower .. upper, current)
  end

  
  defp guess_helper(actual, _, actual) do
    IO.puts actual
  end
  
  defp guess_helper(actual, lower .. _, current) when current > actual do
    guess(actual, lower .. current - 1)
  end
  
  defp guess_helper(actual, _ .. upper, current) when current < actual do
    guess(actual, current + 1 .. upper)
  end

  
  defp mid(lower, upper) do
    lower + div(upper - lower, 2)
  end

end