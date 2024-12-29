import 'package:flutter/material.dart';

class HC5 extends StatelessWidget {
  const HC5({super.key, required this.hc});

  final List<dynamic> hc;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height1 = size.height;

    final padding = MediaQuery.of(context).viewPadding;
    double height = height1 - padding.top - padding.bottom;

    final List<dynamic> hc5 = hc;

    return Container(
      width: width,
      height: height*0.2,

      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
      child: ListView.builder(
        physics: hc5[0]["is_scrollable"] == false
                    ? NeverScrollableScrollPhysics()
                    : AlwaysScrollableScrollPhysics(),
          itemCount: hc5[0]["cards"].length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Padding( //returning hc5 individual components
              padding: EdgeInsets.symmetric(vertical: height * 0.015,horizontal: width*0.01),
              child: Container(
                clipBehavior: Clip.hardEdge,
                width: width * 0.915,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0, vertical: height * 0),
                  child: Image.network(hc5[0]["cards"][index]["bg_image"]["image_url"],fit: BoxFit.cover,),
                ),
              ),
            );
          }),
    );
  }
}
