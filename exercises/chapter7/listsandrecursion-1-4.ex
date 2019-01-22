defmodule MyList do
  
  def map([], _func), do: []
  def map([head | tail], func), do: [func.(head) | map(tail, func)]

  def reduce([], value, _func), do: value
  def reduce([head | tail], value, func) do
    reduce(tail, func.(head, value), func)
  end

  def mapsum(list, func) do
    list
      |> map(func)
      |> reduce(0, &(&1 + &2))
  end

  def max(list) when length(list) > 0 do
    [head | tail] = list
    reduce(tail, head, &max/2)
  end

  def caesar(list, n) do
    map(list, shift(n))
  end

  defp shift(n) do
    fn
      c when c + n > 122 -> c + n - 26
      c -> c + n
    end
  end

  def span(from, to) when from > to, do: raise "from must be <= to"
  def span(to, to), do: []
  def span(from, to) when from < to, do: [from | span(from + 1, to)]

end