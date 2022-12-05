defmodule Day3 do

  def char_to_prio([c]) when c >= 97 and c <= 122 do c - 96 end
  def char_to_prio([c]) when c >= 65 and c <= 90 do c - 38 end

  def get_same_prio() do end
  def main() do
    input = File.read!("input.txt")
    test = "AjlkaQwErk\r\nuipohyxcvh\r\n"
    test2 = "vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw"

    get_same = fn r1, r2, r3 ->
      MapSet.intersection(MapSet.new(r1), MapSet.intersection(MapSet.new(r2), MapSet.new(r3)))
      |> MapSet.to_list |> Enum.map(&(char_to_prio(to_charlist(&1))))
      #|> &(num.(&1))
    end

    get_prio_value = fn rucksacks ->
      comps = rucksacks |> Enum.map(&(String.graphemes(&1) |> MapSet.new()))

      get_same.(Enum.at(comps, 0), Enum.at(comps, 1), Enum.at(comps, 2))
      #|> Enum.map(&(get_elem_value()))
    end

    input
    |> String.split("\r\n", trim: true)
    |> Enum.chunk_every(3)
    |> Enum.map(&(get_prio_value.(&1))) |> List.flatten() |> Enum.sum()
    end
end
