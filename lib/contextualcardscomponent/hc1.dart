import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HC1 extends StatelessWidget {
  const HC1({super.key, required this.hc});

  final List<dynamic> hc;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height1 = size.height;

    final padding = MediaQuery.of(context).viewPadding;
    double height = height1 - padding.top - padding.bottom;

    final List<dynamic> hc1 = hc;
    bool scroll = hc1[0]["is_scrollable"];

    //funtion for launching website
     Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

    return Container(// for rendering hc1 component
      width: width,
      height: (hc1[0]["height"] + height * 0.03).toDouble(),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: ListView.builder(
          physics: hc1[0]["is_scrollable"] == false
              ? NeverScrollableScrollPhysics()
              : AlwaysScrollableScrollPhysics(),
          itemCount: hc1[0]["cards"].length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            // returning individual cards in hc5 component
            return InkWell(//for opening the web link
              onTap: (){
                if(hc1[0]["cards"][index]["url"]!=null){
                  _launchURL(hc1[0]["cards"][index]["url"]);
                }
                },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.02, vertical: height * 0.01),
                child: Container(
                  width: scroll == true ? width * 0.9 : (width * 0.9/hc1[0]["cards"].length)-width*0.02,
                  decoration: BoxDecoration(
                      color: Color(int.parse(
                          "0xff${"${hc1[0]["cards"][index]["bg_color"]}".substring(1)}")),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.05, vertical: height * 0.008),
                    child: Row(
                      children: [
                        Image.network(
                          hc1[0]["cards"][index]["icon"]["image_url"],
                          height: height * 0.055,
                        ),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: height * 0.012),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(scroll==true?
                                hc1[0]["cards"][index]["formatted_title"]
                                    ["entities"][0]["text"]:"Small Card",
                                style: TextStyle(
                                  fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(int.parse(
                                        "0xff${"${hc1[0]["cards"][index]["formatted_title"]["entities"][0]["color"]}".substring(1)}"))),
                              ),
                              hc1[0]["cards"][index]["formatted_description"]==null?SizedBox():
                              Text(hc1[0]["cards"][index]["formatted_description"]["entities"][0]["text"],style:TextStyle(fontSize: 12),)
                            ],
                          ),
                        )
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
