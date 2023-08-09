import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFFF72FB3),
      currentIndex: currentIndex,
      onTap: (index) {
        if (index == currentIndex) return;

        if (index == 2) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text("Notice"),
                    content: const Text("sorry, this feature is not ready yet"),
                    actions: [
                      TextButton(
                        child: const Text("OK"),
                        onPressed: () => Navigator.of(context).pop(),
                      )
                    ],
                  ));
          return;
        }

        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/detail_home');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/detail_photos');
            break;
          case 3:
            Navigator.pushReplacementNamed(context, '/detail_shop');
        }
      },
      items: [
        // [BottomNavigationBarItem의 코드는 위와 동일하므로 생략]
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/icons/icon_home.png',
              color: currentIndex == 0 ? Colors.white : Colors.white),
          label: 'home',
          backgroundColor: const Color(0xFFF72FB3),
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/icons/icon_insta.png',
              color: currentIndex == 1 ? Colors.white : Colors.white),
          label: 'photos',
          backgroundColor: const Color(0xFFF72FB3),
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/icons/icon_pin.png',
              color: currentIndex == 2 ? Colors.white : Colors.white),
          label: 'pin',
          backgroundColor: const Color(0xFFF72FB3),
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/icons/icon_bag.png',
              color: currentIndex == 3 ? Colors.white : Colors.white),
          label: 'bag',
          backgroundColor: const Color(0xFFF72FB3),
        ),
      ],
    );
  }
}
