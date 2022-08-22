import 'package:flutter/material.dart';
import 'package:outline_search_bar/outline_search_bar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ArtSearchBar extends StatefulWidget {
  TextEditingController? textEditingController;
  String? search;

  ArtSearchBar({
    Key? key,
    required this.textEditingController,
    required this.search
  }) : super(key: key);

  @override
  _ArtSearchBarState createState() => _ArtSearchBarState();
}

class _ArtSearchBarState extends State<ArtSearchBar> {

  void getSearchStr(String value){
    setState(() {
      if(widget.textEditingController?.text != null){
        widget.search = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width * 0.8,
      alignment: Alignment.center,
      child: OutlineSearchBar(
        textEditingController: widget.textEditingController,
        backgroundColor: Colors.white,
        borderColor: Colors.grey,
        textStyle: const TextStyle(color: Colors.black),
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        hintText: "Search...",
        onSearchButtonPressed:(value){
          EasyLoading.showProgress(0.3, status: "loading....");
          getSearchStr(value);
          },
      ),
    );
  }
}
