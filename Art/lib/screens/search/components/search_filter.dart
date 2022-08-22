import 'package:flutter/material.dart';

class SearchFilter extends StatefulWidget {
  SearchFilter({Key? key,required this.pageChange}) : super(key: key);

  ValueChanged pageChange;   // 回调

  @override
  _SearchFilterState createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {

  int groupValue = 0;
  int sex = 1;

  List _sortStatus = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @override
  Widget build(BuildContext context) {
    final AlertDialog dialog = AlertDialog(
      title: const Text('Sort'),
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
              'None',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: shrineBrown900),
            ),
            leading: Radio(
              toggleable: true,
              value: 0,
              groupValue: groupValue,
              onChanged: (value) {
                setState(() {
                  groupValue = value as int;
                });
              },

            ),
          ),
          ListTile(
            title: Text(
              'Art Visits',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: shrineBrown900),
            ),
            leading: Radio(
              value: 1,
              groupValue: groupValue,
              onChanged: (value) {
                setState(() {
                  groupValue = value as int;
                });
              },

            ),
          ),
          ListTile(
            title: Text(
              'Name',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: shrineBrown900),
            ),
            leading: Radio(
              value: 2,
              groupValue: groupValue,
              onChanged: (value) {
                setState(() {
                  groupValue = value as int;
                });
              },
            ),
          ),
          ListTile(
            title: Text(
              'Price',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: shrineBrown900),
            ),
            leading: Radio(
              value: 3,
              groupValue: groupValue,
              onChanged: (value) {
                setState(() {
                  groupValue = value as int;
                });
              },
            ),
          ),
        ],
      ),
      actions: [
        FlatButton(
          textColor: shrineBrown900,
          onPressed: () => {
            print("aaaaaaaaaaaaa"),
            print(groupValue),
            widget.pageChange(groupValue),
            Navigator.pop(context),
          },
          child: const Text('APPLY'),
        ),
        FlatButton(
          textColor: shrineBrown900,
          onPressed: () => Navigator.pop(context),
          child: const Text('CANCEL'),
        ),
      ],
    );

    return dialog;

    return Scaffold(
      body: Center(
        child: FlatButton(
          onPressed: () {
            showDialog<void>(context: context, builder: (context) => dialog);
          },
          child: Text("SHOW DIALOG"),
        ),
      ),
    );
  }

}

const Color shrinePink50 = Color(0xFFFEEAE6);
const Color shrinePink100 = Color(0xFFFEDBD0);
const Color shrinePink300 = Color(0xFFFBB8AC);
const Color shrinePink400 = Color(0xFFEAA4A4);

const Color shrineBrown900 = Color(0xFF442B2D);
const Color shrineBrown600 = Color(0xFF7D4F52);
