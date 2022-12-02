defmodule Main do

	def main() do
		s = File.read!("input1.txt")
		sum_bags = fn (s) ->
					s
					|> String.split("\r\n", trim: true)
					|> Enum.map(&(String.to_integer(&1)))
					|> Enum.sum()
		end
		s |> String.split("\r\n\r\n")
		|> Enum.map(&(sum_bags.(&1)))
		|> Enum.sort(&(&1 >= &2))
		|> Enum.take(3)
		|> Enum.sum()
	end

end
