defmodule Day5 do

  def contains(e1, e2) do
    st1 = Enum.at(e1, 0) |> String.to_integer()
    end1 = Enum.at(e1, 1) |> String.to_integer()
    st2 = Enum.at(e2, 0) |> String.to_integer()
    end2 = Enum.at(e2, 1) |> String.to_integer()
    cond do
      st1 in st2..end2 or end1 in st2..end2 -> true
      st2 in st1..end1 or end2 in st1..end1 -> true
      true -> false
    end
  end

  def contains_fully(s, acc) do
    [e1, e2] = s |> String.split(",") |> Enum.map(&(String.split(&1, "-")))
    case contains(e1, e2) do
      true -> IO.puts(s)
              1 + acc
      false -> 0 + acc
    end
  end

  def main() do
    input = File.read!("input.txt")
    test = "2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8"

    input
    |> String.split("\r\n", trim: true)
    |> Enum.reduce(0, &(contains_fully(&1, &2)))
    #|> Enum.chunk_every(3) |> Enum.map(&(get_prio_value.(&1))) |> List.flatten() |> Enum.sum()
    end
end
