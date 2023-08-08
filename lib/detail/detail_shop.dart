import 'package:flutter/material.dart';

class DetailShop extends StatelessWidget {
  const DetailShop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pushNamed(context, '/detail_home'),
        ),
        title: const Text(
          "IDOLICIOUS",
          style: TextStyle(
            color: Color(0xffF72FB3),
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0, // Shadow 제거
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage("assets/images/detail/temp_shop.png"), // 배경 이미지 경로
            fit: BoxFit.fitWidth, // 이미지가 화면에 꽉 차게 표시
          ),
        ),
      ),
    );
  }
}
