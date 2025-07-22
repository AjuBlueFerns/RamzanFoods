import 'package:crocurry/data/models/product_details_image_model.dart';
import 'package:crocurry/views/screens/home/views/components/products/offer_percent_widget.dart';
import 'package:flutter/material.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';
import '../../../components/network_image_with_loader.dart';

import '../../../../../utils/constants.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    super.key,
    required this.images,
    required this.percent,
  });

  final List<ProductDetailsImageModel> images;
  final double percent;

  @override
  State<ProductImages> createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  late PageController _controller;

  int _currentPage = 0;

  @override
  void initState() {
    _controller =
        PageController(viewportFraction: 0.9, initialPage: _currentPage);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1.2,
          child: Stack(
            children: [
              PageView.builder(
                controller: _controller,
                onPageChanged: (pageNum) {
                  setState(() {
                    _currentPage = pageNum;
                  });
                },
                itemCount: widget.images.length,
                itemBuilder: (context, index) {
                  var item = widget.images[index];
                  var url = baseUrl + item.imageFilePath! + item.imageFileName!;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(defaultBorderRadius * 2),
                      ),
                      child: ZoomOverlay(
                        child: NetworkImageWithLoader(url),
                      ),
                    ),
                  );
                },
              ),
              // if (widget.percent != 0.0)
              //   OfferPercentWidget(
              //     percent: widget.percent,
              //     topPosition: 18,
              //     rightPosition: 34,
              //     height: 20,
              //     fontSize: 12,
              //   ),
              // if (widget.images.length > 1)
              //   Positioned(
              //     height: 20,
              //     bottom: 24,
              //     right: MediaQuery.of(context).size.width * 0.15,
              //     child: Container(
              //       padding: const EdgeInsets.symmetric(
              //         horizontal: defaultPadding * 0.75,
              //       ),
              //       decoration: BoxDecoration(
              //         color: Theme.of(context).scaffoldBackgroundColor,
              //         borderRadius: const BorderRadius.all(Radius.circular(50)),
              //       ),
              //       child: Row(
              //         children: List.generate(
              //           widget.images.length,
              //           (index) => Padding(
              //             padding: EdgeInsets.only(
              //                 right: index == (widget.images.length - 1)
              //                     ? 0
              //                     : defaultPadding / 4),
              //             child: CircleAvatar(
              //               radius: 3,
              //               backgroundColor: Theme.of(context)
              //                   .textTheme
              //                   .bodyLarge!
              //                   .color!
              //                   .withOpacity(index == _currentPage ? 1 : 0.2),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   )
            ],
          ),
        ),
        SizedBox(height: defaultPadding/2),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding * 0.75,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(50)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.images.length,
              (index) => Padding(
                padding: EdgeInsets.only(
                    right: index == (widget.images.length - 1)
                        ? 0
                        : defaultPadding / 4),
                child: CircleAvatar(
                  radius: 3,
                  backgroundColor: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(index == _currentPage ? 1 : 0.2),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
