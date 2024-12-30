import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HC6 extends StatelessWidget {
  const HC6({super.key, required this.hc});

  final List<dynamic> hc;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height1 = size.height;

    final padding = MediaQuery.of(context).viewPadding;
    double height = height1 - padding.top - padding.bottom;

    final List<dynamic> hc6 = hc;

    //function to launch the web site
    Future<void> _launchURL(String url) async {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Container(
      height: (hc6[0]["height"] + height * 0.07).toDouble(),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
      child: ListView.builder(
          physics: hc6[0]["is_scrollable"] == false
              ? NeverScrollableScrollPhysics()
              : AlwaysScrollableScrollPhysics(),
          itemCount: hc6[0]["cards"].length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              //returning individual cards of hc6 componet
              padding: EdgeInsets.symmetric(
                  vertical: height * 0.015, horizontal: width * 0.01),
              child: InkWell(
                onTap: () {
                  _launchURL(
                      hc6[0]["cards"][index]["url"]); //for launching web url
                },
                child: Container(
                  width: width * 0.915,
                  height: (hc6[0]["height"]).toDouble(),
                  decoration: BoxDecoration(
                      color: Color(int.parse(
                          "0xff${"${hc6[0]["cards"][index]["bg_color"]}".substring(1)}")),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.06, vertical: height * 0.02),
                    child: Row(
                      children: [
                        Image.network(
                          hc6[0]["cards"][index]["icon"]["image_url"],
                          height: (hc6[0]["cards"][index]["icon_size"] +
                                  height * 0.02)
                              .toDouble(),
                        ),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Text(
                          hc6[0]["cards"][index]["formatted_title"]["entities"]
                              [0]["text"],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(int.parse(
                                  "0xff${"${hc6[0]["cards"][index]["formatted_title"]["entities"][0]["color"]}".substring(1)}"))),
                        ),
                        Flexible(
                          child: Container(),
                          flex: 1,
                        ),
                        Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
