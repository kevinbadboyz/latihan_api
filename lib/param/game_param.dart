class GameParam {
  final String name;
  final String price;

  GameParam({required this.name, required this.price});
  Map<String, dynamic> toJson() {
    return {'name': this.name, 'price': this.price};
  }
}
