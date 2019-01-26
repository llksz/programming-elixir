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


  def all?(list, func \\ fn x -> x end)
  def all?([], _), do: true
  def all?([head | tail], func) do
    if func.(head) do
      all?(tail, func)
    else
      false
    end
  end


  def each([], _), do: :ok
  def each([head | tail], func) do
    func.(head)
    each(tail, func)
  end


  def filter(list, pred) do
    reduce(list, [], fn x, acc -> if pred.(x) do acc ++ [x] else acc end end)
  end


  def reverse([]), do: []
  def reverse([head | tail]), do: reverse(tail) ++ [head]


  def split(list, count) when count >= 0 do
    split(list, count, [])
  end

  def split(list, count) when count < 0 do
    split_reverse(reverse(list), -count, [])
  end


  defp split([head | tail], count, acc) when count > 0 do
    split(tail, count - 1, [head | acc])
  end

  defp split(list, 0, acc) do
    {reverse(acc), list}
  end

  defp split([], _, acc) do
    {reverse(acc), []}
  end


  defp split_reverse([head | tail], count, acc) when count > 0 do
    split_reverse(tail, count - 1, [head | acc])
  end

  defp split_reverse(list, 0, acc) do
    {reverse(list), acc}
  end

  defp split_reverse([], _, acc) do
    {[], acc}
  end

  
  def take(list, count) when count < 0 do
    reverse(take(reverse(list), -count))
  end

  def take([], _) do
    []
  end

  def take(_, 0) do
    []
  end

  def take([head | tail], count) do
    [head | take(tail, count - 1)]
  end


  def flatten(list) when is_list(list) do
    flatten(list, [])
  end


  defp flatten([head | tail0], tail1) when is_list(head) do
    flatten(head, flatten(tail0, tail1))
  end

  defp flatten([head | tail0], tail1) do
    [head | flatten(tail0, tail1)]
  end

  defp flatten([], tail) do
    tail
  end


  def primes(n) when n > 1 do
    filter(span(2, n + 1), &isPrime?/1)
  end


  defp isPrime?(n) do
    all?((for x <- span(2, n), do: rem(n, x)), &(&1 != 0))
  end

end
