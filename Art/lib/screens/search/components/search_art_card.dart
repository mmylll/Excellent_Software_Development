import 'package:art/screens/details/details_screen.dart';
import 'package:flutter/material.dart';
import '../../../config/responsive.dart';
import '../../../data/constants.dart';
import '../../../model/painting.dart';
import '../../details/components/details_art.dart';
import '../../personal_center/project.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:art/data/assets.dart';

class SearchArtCard extends StatefulWidget {
  const SearchArtCard({
    Key? key,
    required this.project,
    this.index,
  }) : super(key: key);

  final Painting project;
  final int? index;

  @override
  _SearchArtCardState createState() => _SearchArtCardState();

// @override
// Widget build(BuildContext context) {
//   return InkWell(
//     // padding: const EdgeInsets.all(defaultPadding),
//     // color: secondaryColor,
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           project.title!,
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//           style: Theme.of(context).textTheme.subtitle2,
//         ),
//         const Spacer(),
//         const Image(
//           image: AssetImage("assets/images/trekking.jpg"),
//
//         ),
//         const Spacer(),
//         Text(
//           project.description!,
//           maxLines: Responsive.isMobileLarge(context) ? 2 : 3,
//           overflow: TextOverflow.ellipsis,
//           style: const TextStyle(height: 1.5),
//         ),
//         const Spacer(),
//         Text(
//           "author name: daiding",
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//           style: Theme.of(context).textTheme.subtitle1,
//         ),
//         const Spacer(),
//         Text(
//           "price: daiding",
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//           style: Theme.of(context).textTheme.subtitle1,
//         ),
//         const Spacer(),
//         Text(
//           "visits: daiding",
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//           style: Theme.of(context).textTheme.subtitle1,
//         ),
//         const Spacer(),
//         TextButton(
//           onPressed: () {},
//           child: const Text(
//             "Read More >>",
//             style: TextStyle(
//                 color: primaryColor,
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }
}

class _SearchArtCardState extends State<SearchArtCard> {
  bool isHover = false;
  Duration duration = const Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    Painting project = widget.project;
    return InkWell(
      onTap: () => {
        // Navigator.of(context).push(PageRouteBuilder(
        //     transitionDuration: const Duration(milliseconds: 250), // //动画时间为0.25秒
        //     pageBuilder: (BuildContext context, Animation<double> animation,
        //         Animation secondaryAnimation) {
        //       return FadeTransition(
        //         //渐隐渐入过渡动画
        //         opacity: animation,
        //         child: const CourseInfoScreen(),
        //       );
        //     }))

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CourseInfoScreen(
            painting: project,
          );
        }))
      },
      onHover: (value) {
        setState(() {
          isHover = value;
        });
      },
      hoverColor: Colors.transparent,
      child: AnimatedContainer(
        padding: const EdgeInsets.all(10),
        duration: duration,
        margin: const EdgeInsets.symmetric(vertical: kDefaultPadding * 2),
        decoration: BoxDecoration(
          color: Colors.black12,
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [if (isHover) kDefaultCardShadow],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.title == null ? "null" : project.title!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            const Spacer(),
            Image(
              width: 300,
              fit: BoxFit.contain,
              image: NetworkImage(Assets.oss_painting_square + widget.project.imageFileName!+ '.jpg'),
            ),
            const Spacer(),
            Text(
              project.description == null ? "null" : project.description!,
              maxLines: Responsive.isMobileLarge(context) ? 2 : 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(height: 1.5),
            ),
            const Spacer(),
            Text(
              (project.artist.firstName == null) ? "author name: null" :
              "author name: ${project.artist.firstName! + " " + project.artist.lastName}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const Spacer(),
            Text(
              "price: ${project.cost}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const Spacer(),
            Text(
              "visits: ${project.views}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const Spacer(flex: 2),
            Container(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Read More >>",
                  style: TextStyle(
                    color: primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
