import 'package:crocurry/utils/constants.dart';
import 'package:flutter/material.dart';

class OfferPercentWidget extends StatelessWidget {
  const OfferPercentWidget({
    super.key,
    required this.percent,
    this.rightPosition = defaultPadding / 2,
    this.topPosition = defaultPadding / 2,
    this.height = 16,
    this.fontSize = 10,
  });
  final double percent;
  final double rightPosition;
  final double topPosition;
  final double height;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: rightPosition,
      top: topPosition,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding/2),
        height: height,
        decoration: const BoxDecoration(
          color: errorColor,
          borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
        ),
        child: Text(
          "$percent% off",
          style:  TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
