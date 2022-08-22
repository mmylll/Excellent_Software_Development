import 'package:art/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

// import 'package:dianying/core/extension/index.dart';

class Pager extends StatefulWidget {

  int pageIndex;
  late TextStyle activeTextStyle;  // 当前页码的文本样式
  late Widget preWidget;  // 上一页的widget
  late Widget nextWidget; // 下一页的widget
  int total;  // 总页码数量
  late double containerWidth;  // 容器的宽度
  late MainAxisAlignment mainAxisAlignment;  // 页码横主轴对齐方式
  late TextStyle normalTextStyle;  // 其他页码的文本样式
  late double pagerItemWidth;  // 页码item的宽度
  late double pagerItemHeight; // 页码item的高度
  late BoxDecoration pagerItemDecoration;  // 页码item的样式
  ValueChanged pageChange;   // 页码改变的回调
  late EdgeInsetsGeometry pagerItemMargin;  // 页码item的边距

  Pager({
    Key? key,
    TextStyle? activeTextStyle,
    Widget? preWidget,
    Widget? nextWidget,
    required this.total,
    double? containerWidth,
    MainAxisAlignment? mainAxisAlignment,
    TextStyle? normalTextStyle,
    double? pagerItemWidth,
    double? pagerItemHeight,
    BoxDecoration? pagerItemDecoration,
    required this.pageChange,
    EdgeInsetsGeometry? pagerItemMargin,
    required this.pageIndex,
  }) :  activeTextStyle = activeTextStyle ?? TextStyle(color: Colors.white,
      fontSize: 14),
        preWidget = preWidget ?? Icon(Icons.arrow_left, color: Colors.blue, size: 22),
        nextWidget = nextWidget ?? Icon(Icons.arrow_right, color: Colors.blue, size: 22),
        containerWidth = containerWidth ?? double.infinity,
        mainAxisAlignment = mainAxisAlignment ?? MainAxisAlignment.spaceAround,
        normalTextStyle = normalTextStyle ?? TextStyle(color: Colors.blue, fontSize: 14),
        pagerItemWidth = pagerItemWidth ?? 36,
        pagerItemHeight = pagerItemHeight ?? 30,
        pagerItemDecoration = pagerItemDecoration ?? BoxDecoration(color: const Color(
            0xff80e5e8), borderRadius: BorderRadius.circular(3)),
        pagerItemMargin = pagerItemMargin ?? const EdgeInsets.all(0),
        super(key: key);

  @override
  State<Pager> createState() => _PagerState();
}

class _PagerState extends State<Pager> {
  int _pageIndex = 1;
  List _list = [];


  @override
  void didUpdateWidget(Pager oldWidget) {
    super.didUpdateWidget(oldWidget);
    _pageIndex = widget.pageIndex;
  }

  setPageIndex(){
    // setState(() {
    //   _pageIndex = 1;
      print("ppppppppppppppppppppppp");
      // print(_pageIndex);
    // });
  }


  void manageList() {
    _list = [];
    if(widget.total <= 1) {
      return;
    }
    if(widget.total <= 7) {
      for(var i = 0; i < widget.total; i++) {
        _list.add(i+1);
      }
    } else if(_pageIndex <= 4) {
      _list = [1,2,3,4,5, "...", widget.total];
    } else if(_pageIndex > widget.total - 3) {
      _list = [1,2, "...", widget.total - 3, widget.total - 2, widget.total - 1,  widget.total];
    } else {
      _list = [1, "...", _pageIndex - 1, _pageIndex, _pageIndex + 1, "...", widget.total];
    }
    _list.insert(0, widget.preWidget);
    _list.add(widget.nextWidget);
  }

  @override
  Widget build(BuildContext context) {
    return buildContent();
  }


  Widget buildContent() {
    manageList();
    return Container(
      width: widget.containerWidth,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: widget.mainAxisAlignment,
        children: _list.mapIndexed((index, ele) {
          if(index == 0) {
            return GestureDetector(
              onTap: () {
                if(_pageIndex > 1) {
                  setState(() {
                    _pageIndex--;
                    widget.pageChange(_pageIndex);
                  });
                }
              },
              child: buildPagerItem(
                  child: ele
              ),
            );
          }
          if(index == _list.length - 1) {
            return GestureDetector(
              onTap: () {
                if(_pageIndex < widget.total) {
                  setState(() {
                    _pageIndex++;
                    widget.pageChange(_pageIndex);
                  });
                }
              },
              child: buildPagerItem(
                  child: ele
              ),
            );
          }
          return GestureDetector(
            onTap: () {
              if(ele != "...") {
                setState(() {
                  if(_pageIndex != ele) {
                    _pageIndex = ele;
                    widget.pageChange(_pageIndex);
                  }
                });
              }
            },
            child: buildPagerItem(
                child: Text(
                  // "$ele",
                  "$ele",
                  style: ele == _pageIndex ? widget.activeTextStyle : widget.normalTextStyle,
                )
            ),
          );
        }).toList(),
      ),
    );
  }


  Widget buildPagerItem({
    required Widget child
  }) {
    return Container(
      width: widget.pagerItemWidth,
      height: widget.pagerItemHeight,
      alignment: Alignment.center,
      decoration: widget.pagerItemDecoration,
      margin: widget.pagerItemMargin,
      child: child,
    );
  }
}

