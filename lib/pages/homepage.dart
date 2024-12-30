import 'package:famapp/pages/contextualcards.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 246, 243),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          "assets/FamPay_Logo.png",
          height: 35,
        ),
        centerTitle: true,
      ),
      body: Contextualcards(), //The Main Card Component asked to be made.
    );
  }
}
