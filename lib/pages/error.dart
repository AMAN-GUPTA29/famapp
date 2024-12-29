//error page for network failure
import 'package:flutter/material.dart';

class FamError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height1 = size.height;

    final padding = MediaQuery.of(context).viewPadding;
    double height = height1 - padding.top - padding.bottom;
    return Scaffold(
        body: Container(
      width: width,
      height: height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Error...",
              style: TextStyle(
                  fontSize: 60, color: const Color.fromARGB(255, 93, 91, 91)),
            ),
            Text(
              "We Will get back soon",
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    ));
  }
}
