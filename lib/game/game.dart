class Card {
  String value;
  bool flipped;
  bool found;
  Card({required this.value, required this.flipped, required this.found});
}

class Game {
  final String questionBox = 'lib/images/0.png';
  final int cardCount = 12;
  List<Card> cards = [];
  List<int> cardsIndx = [];
  int clicks = 0;

  void initGame() {
    clicks = 0;
    cards = shuffledCards();
    cardsIndx = [];
  }

  List<Card> shuffledCards() {
    List<Card> allCards = [];
    for (var i = 1; i <= 11; i++) {
      Card card =
          Card(value: 'lib/images/${i}.png', flipped: false, found: false);
      allCards.add(card);
    }
    allCards.shuffle();
    List<Card> cards = [];
    for (var i = 0; i <= 5; i++) {
      Card card = Card(
          value: allCards.elementAt(i).value, flipped: false, found: false);
      cards.add(card);
    }
    for (var i = 0; i <= 5; i++) {
      Card card =
          Card(value: cards.elementAt(i).value, flipped: false, found: false);
      cards.add(card);
    }
    cards.shuffle();
    return cards;
  }
}
