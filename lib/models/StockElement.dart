class StockElement {
  int id;
  String type;
  String name;
  String provider;
  int quantity;
  double unitPrice;
  String location;
  String? createdAt;
  String? updatedAt;

  StockElement({
    required this.id,
    required this.type,
    required this.name,
    required this.provider,
    required this.quantity,
    required this.unitPrice,
    required this.location,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, String?> toJSON() {
    return {
      "id": this.id.toString(),
      "type": this.type,
      "name": this.name,
      "provider": this.provider,
      "quantity": this.quantity.toString(),
      "unitPrice": this.unitPrice.toString(),
      "location": this.location,
      "createdAt": this.createdAt.toString(),
      "updatedAt": this.updatedAt.toString()
    };
  }

  static StockElement fromJSON(json) {
    if (json['createdAt'] != null) {
      return StockElement(
        id: int.parse(json['id'].toString()),
        type: json['type'],
        name: json['name'],
        provider: json['provider'],
        quantity: int.parse(json['quantity'].toString()),
        unitPrice: double.parse(json['unitPrice'].toString()),
        location: json['location'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
      );
    } else {
      return StockElement(
        id: int.parse(json['id'].toString()),
        type: json['type'],
        name: json['name'],
        provider: json['provider'],
        quantity: int.parse(json['quantity'].toString()),
        unitPrice: double.parse(json['unitPrice'].toString()),
        location: json['location'],
      );
    }
  }
}
