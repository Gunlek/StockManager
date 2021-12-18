class StockElement {
  final int id;
  final String type;
  final String name;
  final String provider;
  final int quantity;
  final double unitPrice;
  final String location;
  final String createdAt;
  final String updatedAt;

  StockElement(this.id, this.type, this.name, this.provider, this.quantity,
      this.unitPrice, this.location, this.createdAt, this.updatedAt);

  static StockElement fromJSON(json) {
    return StockElement(
      json['id'],
      json['type'],
      json['name'],
      json['provider'],
      json['quantity'],
      json['unitPrice'],
      json['location'],
      json['createdAt'],
      json['updatedAt'],
    );
  }
}
