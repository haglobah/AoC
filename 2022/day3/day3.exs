defmodule Day3 do

  def main() do
    input = File.read!("input3.txt")
    test = "AjlkaQwErk\r\nuipohyxcvh\r\n"
    test2 = "vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw"

    num = fn
       [c] when c >= 97 and c <= 122 -> c - 96
       [c] when (c >= 65) and (c <= 90) -> c - 38
    end

    get_same = fn s1, s2 ->
      MapSet.intersection(MapSet.new(s1), MapSet.new(s2))
      |> MapSet.to_list |> Enum.map(&(num.(to_char_list(&1))))
      #|> &(num.(&1))
    end

    get_prio_value = fn s ->
      len = String.length(s)
      comps = s |> String.split_at(trunc(len/2))
      |> Tuple.to_list()
      |> Enum.map(&(String.graphemes(&1) |> MapSet.new()))

      get_same.(Enum.at(comps, 0), Enum.at(comps, 1))
      #|> Enum.map(&(get_elem_value()))
    end

    input
    |> String.split("\r\n", trim: true)
    |> Enum.chunk_every(3)
    |> Enum.map(&(get_prio_value.(&1))) |> List.flatten() |> Enum.sum()
    end
end
