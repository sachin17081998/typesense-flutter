// https://github.com/flutter/flutter/issues/43582
// https://stackoverflow.com/questions/57618579/searchdelegate-with-changenotifier-provider
import 'package:flutter/material.dart';
import 'package:typesense_demo/productListData.dart';
import 'package:typesense_demo/searchResultModel.dart';
import 'package:typesense_demo/typesenseSearch.dart';
import 'package:provider/provider.dart';

class MyAppBAr extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBAr({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
            onPressed: () {
              print("hii");
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
            icon: const Icon(Icons.search)),
      ],
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  String sort = '';
  List<Company> matchQuerry = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return ChangeNotifierProvider<MyproductList>(
        create: (context) => MyproductList(),
        child:
            Consumer<MyproductList>(builder: (context, MyproductList, child) {
          MyproductList.doSomething(matchQuerry);
          if (MyproductList.matchQuerry.length == 0) {
            return const Center(
              child: Text("No results"),
            );
          }
          return ListView.builder(
              // itemCount: MyproductList.matchQuerry.length == null
              //     ? 1
              //     : MyproductList.matchQuerry.length + 1,
              itemCount: MyproductList.matchQuerry.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text("sort in ascending"),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Radio(
                                                      value: "ascending",
                                                      groupValue: sort,
                                                      onChanged: (value) {
                                                        sort = value.toString();
                                                        MyproductList.sort(
                                                            sort);
                                                        Navigator.pop(context);
                                                      }),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text("sort in Descending"),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Radio(
                                                      value: "descending",
                                                      groupValue: sort,
                                                      onChanged: (value) {
                                                        sort = value.toString();

                                                        MyproductList.sort(
                                                            sort);
                                                        Navigator.pop(context);
                                                      }),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ));
                              },
                              child: const Text('Sort')),
                          TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                        backgroundColor: Colors.orangeAccent,
                                        child: Container(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            children: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Cancel"))
                                            ],
                                          ),
                                        )));
                              },
                              child: const Text('Filter')),
                        ],
                      ),
                    ],
                  );
                }
                index -= 1;
                var result = MyproductList.matchQuerry[index];

                return ListTile(
                  title: Text(result.name +
                      " " +
                      result.country +
                      " " +
                      result.empCount.toString()),
                );
              });
        }));
  }

//
  @override
  Widget buildSuggestions(BuildContext context) {
    return ChangeNotifierProvider<MyproductList>(
        create: (context) => MyproductList(),
        child:
            Consumer<MyproductList>(builder: (context, MyproductList, child) {
          // MyproductList.search(query);
          matchQuerry = MyproductList.search(query);
          return ListView.builder(
              itemCount: matchQuerry.length,
              itemBuilder: (context, index) {
                var result = matchQuerry[index];

                return ListTile(
                  title: Text(result.name),
                );
              });
        }));
  }
//
}

Widget listViewWidget(List<Company> companies) {
  return Container(
    child: ListView.builder(
        itemCount: companies.length,
        padding: const EdgeInsets.all(2.0),
        itemBuilder: (context, position) {
          return Card(
            child: ListTile(
              title: Text(
                companies[position].name,
                style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  child: Text(companies[position].country),
                  height: 100.0,
                  width: 100.0,
                ),
              ),
            ),
          );
        }),
  );
}
