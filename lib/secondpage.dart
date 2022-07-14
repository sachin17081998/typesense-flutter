import 'package:flutter/material.dart';
import 'package:typesense_demo/appbar.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBAr(),
      body: Container(
        child: const Text(" wlcome to second page"),
      ),
    );
  }
}
