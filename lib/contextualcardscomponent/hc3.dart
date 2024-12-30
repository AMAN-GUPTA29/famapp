import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HC3 extends StatefulWidget {
  const HC3(
      {super.key,
      required this.hc,
      required this.onRemindLater,
      required this.onDismissNow});

  final List<dynamic> hc;
  final Function(int) onRemindLater; // callback function for onRemind
  final Function(int) onDismissNow; // callback function for onDismiss

  @override
  State<HC3> createState() => _HC3State();
}

class _HC3State extends State<HC3> {
  //for handling the swipe of card component when long pressed;
  bool longpress = false;
  int ind = -1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height1 = size.height;

    final padding = MediaQuery.of(context).viewPadding;
    double height = height1 - padding.top - padding.bottom;

    List<dynamic> hc3 = widget.hc;

    //function to launch the web page
    Future<void> _launchURL(String url) async {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Container(
      width: width,
      height: height * 0.50,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
      child: ListView.builder(
          physics: hc3[0]["is_scrollable"] == false
              ? NeverScrollableScrollPhysics()
              : AlwaysScrollableScrollPhysics(),
          itemCount: hc3[0]["cards"].length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              //returning individual cards
              padding: EdgeInsets.symmetric(vertical: height * 0.0),
              child: InkWell(
                onLongPress: () {
                  setState(() {
                    longpress = !longpress;
                    ind = index;
                  });
                },
                child: Container(
                  child: Row(
                    children: [
                      ind == index && longpress == true
                          ? Container(
                              // conditinally rendering the container with side button for remind later and dismiss now
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20))),

                              width: width * 0.3,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // this will make the hc3 componet to load when the 
                                        // app is restarted or when refreshed also by swipe down 
                                        // (it was mention to only render the componet again on 
                                        // restart but i am rendering on refresh too cause there 
                                        // wont be use of refreshing the card).
                                        widget.onRemindLater(index);
                                      },
                                      child: Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              color: Color(0xffF7F6F3)),
                                          child: Column(
                                            children: [
                                              Image.asset("assets/bell.png"),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                "remind later",
                                                style: TextStyle(fontSize: 10),
                                              )
                                            ],
                                          )),
                                    ),
                                    SizedBox(
                                      height: height * 0.05,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        //we can't implement the intended dismiss function
                                        //now as we can not change the backend data and everytime 
                                        //the app refresh that card will be loaded back so currently 
                                        //its functionality is same as remind later.
                                        widget.onDismissNow(index);
                                      },
                                      child: Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              color: Color(0xffF7F6F3)),
                                          child: Column(
                                            children: [
                                              Image.asset("assets/cross.png"),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                "dismiss now",
                                                style: TextStyle(fontSize: 10),
                                              )
                                            ],
                                          )),
                                    ),
                                  ]),
                            )
                          : SizedBox(),
                      Container(
                        width: width * 0.95,
                        child: Stack(
                          //using stack for passing the text and everything on the image as background is in the image too
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Image.network(
                                  "https://hok.famapp.co.in/hok-assets/feedMedia/ext/70db327c-b5a0-4485-b97d-6b5eae1f1614-1734193722611.webp",
                                  width: width * 0.95,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              // Text in hc3 component and action button to launch the website
                              padding:
                                  EdgeInsets.symmetric(horizontal: width * 0.1),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: height * 0.17,
                                  ),
                                  Text(
                                    hc3[0]["cards"][index]["formatted_title"]
                                        ["entities"][0]["text"],
                                    style: TextStyle(
                                        fontSize: hc3[0]["cards"][index]
                                                    ["formatted_title"]
                                                ["entities"][0]["font_size"]
                                            .toDouble(),
                                        fontWeight: FontWeight.w500,
                                        color: Color(int.parse(
                                            "0xff${"${hc3[0]["cards"][index]["formatted_title"]["entities"][0]["color"]}".substring(1)}"))),
                                  ),
                                  Text(
                                    hc3[0]["cards"][index]["formatted_title"]
                                            ["text"]
                                        .substring(
                                            3,
                                            hc3[0]["cards"][index]
                                                            ["formatted_title"]
                                                        ["text"]
                                                    .length -
                                                3),
                                    style: TextStyle(
                                        fontSize: hc3[0]["cards"][index]
                                                    ["formatted_title"]
                                                ["entities"][0]["font_size"]
                                            .toDouble(),
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xffffffff)),
                                  ),
                                  SizedBox(
                                    height: height * 0.025,
                                  ),
                                  Text(
                                    hc3[0]["cards"][index]["formatted_title"]
                                        ["entities"][1]["text"],
                                    style: TextStyle(
                                        fontSize: hc3[0]["cards"][index]
                                                    ["formatted_title"]
                                                ["entities"][1]["font_size"]
                                            .toDouble(),
                                        color: Color(int.parse(
                                            "0xff${"${hc3[0]["cards"][index]["formatted_title"]["entities"][1]["color"]}".substring(1)}"))),
                                  ),
                                  SizedBox(
                                    height: height * 0.018,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      _launchURL(hc3[0]["cards"][index]["url"]);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        backgroundColor: Color(int.parse(
                                            "0xff${"${hc3[0]["cards"][index]["cta"][0]["bg_color"]}".substring(1)}"))),
                                    child: Text(
                                      hc3[0]["cards"][index]["cta"][0]["text"],
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
