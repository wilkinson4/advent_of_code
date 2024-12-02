defmodule Day4 do
  @moduledoc false

  def solve_part_1 do
    File.read!("./input.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      Regex.replace(~r"Card\s\d+:\s+", line, "")
      |> String.split("|", trim: true)
      |> Enum.map(&String.split(&1, " ", trim: true))
    end)
    |> Enum.reduce(0, fn card, acc ->
      winning_numbers = Enum.at(card, 0)
      numbers = Enum.at(card, 1)

      calculate_points(winning_numbers, numbers) + acc
    end)
  end

  defp calculate_points(winning_numbers, numbers) do
    Enum.filter(numbers, fn num ->
      Enum.any?(winning_numbers, fn win_num -> win_num == num end)
    end)
    |> then(fn found_win_nums ->
      if Enum.empty?(found_win_nums) do
        0
      else
        Enum.reduce(found_win_nums, 0, fn _, acc ->
          if acc == 0 do
            1
          else
            acc * 2
          end
        end)
      end
    end)
  end

  def solve_part_2 do
    original =
      File.read!("./input.txt")
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        Regex.replace(~r"Card\s+\d+:\s+", line, "")
        |> String.split("|", trim: true)
        |> Enum.map(&String.split(&1, " ", trim: true))
      end)
      |> Enum.with_index()

    original
    |> Enum.reduce_while(original, fn {card, current_index}, orig_acc ->
      if current_index == Enum.count(original) - 1 do
        {:halt, orig_acc}
      else
        wins = find_wins(card)
        num_wins = Enum.count(wins)

        indexes = (current_index + 1)..(current_index + num_wins + 1)

        additional_cards =
          Enum.reduce_while(wins, wins, fn {_, i}, acc ->
            card
            |> Enum.at(i)
            |> find_wins()
            |> extract_winning_cards(indexes)
            |> process_winning_cards()
            |> case do
              [] -> {:halt, []}
              wins -> {:cont, acc ++ wins}
            end
          end)

        orig_acc ++ additional_cards
      end
    end)
    |> IO.inspect()
    |> Enum.count()
  end

  defp find_wins(card) do
    winning_numbers = Enum.at(card, 0)
    numbers = Enum.at(card, 1)

    Enum.filter(numbers, fn num ->
      Enum.any?(winning_numbers, fn win_num -> win_num == num end)
    end)
  end

  defp extract_winning_cards(wins, indexes) do
    Enum.filter(wins, fn {_num, index} ->
      Enum.any?(indexes, fn i ->
        i == index
      end)
    end)
  end

  defp process_winning_cards(winning_cards) do
    if Enum.empty?(winning_cards) do
      []
    else
      Enum.reduce_while(winning_cards, winning_cards, fn {card, index}, acc ->
        wins = find_wins(card)
        num_wins = Enum.count(wins)

        indexes = (index + 1)..(index + num_wins + 1)

        additional_cards =
          wins
          |> extract_winning_cards(indexes)
          |> process_winning_cards()

        acc ++ additional_cards
      end)
    end
  end
end
