import 'package:aquar/features/home/domain/models/filter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/constant/colors/colors.dart';
import 'home_product_card.dart';

class AdsCard extends StatefulWidget {
  final List<ImageFilter> sliders;
  final String image;
  const AdsCard({
    Key? key,
    required this.sliders,
    required this.image,
  }) : super(key: key);
  @override
  State<AdsCard> createState() => _AdsCardState();
}

class _AdsCardState extends State<AdsCard> {
  int currentIndex = 0;
  final CarouselController carouselController = CarouselController();

  List<ImageFilter> newSlider = [];
  @override
  void initState() {
    super.initState();
    ImageFilter iconImage = ImageFilter(
        delete: DeleteImageFilter(method: DeleteImageMethod.delete, href: ''),
        id: -1,
        url: widget.image);
    newSlider = newSlider;
    newSlider.addAll(widget.sliders);
    newSlider.insert(0, iconImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (newSlider.isNotEmpty)
          Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.antiAlias,
            children: [
              SizedBox(
                height: 250,
                child: CarouselSlider.builder(
                  itemCount: newSlider.length,
                  carouselController: carouselController,
                  options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                      // if (sliders[index].isView == 0) {
                      //   context.read<ViewAdvertisementCubit>().fViewAdvertisement(
                      //       addId: sliders[index].id, type: AddsType.slider);
                      //   context
                      //       .read<HomeInfoCubit>()
                      //       .updateShowSlider(index: index);
                      // }
                    },
                    autoPlay: true,
                    enableInfiniteScroll: false,
                    autoPlayInterval: const Duration(seconds: 3),
                    // aspectRatio: 0,
                    height: 250,
                    scrollDirection: Axis.horizontal,
                    scrollPhysics: const BouncingScrollPhysics(),
                    // autoPlayCurve: Curves.decelerate,
                    viewportFraction: 1.5,
                    disableCenter: true,
                    enlargeCenterPage: true,
                    // enlargeStrategy: CenterPageEnlargeStrategy.scale
                  ),
                  itemBuilder: (context, index, realIdx) {
                    return HomeProductCard(image: newSlider[index].url
                        // sliders[index].image
                        );
                  },
                ),
              ),
              if (newSlider.length > 1)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: AnimatedSmoothIndicator(
                    activeIndex: currentIndex,
                    count: newSlider.length,
                    onDotClicked: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                      carouselController.animateToPage(currentIndex);
                    },
                    effect: const WormEffect(
                        dotHeight: 10, dotWidth: 10, activeDotColor: white),
                  ),
                ),
            ],
          ),
        // if (sliders.length > 1) const Space(boxHeight: 10),
      ],
    );
  }
}
