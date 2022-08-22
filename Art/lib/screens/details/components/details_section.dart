import 'package:flutter/material.dart';
import '../../../data/data.dart';
import '../../../config/responsive.dart';

class DetailsSection extends StatelessWidget {
  const DetailsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .15,
          vertical: 50,
        ),
        child: Column(
          children: [
            const SizedBox(height: 80),
            Wrap(
              spacing: 5,
              runSpacing: 5,
              children:[SizedBox(
                width: MediaQuery.of(context).size.width * .7,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.width * .75,
                      child: Image.asset(previews[0].imageUrl),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * .075),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * .01,
                    ),
                    Text(previews[0].name, style:
                    TextStyle(
                      color: previews[0].color?.withOpacity(.8),
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                    )
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * .01,
                    ),
                    Text(
                      previews[0].name,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * .025,
                    ),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.center,
                      children:
                      previews.map((s) => Chip(label: Text(s.name))).toList(),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * .025,
                    ),
                    OutlineButton(
                      onPressed: () {

                      },
                      color: Colors.yellow,
                      textColor: Colors.yellow,
                      borderSide: BorderSide(
                        color: Colors.yellow.withOpacity(.5),
                        width: 5,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('Visit'),
                    ),
                    Divider(
                      color: Colors.black.withOpacity(.1),
                      height: 50,
                      thickness: 1,
                    ),
                  ],
                ),
              )],

            ),
          ],
        ),
      ),
      desktop: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 100),
        child: Column(
          children: [
            const SizedBox(height: 80),
            SizedBox(
              width: MediaQuery.of(context).size.width * .7,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width * .3,
                        child: Image.asset(previews[0].imageUrl),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * .075),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.width * .01,
                            ),
                            Text(previews[0].name,
                                style:
                                TextStyle(
                                  color: previews[0].color?.withOpacity(.8),
                                  fontSize: 35,
                                  fontWeight: FontWeight.w700,
                                )),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * .01,
                            ),
                            Text(previews[0].name),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * .025,
                            ),
                            Wrap(
                              spacing: 10,
                              runSpacing:5,
                              children: previews.map((s) => Chip(label: Text(s.name))).toList(),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * .025,
                            ),
                            OutlineButton(
                              onPressed: () {
                                // launch(project.url!);
                              },
                              color: previews[0].color,
                              textColor: previews[0].color,
                              borderSide: BorderSide(
                                color: previews[0].color!.withOpacity(.5),
                                width: 5,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 20,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text('Visit'),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * .025,
                            ),
                            OutlineButton(
                              onPressed: () {
                                // launch(project.url!);
                              },
                              color: previews[0].color,
                              textColor: previews[0].color,
                              borderSide: BorderSide(
                                color: previews[0].color!.withOpacity(.5),
                                width: 5,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 20,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text('Add to Cart'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: previews[0].color?.withOpacity(.1),
                    height: 20,
                    thickness: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}