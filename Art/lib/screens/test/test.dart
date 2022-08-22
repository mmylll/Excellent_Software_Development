import 'package:flutter/material.dart';

import '../../components/pager.dart';

class TestPage extends StatefulWidget {
  final String title;

  const TestPage({Key? key, required this.title}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int index = 1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            child: Text(
              "$index"
            ),
          ),
          // Pager(total: 16, pageChange: (value) {
          //   setState(() {
          //     index = value;
          //   });
          // },),
        ],
      ),
    );
  }
}