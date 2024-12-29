defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck creates a deck with 52 cards" do
    deck = Cards.create_deck()
    assert length(deck) == 52
  end

  test "sum_points sums the points of a hand" do
    hand = [
      %{suit: "Hearts", value: "Ace", points: 11},
      %{suit: "Hearts", value: "King", points: 10}
    ]

    assert Cards.sum_points(hand) == 21
  end

  test "shuffle shuffles the deck" do
    deck = Cards.create_deck()
    shuffled_deck = Cards.shuffle(deck)
    refute deck == shuffled_deck
  end

  test "contains? returns true if the deck contains the card" do
    deck = Cards.create_deck()
    card = %{suit: "Hearts", value: "Ace", points: 11}
    assert Cards.contains?(deck, card) == true
  end

  test "contains? returns false if the deck does not contain the card" do
    deck = Cards.create_deck()
    card = %{suit: "Hearts", value: "Joker", points: 0}
    assert Cards.contains?(deck, card) == false
  end

  test "get_suit_color returns the correct color for a suit" do
    assert Cards.get_suit_color(%{suit: "Hearts"}) == IO.ANSI.red()
    assert Cards.get_suit_color(%{suit: "Diamonds"}) == IO.ANSI.yellow()
    assert Cards.get_suit_color(%{suit: "Clubs"}) == IO.ANSI.color(2, 2, 2)
    assert Cards.get_suit_color(%{suit: "Spades"}) == IO.ANSI.blue()
  end

  test "get_sigil returns the correct sigil for a suit" do
    assert Cards.get_sigil(%{suit: "Hearts"}) == "♥"
    assert Cards.get_sigil(%{suit: "Diamonds"}) == "♦"
    assert Cards.get_sigil(%{suit: "Clubs"}) == "♣"
    assert Cards.get_sigil(%{suit: "Spades"}) == "♠"
  end

  test "card_to_string converts a card to string" do
    card = %{suit: "Hearts", value: "Ace"}
    assert Cards.card_to_string(card) == "Ace of Hearts ♥"
  end

  test "card_to_string converts a card to colored string" do
    card = %{suit: "Hearts", value: "Ace"}
    assert Cards.card_to_string(card, true) == "\e[31mAce of Hearts ♥\e[0m"
  end

  test "deal deals a card from the deck" do
    deck = Cards.create_deck()
    {dealt_card, remaining_deck} = Cards.deal(deck)
    assert length(dealt_card) == 1
    assert length(remaining_deck) == 51
  end
end
