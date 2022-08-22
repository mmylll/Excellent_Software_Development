import 'package:flutter/material.dart';

class SearchPager extends StatelessWidget {
  late PageController pageController;

  SearchPager({Key? key,required this.pageController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _myWidget(0, false, const Icon(Icons.chevron_left_outlined),pageController),
          for (int i = 0; i < 10; i++)
            _myWidget(i, false, Text('${i + 1}', textAlign: TextAlign.center,),pageController
            ),
          _myWidget(0, false, const Icon(Icons.chevron_right_outlined),pageController),
        ],
      ),
    );
  }

  Widget _myWidget(index, isSelected, widget,controller) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Material(

      color: Colors.white.withOpacity(isSelected ? 0.25 : 0.0),
      borderRadius: BorderRadius.circular(12.0),
      clipBehavior: Clip.antiAlias,
      child: InkWell(

        onTap: () {
          controller.jumpToPage(index);
        },
        child: Container(
          alignment: Alignment.center,
          width: 50,
          height: 50,
          child: widget,
          // Text(
          //   '${index + 1}',
          //   textAlign: TextAlign.center,
          // ),
        ),
      ),
    ),
  );
  
}