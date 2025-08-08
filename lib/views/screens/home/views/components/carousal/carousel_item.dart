
import 'package:crocurry/data/models/carousal_model.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/views/screens/components/network_image_with_loader.dart';
import 'package:flutter/material.dart';

class CarouselItem extends StatelessWidget {
  const CarouselItem({
    super.key,
    required this.press,
    required this.carousal,
  });

  final VoidCallback press;
  final CarousalModel carousal;

  @override
  Widget build(BuildContext context) {
    var imageUrl = baseUrl + carousal.imageUrl!;
    return NetworkImageWithLoader(
      imageUrl,
      radius: 0,
      fit: BoxFit.fill  ,
    );
  }
}
