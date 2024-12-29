//loader animation till data is fetched
import 'package:flutter/material.dart';

class ZoomAnimation extends StatefulWidget {
  const ZoomAnimation({super.key});

  @override
  _ZoomAnimationState createState() => _ZoomAnimationState();
}

class _ZoomAnimationState extends State<ZoomAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    
    _animation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height1 = size.height;

    final padding = MediaQuery.of(context).viewPadding;
    double height = height1 - padding.top - padding.bottom;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _animation.value,
                  child: child,
                );
              },
              child: Container(height: height*0.07,child: Image.asset('assets/FamPay_Logo.png',)),
            ),
            SizedBox(height: height*0.07,),
            Text("Loading...",style: TextStyle(fontSize: 15,color: const Color.fromARGB(255, 111, 111, 111)),)
          ],
        ),
      ),
    );
  }
}
