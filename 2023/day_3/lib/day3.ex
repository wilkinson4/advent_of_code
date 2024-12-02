defmodule Day3 do
  @moduledoc false

  # Stopping because I spent too much time on part 3
  def solve_part_1 do
    schematic_enum =
      File.read!("./input.txt")
      |> String.split("\n", trim: true)
      |> Enum.with_index()

    schematic_enum
    |> Enum.map(fn {line, index} ->
      keep_valid_part_numbers(
        Enum.at(schematic_enum, index - 1),
        line,
        Enum.at(schematic_enum, index + 1)
      )
    end)
  end

  defp keep_valid_part_numbers(nil, current_line, next_line) do
    current_line_split = String.split(current_line, "", trim: true) |> Enum.with_index()

    start_index_to_remove =
      Enum.find_index(current_line_split, fn {current_char, current_index} ->
        previous_char = Enum.at(current_line_split, current_index - 1)

        if is_digit(current_char) and is_nil(previous_char) do
          # find end of part number index
          end_of_part_number_index =
            Enum.find_index(current_line_split, fn {char, i} ->
              i >= current_index and not is_digit(char)
            end) - 1

          is_symbol(String.at(current_line, current_index - 1) || ".") or
            is_symbol(String.at(current_line, current_index + 1)) or
            is_symbol(String.at(next_line, current_index - 1)) or
            is_symbol(String.at(next_line, current_index)) or
            is_symbol(String.at(next_line, current_index + 1))
        end
      end)
  end

  defp is_digit(char_str) do
    if char_str in Enum.map([0..9], &to_string/1) do
      true
    else
      false
    end
  end

  defp is_not_dot(char_str), do: char_str != "."

  defp is_symbol(char_str), do: not is_digit(char_str) and is_not_dot(char_str)
end
