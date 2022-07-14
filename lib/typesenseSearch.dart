import 'package:typesense/typesense.dart';
import 'package:typesense_demo/searchResultModel.dart';

class SearchInstance {
  late final config;
  late final client;

  //constructor to initilize client
  SearchInstance() {
    config = Configuration(
      'qqjem2zJor9qjem2Y7U2ke7LB', //api key from text file
      nodes: {
        Node(
          Protocol.https, // For Typesense Cloud use https
          "df2ewureufyo6p-1.a1.typesense.net", // For Typesense Cloud use xxx.a1.typesense.net
          port: 443, // For Typesense Cloud use 443
        ),
      },
      connectionTimeout: Duration(seconds: 20),
    );
    client = Client(config);
  }

  //function to search
  Future<List<Company>> searchForData(String data) async {
    List<Company> companylist = [];
    final searchParameters = {
      'q': data,
      'query_by': 'company_name',
      'filter_by': 'num_employees:>1',
      'sort_by': 'num_employees:desc'
    };
    try {
      var result = await client
          .collection('companies')
          .documents
          .search(searchParameters);

      // print(result);
      var data = result["hits"];
      for (var documents in data) {
        var x = documents["document"];
        Company obj = Company(
            id: x["id"],
            name: x["company_name"],
            country: x["country"],
            empCount: x["num_employees"]);

        companylist.add(obj);
      }
      return companylist;
    } catch (e) {
      print("ERROR while SEARCH=$e");
      return companylist;
    }
  }
}
