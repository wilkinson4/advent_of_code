defmodule Day2 do
  @moduledoc false

  def solve_part_1 do
    File.read!("./day_2_part_1.txt")
    |> String.split("\n", trim: true)
    |> Enum.filter(fn game_str ->
      blue_regex = ~r"(\d+)\sblue"
      red_regex = ~r"(\d+)\sred"
      green_regex = ~r"(\d+)\sgreen"

      game_possible?(blue_regex, game_str, 14) and game_possible?(red_regex, game_str, 12) and
        game_possible?(green_regex, game_str, 13)
    end)
    |> Enum.reduce(0, fn game_str, acc ->
      game_number =
        Regex.scan(~r"(\d+):", game_str)
        |> List.flatten()
        |> Enum.at(1)
        |> String.to_integer()

      acc + game_number
    end)
    |> IO.puts()
  end

  defp game_possible?(regex, game_str, max_dice) do
    regex
    |> Regex.scan(game_str)
    |> Enum.map(fn [_, match] -> match end)
    |> Enum.all?(fn num_dice -> String.to_integer(num_dice) <= max_dice end)
  end

  def solve_part_2 do
    File.read!("./day_2_part_1.txt")
    |> String.replace(~r"Game \d+:\s", "")
    |> String.split("\n", trim: true)
    |> Enum.reduce(0, fn game_str, acc ->
      max_red = get_max_color(game_str, "red")
      max_green = get_max_color(game_str, "green")
      max_blue = get_max_color(game_str, "blue")

      acc + max_red * max_green * max_blue
    end)
    |> IO.puts()
  end

  defp get_max_color(game_str, color) do
    Regex.compile!("(\\d+)\\s#{color}")
    |> Regex.scan(game_str)
    |> Enum.map(fn [_, match] -> String.to_integer(match || "1") end)
    |> Enum.max()
  end
end
