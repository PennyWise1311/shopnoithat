import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/filter_model.dart';

class FilterProvider extends ChangeNotifier {
  List<FilterModel> filterList = [];

  Future<void> getListFilter() async {
    List<FilterModel> newList = [];
    await FirebaseFirestore.instance.collection('filter').limit(1).get().then((value) {
      for (var doc in value.docs) {
        var filter = FilterModel(
          category: "",
            price: List.from(doc.data()['Price']),
            color: Map.from(doc.data()['color']),
            material: List.from(doc.data()['material']),
            feature: List.from(doc.data()['feature']),
            idFilter: doc.reference.id,
            popularSearch: List.from(doc.data()['popular_search']),
            priceRange: Map.from(doc.data()['price_range']),
            series: List.from(doc.data()['series']),
            sortBy: List.from(doc.data()['sort_by']),
        );

        newList.add(filter);
      }
    });

    filterList = newList;
    notifyListeners();
  }

  List<FilterModel> get getFilter {
    return filterList;
  }

}