defmodule TextClient.Summary do
  alias TextClient.State

  def display(%State{tally: tally} = game) do
    IO.puts([
      "\n",
      "Word: #{Enum.join(tally.letters, " ")}\n",
      "Guesses left: #{tally.turns_left}\n"
    ])

    game
  end
end
