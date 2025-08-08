import 'package:crocurry/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

enum CardBannerPosition {
  TOPLEFT,
  TOPRIGHT,
  BOTTOMLEFT,
  BOTTOMRIGHT,
}

class OfferBanner extends StatelessWidget {
  const OfferBanner({
    super.key,
    required this.child,
    required this.text,
    this.position = CardBannerPosition.TOPLEFT,
    this.color = Colors.blue,
    this.edgeColor = const Color.fromARGB(255, 7, 86, 150),
    this.radius = 4,
    this.padding = 4.0,
    this.edgeSize = 6,
    this.textStyle = const TextStyle(fontSize: 10, color: Colors.white),
  });

  final Widget child;
  final String text;
  final Color color;
  final Color edgeColor;
  final double edgeSize;
  final double radius;
  final double padding;
  final CardBannerPosition position;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned.fill(
          right: position.toString().contains("RIGHT") ? -6 : null,
          left: position.toString().contains("LEFT") ? -6 : null,
          top: position.toString().contains("TOP") ? 5 : null,
          bottom: position.toString().contains("BOTTOM") ? 20 : null,
          child: CustomPaint(
            painter: DesignCardBanner(edgeColor, position, edgeSize),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radius),
                  topRight: Radius.circular(radius),
                  bottomLeft: position.toString().contains("LEFT")
                      ? Radius.zero
                      : Radius.circular(radius),
                  bottomRight: position.toString().contains("RIGHT")
                      ? Radius.zero
                      : Radius.circular(radius),
                ),
                color: context.primaryColor,
              ),
              child: Text(text, style: textStyle),
            ),
          ),
        ),
      ],
    );
  }
}

class DesignCardBanner extends CustomPainter {
  DesignCardBanner(this.color, this.position, this.edgeSize);
  final Color color;
  final CardBannerPosition position;
  final double edgeSize;
  @override
  void paint(Canvas canvas, Size size) {
    if (position.toString().contains("LEFT")) {
      Paint paint = Paint()..color = color;
      var path = Path();
      path.moveTo(0, 0);
      path.lineTo(0, size.height);
      path.lineTo(10, size.height + edgeSize);
      path.lineTo(10, size.height);
      path.lineTo(0, size.height);
      path.close();
      canvas.drawPath(path, paint);
    } else {
      Paint paint = Paint()..color = color;
      var path = Path();
      path.moveTo(size.width, size.height);

      path.lineTo(size.width - 10, size.height + edgeSize);
      path.lineTo(size.width - 10, size.height);
      path.lineTo(size.width, size.height);
      path.close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
