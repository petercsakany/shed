class Card {
  final String rank;
  final String suit;

  Card({required this.rank, required this.suit});

  String get imagePath => 'assets/$rank$suit.svg';

  @override
  String toString() {
    return '$rank of $suit';
  }
}
