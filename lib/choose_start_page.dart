import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import './utils/star_provider.dart';

class ChooseStarPage extends StatefulWidget {
  const ChooseStarPage({super.key});

  @override
  _ChooseStarPageState createState() => _ChooseStarPageState();
}

class _ChooseStarPageState extends State<ChooseStarPage> {
  List<String> teams = ['BTS', 'SEVENTEEN', 'NCT 127'];
  List<String> images = [
    'assets/images/choose_idol_bts.png',
    'assets/images/idol_seventeen2.png',
    'assets/images/idol_nct1272.png',
  ];

  int currentIndex = 0; // Default to first team

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Choose',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 36,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'your',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20,
                  color: Color(0xffc1bebe),
                ),
              ),
              SizedBox(width: 10),
              Text(
                'IDOL',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xfff72fb3),
                ),
              ),
            ],
          ),
          const SizedBox(height: 37),
          SizedBox(
            height: 350,
            child: CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 0.65,
                initialPage: currentIndex,
                enableInfiniteScroll: false,
                height: 350,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
              items: List.generate(teams.length, (index) {
                return Column(
                  children: <Widget>[
                    Container(
                      height: 350,
                      width: 286,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: currentIndex == index
                              ? const Color(0xfff72fb3)
                              : Colors.transparent,
                          width: 2,
                        ),
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: AssetImage(images[index]),
                          fit: BoxFit.cover,
                          colorFilter: currentIndex == index
                              ? null
                              : ColorFilter.mode(
                                  Colors.black.withOpacity(0.3),
                                  BlendMode.darken,
                                ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
          const SizedBox(height: 53),
          Text(
            teams[currentIndex],
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              color: Color(0xff8f8b8b),
            ),
          ),
          const SizedBox(height: 5),
          Container(
            width: 237,
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 0.50,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: Color(0xFFD9D9D9),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(teams.length, (index) {
              return Container(
                margin: const EdgeInsets.all(4.0),
                width: 16.0,
                height: 16.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentIndex == index
                      ? const Color(0xfff72fb3)
                      : const Color(0xFFD9D9D9),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 41),
          MaterialButton(
            minWidth: 290,
            height: 47,
            color: const Color(0xfff72fb3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onPressed: () {
              Provider.of<StarProvider>(context, listen: false).star =
                  teams[currentIndex];
              Navigator.pushNamed(context, '/detail_home');
            },
            child: const Text(
              'NEXT',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
