import 'package:apiproject/ApiHomePage.dart';
import 'package:apiproject/ApiLoginPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  checklogin() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("islogin"))
    {
      Navigator.of(context).pop();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>ApiHomePage())
      );
    }
    else
    {
      Navigator.of(context).pop();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>ApiLoginPage())
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 5000), () {
      checklogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: WidgetCircularAnimator(
            size: 250,
            innerIconsSize: 3,
            outerIconsSize: 3,
            innerAnimation: Curves.easeInOutBack,
            outerAnimation: Curves.easeInOutBack,
            innerColor: Colors.deepPurple,
            outerColor: Colors.orangeAccent,
            innerAnimationSeconds: 10,
            outerAnimationSeconds: 10,
            child: Container(
              decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.grey[200]),
              child: Image.asset("img/download.png")
            ),
          ),
        )
    );
  }
}
