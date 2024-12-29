import 'package:flutter/material.dart';

class HC9 extends StatelessWidget {
  const HC9({super.key, required this.hc});

  final List<dynamic> hc;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height1 = size.height;

    final padding = MediaQuery.of(context).viewPadding;
    double height = height1 - padding.top - padding.bottom;

    final List<dynamic> hc9 = hc;

    return Container(
      width: width,
      height: height * 0.325,
      decoration: BoxDecoration(
       
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: ListView.builder(
          physics: hc9[0]["is_scrollable"] == false
              ? NeverScrollableScrollPhysics()
              : AlwaysScrollableScrollPhysics(),
          itemCount: hc9[0]["cards"].length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Padding( //returning the individual cards of the hc9 component with color gradient
              padding: EdgeInsets.symmetric(
                  vertical: height * 0.015, horizontal: width * 0.02),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(tileMode: TileMode.clamp,begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [
                      Color(int.parse(
                          "0xff${"${hc9[0]["cards"][index]["bg_gradient"]["colors"][1]}".substring(1)}")),
                      Color(int.parse(
                          "0xff${"${hc9[0]["cards"][index]["bg_gradient"]["colors"][0]}".substring(1)}"))
                    ]),
                    image: DecorationImage(
                        image: NetworkImage(
                            hc9[0]["cards"][index]["bg_image"]["image_url"])),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                height: height * 0.1,
                width: height *
                    0.3 *
                    hc9[0]["cards"][index]["bg_image"]["aspect_ratio"],
              ),
            );
          }),
    );
  }
}
