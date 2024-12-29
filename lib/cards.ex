defmodule Cards do
  @moduledoc """
  Documentation for `Cards`.
  """

  @doc """
  Creates a deck of cards. Each card is a map with the following
  keys: `:
  suit`, `:value`, and `:points`.
  """
  def create_deck do
    suits = ["Hearts", "Diamonds", "Clubs", "Spades"]
    values = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"]

    black_jack_points = %{
      "2" => 2,
      "3" => 3,
      "4" => 4,
      "5" => 5,
      "6" => 6,
      "7" => 7,
      "8" => 8,
      "9" => 9,
      "10" => 10,
      "Jack" => 10,
      "Queen" => 10,
      "King" => 10,
      "Ace" => 11
    }

    for suit <- suits, value <- values do
      %{suit: suit, value: value, points: black_jack_points[value]}
    end
  end

  @doc """

  Sums the points of a hand.

  ## Examples

      iex> Cards.sum_points([%{suit: "Hearts", value: "Ace", points: 11}, %{suit: "Hearts", value: "King", points: 10}])
      21

  """
  def sum_points(hand) do
    Enum.reduce(hand, 0, fn card, acc -> acc + card.points end)
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  Returns true if the deck contains the card, false otherwise.

  ## Examples
      iex> deck = Cards.create_deck()
      iex> Cards.contains?(deck, %{suit: "Hearts", value: "Ace", points: 11})
      true
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
  Returns the color for a given suit in ANSI format.

  ## Examples
      iex> Cards.get_suit_color(%{suit: "Hearts"})
      "\e[31m"
  """

  def get_suit_color(%{suit: suit}) do
    case suit do
      "Hearts" -> IO.ANSI.red()
      "Diamonds" -> IO.ANSI.yellow()
      "Clubs" -> IO.ANSI.color(2, 2, 2)
      "Spades" -> IO.ANSI.blue()
    end
  end

  @doc """
  Returns the unicode sigil for a given suit.

  ## Examples
      iex> Cards.get_sigil(%{suit: "Hearts"})
      "♥"
  """
  def get_sigil(%{suit: suit}) do
    case suit do
      "Hearts" -> "♥"
      "Diamonds" -> "♦"
      "Clubs" -> "♣"
      "Spades" -> "♠"
    end
  end

  @doc """
  Converts a card to string.
  ## Examples
      iex> Cards.card_to_string(%{suit: "Hearts", value: "Ace", points: 11})
      "Ace of Hearts ♥"
  """
  def card_to_string(%{suit: suit, value: value}) do
    "#{value} of #{suit}" <>
      " #{get_sigil(%{suit: suit})}"
  end

  @doc """
  Converts a card to colored string.

  ## Examples
      iex> Cards.card_to_string(%{suit: "Hearts", value: "Ace"}, true)
      "\e[31mAce of Hearts ♥\e[0m"
  """
  def card_to_string(%{suit: suit, value: value}, colored) do
    cond do
      colored ->
        get_suit_color(%{suit: suit}) <>
          "#{value} of #{suit}" <>
          " #{get_sigil(%{suit: suit})}" <> IO.ANSI.reset()

      true ->
        "#{value} of #{suit}" <>
          " #{get_sigil(%{suit: suit})}"
    end
  end

  @doc """
  Deals a card from the deck.

  ## Examples
      iex> deck = Cards.create_deck()
      iex> Cards.deal(deck)
      {
              [%{points: 2, suit: "Hearts", value: "2"}],
              [
                %{points: 3, suit: "Hearts", value: "3"},
                %{value: "4", suit: "Hearts", points: 4},
                %{value: "5", suit: "Hearts", points: 5},
                %{value: "6", suit: "Hearts", points: 6},
                %{value: "7", suit: "Hearts", points: 7},
                %{value: "8", suit: "Hearts", points: 8},
                %{value: "9", suit: "Hearts", points: 9},
                %{value: "10", suit: "Hearts", points: 10},
                %{value: "Jack", suit: "Hearts", points: 10},
                %{value: "Queen", suit: "Hearts", points: 10},
                %{value: "King", suit: "Hearts", points: 10},
                %{value: "Ace", suit: "Hearts", points: 11},
                %{value: "2", suit: "Diamonds", points: 2},
                %{value: "3", suit: "Diamonds", points: 3},
                %{value: "4", suit: "Diamonds", points: 4},
                %{value: "5", suit: "Diamonds", points: 5},
                %{value: "6", suit: "Diamonds", points: 6},
                %{value: "7", suit: "Diamonds", points: 7},
                %{value: "8", suit: "Diamonds", points: 8},
                %{value: "9", suit: "Diamonds", points: 9},
                %{value: "10", suit: "Diamonds", points: 10},
                %{value: "Jack", suit: "Diamonds", points: 10},
                %{value: "Queen", suit: "Diamonds", points: 10},
                %{value: "King", suit: "Diamonds", points: 10},
                %{value: "Ace", suit: "Diamonds", points: 11},
                %{value: "2", suit: "Clubs", points: 2},
                %{value: "3", suit: "Clubs", points: 3},
                %{value: "4", suit: "Clubs", points: 4},
                %{value: "5", suit: "Clubs", points: 5},
                %{value: "6", suit: "Clubs", points: 6},
                %{value: "7", suit: "Clubs", points: 7},
                %{value: "8", suit: "Clubs", points: 8},
                %{value: "9", suit: "Clubs", points: 9},
                %{value: "10", suit: "Clubs", points: 10},
                %{value: "Jack", suit: "Clubs", points: 10},
                %{value: "Queen", suit: "Clubs", points: 10},
                %{value: "King", suit: "Clubs", points: 10},
                %{value: "Ace", suit: "Clubs", points: 11},
                %{value: "2", suit: "Spades", points: 2},
                %{value: "3", suit: "Spades", points: 3},
                %{value: "4", suit: "Spades", points: 4},
                %{value: "5", suit: "Spades", points: 5},
                %{value: "6", suit: "Spades", points: 6},
                %{value: "7", suit: "Spades", points: 7},
                %{value: "8", suit: "Spades", points: 8},
                %{value: "9", suit: "Spades", points: 9},
                %{value: "10", suit: "Spades", points: 10},
                %{value: "Jack", suit: "Spades", points: 10},
                %{value: "Queen", suit: "Spades", points: 10},
                %{value: "King", suit: "Spades", points: 10},
                %{value: "Ace", suit: "Spades", points: 11}
              ]
            }
  """
  def deal(deck) do
    Enum.split(deck, 1)
  end
end
