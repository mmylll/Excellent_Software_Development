import 'package:art/data/assets.dart';
import 'package:art/model/painting.dart';
import 'package:art/screens/details/details_screen.dart';
import 'package:flutter/material.dart';
import '../../../data/constants.dart';
import '../../details/components/details_art.dart';
import '../../personal_center/project.dart';
import '../../../config/responsive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularArtCard extends StatefulWidget {
  const PopularArtCard({
    Key? key,
    required this.project, this.index,
  }) : super(key: key);

  // final Project project;
  final Painting project;
  final int ? index;

  @override
  _PopularArtCardState createState() => _PopularArtCardState();
  

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

class _PopularArtCardState extends State<PopularArtCard> {

  bool isHover = false;
  Duration duration = Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    // Project project = widget.project;
    Painting project = widget.project;

    return InkWell(
      // onTap: () {
      //   Navigator.push<dynamic>(
      //     context,
      //     MaterialPageRoute<dynamic>(
      //       builder: (BuildContext context) => CourseInfoScreen(),
      //     ),
      //   );
      // },
      onTap: ()=> {
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
              project.title!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            const Spacer(),
            Image(
              width: 300,
              fit: BoxFit.contain,
              image: NetworkImage(Assets.oss_painting_square + project.imageFileName!+ '.jpg'),
            ),
            // Image(
            //   width: 300,
            //   fit: BoxFit.fill,
            //   image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/art-store-d1a02.appspot.com/o/uploads%2F%E8%AF%BE%E8%A1%A8.png?alt=media&token=f44796a9-5a5c-445e-ab23-6ec097b33220'),
            // ),
            // Container(
            //   margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
            //   width: 400,
            //   height: 400,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.all(Radius.circular(14)),
            //       color: Colors.blue.shade200,
            //       image: DecorationImage(
            //         fit: BoxFit.fill,
            //         image:  NetworkImage(Assets.oss_painting_square + project.imageFileName!+ '.jpg'),
            //       )),
            // ),
            const Spacer(),
            Text(
              project.description == null ? "null" : project.description!,
              maxLines: Responsive.isMobileLarge(context) ? 1 : 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(height: 1.5),
              softWrap: false,
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
