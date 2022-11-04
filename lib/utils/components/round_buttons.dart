import 'package:flutter/material.dart';
import 'package:rehab/utils/components/colors.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;
  const RoundButton(
      {super.key,
      required this.title,
      this.loading = false,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 50,
        width: 200,
        decoration: const BoxDecoration(color: Colors.green),
        child: Center(
            child: loading
                ? const CircularProgressIndicator(
                    color: AppColors.whiteColor,
                  )
                : Text(
                    title,
                    style: const TextStyle(color: AppColors.whiteColor),
                  )),
      ),
    );
  }
}

class SizedBoxWidget {
  static box(var h) {
    return SizedBox(height: h);
  }
}
