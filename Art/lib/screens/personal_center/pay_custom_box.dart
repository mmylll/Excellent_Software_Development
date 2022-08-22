import 'package:flutter/material.dart';

import '../../data/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class PayCustomBox extends StatefulWidget {
  const PayCustomBox({
    Key? key,
    required this.label,
    required this.text,
    required this.onLeftArea,
    this.onLeftAreaBackground,
    required this.onRightArea,
  }) : super(key: key);

  final String label;
  final String text;
  final Widget onLeftArea;
  final Color ? onLeftAreaBackground;
  final Text onRightArea;

  @override
  _PayCustomBoxState createState() => _PayCustomBoxState();
}

class _PayCustomBoxState extends State<PayCustomBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 71,
      margin: EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colorPrimaryDark.withOpacity(0.1),
            blurRadius: 50,
            spreadRadius: -20,
            offset: Offset(2, 8),
          ),
        ],
        color: colorWhite,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 15),
        child: Row(
          mainAxisAlignment: widget.onRightArea != null
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: widget.onLeftAreaBackground != null
                        ? widget.onLeftAreaBackground
                        : colorGray,
                  ),
                  child: Center(
                    child: widget.onLeftArea != null
                        ? widget.onLeftArea
                        : Text(
                      widget.label[0],
                      style: GoogleFonts.manrope(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: colorBlack,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.label,
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: colorBlack,
                        ),
                      ),
                      Text(
                        widget.text,
                        style: GoogleFonts.manrope(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: colorBlack.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            widget.onRightArea != null ? widget.onRightArea : SizedBox(),
          ],
        ),
      ),
    );
  }
}