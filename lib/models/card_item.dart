class CardItem {
  final String rank;
  final String suit;

  CardItem({required this.rank, required this.suit});

  String get imagePath => 'assets/images/$rank$suit.png';

  @override
  String toString() {
    return '$rank$suit';
  }
}
