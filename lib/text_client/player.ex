defmodule TextClient.Player do
  alias TextClient.{Mover, Prompter, State, Summary}

  # won, lost, good guess, bad guess, already used, initializing
  def play(%State{tally: %{game_state: :won}}), do: exit_with_message("You won!")

  def play(%State{tally: %{game_state: :lost} = tally}) do
    exit_with_message("You lost, the word you were looking for was #{tally.game_service.word}")
  end

  def play(%State{tally: %{game_state: :good_guess}} = game) do
    continue_with_message(game, "Good guess!")
  end

  def play(%State{tally: %{game_state: :bad_guess}} = game) do
    continue_with_message(game, "Sorry, that letter is not in the word")
  end

  def play(%State{tally: %{game_state: :already_used}} = game) do
    continue_with_message(game, "You already used that letter")
  end

  def play(%State{} = game), do: continue(game)

  defp continue_with_message(game, message) do
    IO.puts(message)
    continue(game)
  end

  defp continue(game) do
    game
    |> Summary.display()
    |> Prompter.accept_move()
    |> Mover.make_move()
    |> play()
  end

  defp exit_with_message(message) do
    IO.puts(message)
    exit(:normal)
  end
end
