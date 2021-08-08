class StockElement {
  final int id;
  final String type;
  final String name;
  final String provider;
  final int quantity;
  final double unitPrice;
  final String location;

  StockElement(this.id, this.type, this.name, this.provider, this.quantity,
      this.unitPrice, this.location);

  static StockElement fromJSON(json) {
    return StockElement(
      json['id'],
      json['type'],
      json['name'],
      json['provider'],
      json['quantity'],
      json['unitPrice'],
      json['location'],
    );
  }
}
