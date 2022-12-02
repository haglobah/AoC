defmodule AoC2 do

  def main() do
    input = File.read!("input2.txt")
    test = "A X\nB Y\nC Z"

    calc_result1 = fn
      "A X" -> 3 + 1
      "A Y" -> 6 + 2
      "A Z" -> 0 + 3

      "B X" -> 0 + 1
      "B Y" -> 3 + 2
      "B Z" -> 6 + 3

      "C X" -> 6 + 1
      "C Y" -> 0 + 2
      "C Z" -> 3 + 3
    end

    calc_result2 = fn
      "A X" -> 0 + 3
      "A Y" -> 3 + 1
      "A Z" -> 6 + 2

      "B X" -> 0 + 1
      "B Y" -> 3 + 2
      "B Z" -> 6 + 3

      "C X" -> 0 + 2
      "C Y" -> 3 + 3
      "C Z" -> 6 + 1
    end

    input |> String.split("\r\n", trim: true) |> Enum.map(&(calc_result2.(&1))) |> Enum.sum()
  end
end
