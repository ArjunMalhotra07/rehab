import 'package:flutter/material.dart';
import 'package:rehab/utils/components/colors.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;
  final Color? buttonColor;
  final double? height;
  final double? width;
  final double? radius;
  final double? titleSize;
  const RoundButton(
      {super.key,
      required this.title,
      this.loading = false,
      this.buttonColor,
      required this.onPress,
      this.height,
      this.width,
      this.radius,
      this.titleSize});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: height ?? 60.0,
        width: width ?? 350,
        decoration: BoxDecoration(
          color: buttonColor ?? Constants.greenColor,
          borderRadius: BorderRadius.circular(radius ?? 45),
        ),
        child: Center(
            child: loading
                ? const CircularProgressIndicator(
                    color: Constants.whiteColor,
                  )
                : TextStyleWidget.textStyle(title, titleSize ?? 18,
                    c: Constants.whiteColor)),
      ),
    );
  }
}

class SizedBoxWidget {
  static box(var h) {
    return SizedBox(height: h);
  }
}

class TextStyleWidget {
  static textStyle(String s, double size, {Color? c}) {
    return Text(
      s,
      style: TextStyle(
          fontSize: size,
          color: c ?? Constants.blackColor,
          fontWeight: FontWeight.w600),
    );
  }
}
