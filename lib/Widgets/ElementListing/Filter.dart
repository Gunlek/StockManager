enum FilterType {
  NONE,
  TYPE,
  NAME,
  PROVIDER,
  QUANTITY,
  UNIT_PRICE,
  LOCATION,
}

enum FilterOrder {
  NONE,
  ASC,
  DESC,
}

class Filter {
  final FilterType type;
  final FilterOrder order;

  static Filter noFilter = Filter(FilterType.NONE, FilterOrder.NONE);

  Filter(this.type, this.order);
}
