import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './utils/language_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ChooseLanguagePage extends StatefulWidget {
  const ChooseLanguagePage({super.key});

  @override
  _ChooseLanguagePageState createState() => _ChooseLanguagePageState();
}

class _ChooseLanguagePageState extends State<ChooseLanguagePage> {
  List<String> languages = [
    'French',
    'Korean',
    'English',
    'Japaness',
    'German'
  ];
  List<String> images = [
    'assets/images/french.png',
    'assets/images/korean.png',
    'assets/images/english.png',
    'assets/images/japaness.png',
    'assets/images/german.png',
  ];

  int currentIndex = 0; // Default to English

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 50),
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
                'LANGUAGE',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xfff72fb3),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          SizedBox(
            child: CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 0.64,
                initialPage: currentIndex,
                enableInfiniteScroll: false,
                height: 350,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
              items: List.generate(languages.length, (index) {
                return Column(
                  children: <Widget>[
                    const SizedBox(height: 20),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // 투명한 원
                        Transform.scale(
                          scale: (currentIndex == index) ? 1.08 : 1.0,
                          child: Container(
                            height: 254, // 이 값을 조정하여 원의 지름을 조절할 수 있습니다.
                            width: 254, // 이 값을 조정하여 원의 지름을 조절할 수 있습니다.
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: (currentIndex ==
                                        index) // 현재 페이지만 테두리 색깔을 지정
                                    ? const Color(0xfff72fb3)
                                    : Colors.transparent, // 다른 페이지는 투명한 테두리
                                width: 2, // 테두리 두께
                              ),
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(0, 2),
                          child: Container(
                            height: 254,
                            width: 254,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(images[index]),
                                fit: BoxFit.cover,
                              ),
                              boxShadow: null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),
          ),

          Text(
            languages[currentIndex],
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
          // circular indicator 선택 인덱스만 색깔있음.
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(languages.length, (index) {
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

          const SizedBox(height: 46),
          MaterialButton(
            minWidth: 290,
            height: 47,
            color: const Color(0xfff72fb3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onPressed: () {
              Provider.of<LanguageProvider>(context, listen: false).language =
                  languages[currentIndex];
              Navigator.pushNamed(
                  context, '/choose_star'); // Navigate to home page
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
