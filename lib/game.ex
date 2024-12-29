defmodule Game do
  alias Cards

  @doc """
  Entry point for the game.
  """
  def start_game do
    IO.puts("Welcome to Blackjack!")

    deck = Cards.create_deck() |> Cards.shuffle()
    {player_hand, deck} = draw_initial_hand(deck)
    {dealer_hand, deck} = draw_initial_hand(deck)

    IO.puts("\nDealer's visible card:")
    visible_card = List.first(dealer_hand)
    IO.puts(Cards.card_to_string(visible_card, true))
    IO.puts("Dealer's visible total: #{visible_card.points}")

    play_game(player_hand, dealer_hand, deck)
  end

  defp draw_initial_hand(deck) do
    Enum.split(deck, 2)
  end

  defp play_game(player_hand, dealer_hand, deck) do
    IO.puts("\nYour hand:")
    Enum.each(player_hand, &IO.puts(Cards.card_to_string(&1, true)))
    IO.puts("Your total: #{Cards.sum_points(player_hand)}")

    case player_turn(player_hand, deck) do
      {:bust, _player_hand} ->
        IO.puts("You busted! Dealer wins.")

      {:continue, player_hand, deck} ->
        dealer_hand = dealer_turn(dealer_hand, deck)
        determine_winner(player_hand, dealer_hand)
    end
  end

  defp player_turn(player_hand, deck) do
    IO.puts("\nWhat would you like to do? (hit/stand)")

    case IO.gets("") |> String.trim() do
      "hit" ->
        {card, deck} = Cards.deal(deck)
        player_hand = player_hand ++ card
        IO.puts("You drew: #{Cards.card_to_string(List.first(card), true)}")

        if Cards.sum_points(player_hand) > 21 do
          {:bust, player_hand}
        else
          player_turn(player_hand, deck)
        end

      "stand" ->
        {:continue, player_hand, deck}

      _ ->
        IO.puts("Invalid choice, please type 'hit' or 'stand'.")
        player_turn(player_hand, deck)
    end
  end

  defp dealer_turn(dealer_hand, deck) do
    IO.puts("\nDealer's turn...")
    IO.puts("Dealer's hand:")
    Enum.each(dealer_hand, &IO.puts(Cards.card_to_string(&1, true)))

    while_dealer_hits(dealer_hand, deck)
  end

  defp while_dealer_hits(dealer_hand, deck) do
    if Cards.sum_points(dealer_hand) < 17 do
      {card, deck} = Cards.deal(deck)
      dealer_hand = dealer_hand ++ card
      IO.puts("Dealer drew: #{Cards.card_to_string(List.first(card), true)}")
      while_dealer_hits(dealer_hand, deck)
    else
      dealer_hand
    end
  end

  defp determine_winner(player_hand, dealer_hand) do
    player_score = Cards.sum_points(player_hand)
    dealer_score = Cards.sum_points(dealer_hand)

    IO.puts("\nFinal results:")
    IO.puts("Your hand:")
    Enum.each(player_hand, &IO.puts(Cards.card_to_string(&1, true)))
    IO.puts("Your total: #{player_score}")

    IO.puts("Dealer's hand:")
    Enum.each(dealer_hand, &IO.puts(Cards.card_to_string(&1, true)))
    IO.puts("Dealer's total: #{dealer_score}")

    cond do
      player_score > 21 -> IO.puts("You busted! Dealer wins.")
      dealer_score > 21 -> IO.puts("Dealer busted! You win.")
      player_score > dealer_score -> IO.puts("You win!")
      player_score < dealer_score -> IO.puts("Dealer wins!")
      true -> IO.puts("It's a tie!")
    end
  end
end
