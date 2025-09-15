import 'package:flutter/material.dart';

class ScreenshotWidget extends StatelessWidget {
  String screenshotPath ;
   ScreenshotWidget({super.key, required this.screenshotPath});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: height*0.01
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
       ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(screenshotPath, fit: BoxFit.cover,),
      ),



    );
  }
}
