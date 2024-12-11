class GameModel {
  final int id;
  final String name;
  final String price;
  final String status;

  GameModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.status});
  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        status: json['status']);
  }

  String toString() {
    return '${this.id} ${this.name} ${this.price} ${this.status}';
  }
}
