import 'package:famapp/contextualcardscomponent/hc1.dart';
import 'package:famapp/contextualcardscomponent/hc3.dart';
import 'package:famapp/contextualcardscomponent/hc5.dart';
import 'package:famapp/contextualcardscomponent/hc6.dart';
import 'package:famapp/contextualcardscomponent/hc9.dart';
import 'package:famapp/contoller/apicall.dart';
import 'package:famapp/pages/error.dart';
import 'package:famapp/pages/loader.dart';
import 'package:flutter/material.dart';

class Contextualcards extends StatefulWidget {
  const Contextualcards({super.key});

  @override
  State<Contextualcards> createState() => _ContextualcardsState();
}

class _ContextualcardsState extends State<Contextualcards> {
  bool load = false;

  //List for different componet of the card 
  List<dynamic> hc3 = [];
  List<dynamic> hc6 = [];
  List<dynamic> hc5 = [];
  List<dynamic> hc9 = [];
  List<dynamic> hc1 = [];

  //api to fetch data and sort them in lists.

  Future<void> fetchData() async {
    setState(() {
      load = true;
    });

    final response = await fetchApi();
    if (response == "Error") {
      setState(() {
        load = false;
      });

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => FamError()));
    }
    for (int i = 0; i < response[0]["hc_groups"].length; i++) {

      if (response[0]["hc_groups"][i]["design_type"] == "HC1") {
        hc1.add(response[0]["hc_groups"][i]);
      } else if (response[0]["hc_groups"][i]["design_type"] == "HC3") {
        hc3.add(response[0]["hc_groups"][i]);
      } else if (response[0]["hc_groups"][i]["design_type"] == "HC5") {
        hc5.add(response[0]["hc_groups"][i]);
      } else if (response[0]["hc_groups"][i]["design_type"] == "HC6") {
        hc6.add(response[0]["hc_groups"][i]);
      } else if (response[0]["hc_groups"][i]["design_type"] == "HC9") {
        hc9.add(response[0]["hc_groups"][i]);
      }
    }


    setState(() {
      load = false;
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }


 
  //Controller for swipe down refresh
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  
  //function to handle removal of card in hc3
     void handlehc3(int cardno){
      setState(() {
        hc3[0]["cards"].removeAt(cardno);
      });
    }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height1 = size.height;

    final padding = MediaQuery.of(context).viewPadding;
    double height = height1 - padding.top - padding.bottom;

   

    return load == true
        ? ZoomAnimation() // loading animation
        : RefreshIndicator( // for swipe down refresh
            key: _refreshIndicatorKey,
            onRefresh: () {
              return fetchData();
            },
            child: ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.03, vertical: height * 0.015),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 247, 246, 243),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Column(
                      children: [
                        //checking for if cards are available in perticular component of card and rendering them
                        hc3.isNotEmpty && hc3[0]["cards"].length != 0
                            ? HC3(hc: hc3,onRemindLater: handlehc3,onDismissNow: handlehc3,) // in both function passing same function because we cannot permanently remove the component from the server as there is no delete api and everytime app is reloaded it will again reload it.
                            : SizedBox.shrink(),
                        hc6.isNotEmpty && hc6[0]["cards"].length != 0
                            ? HC6(hc: hc6)
                            : SizedBox.shrink(),
                        hc5.isNotEmpty && hc5[0]["cards"].length != 0
                            ? HC5(hc: hc5)
                            : SizedBox.shrink(),
                        hc9.isNotEmpty && hc9[0]["cards"].length != 0
                            ? HC9(hc: hc9)
                            : SizedBox.shrink(),
                        hc1.isNotEmpty && hc1[0]["cards"].length != 0
                            ? HC1(hc: hc1)
                            : SizedBox.shrink(),
                      ],
                    ),
                  );
                }),
          );
  }
}
