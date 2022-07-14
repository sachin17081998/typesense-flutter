import 'package:flutter/material.dart';
import 'package:typesense_demo/searchResultModel.dart';
import 'package:typesense_demo/typesenseSearch.dart';

class MyproductList with ChangeNotifier {
  List<Company> matchQuerry = [];
  void setData(List<Company> x) {
    matchQuerry = x;
  }

  void doSomething(List<Company> x) {
    matchQuerry = x;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  Future<List<Company>> returnList() async {
    return await matchQuerry;
  }

  void sort(String sort) {
    if (sort == "descending") {
      matchQuerry.sort((b, a) => a.empCount.compareTo(b.empCount));
    } else {
      matchQuerry.sort((a, b) => a.empCount.compareTo(b.empCount));
    }
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    notifyListeners();
    // });
  }

  List<Company> search(String query) {
    final search = SearchInstance();
    search.searchForData(query).then((value) {
      matchQuerry = value as List<Company>;
    });
    return matchQuerry;
  }
}
