import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:idolicious/choose_language_page.dart';
import 'package:idolicious/choose_start_page.dart';
import 'package:idolicious/utils/place_provider.dart';
import 'package:idolicious/utils/star_provider.dart';
import 'package:provider/provider.dart';
import './utils/language_provider.dart';
import 'description/description_around.dart';
import 'description/description_main.dart';
import 'detail/detail_home.dart';
import 'detail/detail_photos.dart';
import 'detail/detail_shop.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 1번코드
  await dotenv.load(fileName: ".env");
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => LanguageProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => StarProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => PlaceProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      routes: {
        '/choose_language': (context) => const ChooseLanguagePage(),
        '/choose_star': (context) => const ChooseStarPage(),
        '/detail_home': (context) => const DetailHome(),
        '/detail_photos': (context) => const DetailPhotos(),
        '/detail_shop': (context) => const DetailShop(),
        '/description_main': (context) => const DescriptionMain(),
        '/description_around': (context) => const DescriptionAround(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/choose_language');
      // Navigator.pushReplacementNamed(context, '/description_main');
      // Navigator.pushReplacementNamed(context, '/detail_home');
      // Navigator.pushReplacementNamed(context, '/description_around');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff72fb3),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash/background_image.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                  'assets/images/splash/logo_splash.png'), // 로고 이미지를 넣어주세요.
              const SizedBox(height: 100),
              Text(
                'All the favorite of K-POP IDOLS', // 여기에 슬로건을 넣어주세요.
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.25),
                      offset: const Offset(0, 4),
                      blurRadius: 3,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
