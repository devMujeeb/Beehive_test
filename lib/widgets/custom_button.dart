import 'package:beehive/widgets/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPress;
  final String buttonName;
  final Color? textColor;
  final Color? buttonColor;
  final double? elevation;
  const CustomButton({
    Key? key,
    required this.onPress,
    required this.buttonName,
    this.textColor,
    this.buttonColor,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50.0),
          primary: themeColor,
          elevation: elevation,
        ),
        child: Text(
          buttonName,
          style:const TextStyle(
            fontFamily: "Cario",
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
