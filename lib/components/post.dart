import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:recycle/models/social_metrics.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final images = [
    'assets/images/recycle.png',
    'assets/images/recycle.png',
    'assets/images/recycle.png',
  ];
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(),
            postImages(),
            socialMetrics(),
            contents(),
          ],
        ));
  }

  Widget imageSlider(path, index) => Container(
        width: double.infinity,
        height: 240,
        color: Colors.grey,
        child: Image.asset(path, fit: BoxFit.cover),
      );

  Widget indicator() => Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      alignment: Alignment.bottomCenter,
      child: AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: images.length,
        effect: JumpingDotEffect(
            dotHeight: 6,
            dotWidth: 6,
            activeDotColor: Colors.white,
            dotColor: Colors.white.withOpacity(0.6)),
      ));

  Widget header() => Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                    radius: 22.5,
                    backgroundImage: AssetImage('assets/images/profile.jpg')),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text('indevruis'),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz),
                ),
              ],
            ),
          ],
        ),
      );

  Widget postImages() =>
      Stack(alignment: Alignment.bottomCenter, children: <Widget>[
        CarouselSlider.builder(
          options: CarouselOptions(
            initialPage: 0,
            viewportFraction: 1,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) => setState(() {
              activeIndex = index;
            }),
          ),
          itemCount: images.length,
          itemBuilder: (context, index, realIndex) {
            final path = images[index];
            return imageSlider(path, index);
          },
        ),
        Align(alignment: Alignment.bottomCenter, child: indicator())
      ]);

  Widget socialMetrics() => Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 0, 12),
        child: Row(
          children: socialMetricsItems
              .map((e) => TextButton.icon(
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    icon: Icon(
                      e.icon,
                      color: e.color,
                    ),
                    onPressed: () {},
                    label: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(e.count,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          )),
                    ),
                  ))
              .toList(),
        ),
      );

  Widget contents() => Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '이번 포스팅에서는 페트병으로 만든 재밌는 동전지갑이 있어 소개해드리도록 하겠습니다. 비엔나의 디자이너인 Zitta Schnitt가 디자인한 PET 동전지갑입니다. 생김새부터가 귀여운 이 동전지갑은 지퍼와 페트병 그리고 나일론 실, 뾰족한 바늘, 튼튼한 가위만 있으면 만들 수 있습니다.',
              style: TextStyle(fontSize: 16.0, height: 1.5),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                '#재활용',
                style: TextStyle(
                    fontSize: 16.0, height: 1.5, color: Color(0xff33691E)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 20),
              child: Text(
                '2024.02.02',
                style:
                    TextStyle(fontSize: 12.0, height: 1.5, color: Colors.grey),
              ),
            ),
          ],
        ),
      );
}
