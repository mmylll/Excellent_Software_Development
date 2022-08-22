import 'package:flutter/material.dart';

class MyInfo extends StatelessWidget {
  String? photoUrl;
  MyInfo({
    Key? key,
    this.photoUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Container(
        // color: const Color(0xFF242430),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage:
              NetworkImage(photoUrl!),
              // AssetImage("assets/images/IMG_7344.jpg"),
            ),
            const Spacer(),
            Text(
              "It's me",
              style: Theme.of(context).textTheme.subtitle2,
            ),
            // Expanded(
            //     child:
                const Text(
                  "Flutter Developer & Founder of \n The Flutter Way",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    height: 1.5,
                  ),
                    softWrap:true,

                ),

            // ),

            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}