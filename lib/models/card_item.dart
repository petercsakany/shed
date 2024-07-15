class CardItem {
  final String rank;
  final String suit;
  bool isSelected;

  CardItem({
    required this.rank,
    required this.suit,
    this.isSelected = false,
  });

  String get imagePath => 'assets/images/$rank$suit.png';

  @override
  String toString() {
    return '$rank$suit';
  }
}
