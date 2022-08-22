import 'package:art/components/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:art/data/theme.dart' as theme;
import '../../data/constants.dart';
import '../../components/art_app_bar.dart';
import '../../config/responsive.dart';


class PersonalMain extends StatelessWidget {
  const PersonalMain({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;


  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
          decoration: const BoxDecoration(
            gradient: theme.Theme.mainGradient,
          ),
          child: Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, Responsive.isDesktop(context)? 70 : 0, 0, 0),
              constraints: const BoxConstraints(maxWidth: maxWidth),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (Responsive.isDesktop(context))
                    Expanded(
                      flex: 2,
                      child: SideMenu(),
                    ),
                  const SizedBox(width: defaultPadding),
                  Expanded(
                    flex: 7,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ...children,
                          // our footer
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}