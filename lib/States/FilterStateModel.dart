import 'package:flutter/cupertino.dart';
import 'package:stockmanager/Widgets/ElementListing/Filter.dart';

class FilterStateModel extends ChangeNotifier {
  FilterType filter = FilterType.NONE;
  String searchTerm = "";

  void setFilter(FilterType _filter) {
    this.filter = _filter;
    notifyListeners();
  }

  void setSearchTerm(String _term) {
    this.searchTerm = _term;
    notifyListeners();
  }
}
