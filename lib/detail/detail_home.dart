import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'package:idolicious/widgets/home_bottom_navbar.dart';
import 'package:provider/provider.dart';
import '../utils/star_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Map<String, dynamic>>> loadYumCsvData() async {
  final rawData = await rootBundle.loadString('assets/data/bts_yum.csv');
  final listData = const CsvToListConverter().convert(rawData, eol: '\n');

  List<Map<String, dynamic>> yumData = [];

  for (int i = 1; i < listData.length; i++) {
    yumData.add({
      'num': listData[i][0],
      'Restaurant': listData[i][1],
      'Description': listData[i][2],
      'Location': listData[i][3],
      'Image': listData[i][4],
    });
  }

  // print("yumData: $yumData");
  return yumData;
}

Future<List<Map<String, dynamic>>> loadVisitCsvData() async {
  final rawData = await rootBundle.loadString('assets/data/bts_visit.csv');
  final listData = const CsvToListConverter().convert(rawData, eol: '\n');

  List<Map<String, dynamic>> yumData = [];

  for (int i = 1; i < listData.length; i++) {
    yumData.add({
      'num': listData[i][0],
      'Visit': listData[i][1],
      'Description': listData[i][2],
      'Location': listData[i][3],
      'Image': listData[i][4],
    });
  }

  // print("yumData: $yumData");
  return yumData;
}

class DetailHome extends StatelessWidget {
  const DetailHome({super.key}); // 나중에 이 값을 파라미터로 받을 수 있게 수정하세요.

  @override
  Widget build(BuildContext context) {
    final idolName = Provider.of<StarProvider>(context, listen: false).star;

    return Scaffold(
      body: SafeArea(
        left: false,
        right: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              // Top bar with title and search
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "  IDOLICOUS",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                      color: Color(0xfff72fb3),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    width: 170,
                    height: 30,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Find Location",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        // IconButton(
                        //   onPressed: null,
                        //   icon: Icon(
                        //     size: 18,
                        //     Icons.search,
                        //     color: Colors.grey,
                        //   ),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              // Artist main image
              SizedBox(
                width: double.infinity,
                child: Image.asset(
                  'assets/images/detail/bts.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 15),
              // About artist
              SizedBox(
                width: double.infinity,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "ABOUT ARTIST: ",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            'BTS',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: Color(0xfff72fb3),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'BTS also known as the Bangtan Boys, is a South Korean boy band formed in 2010. The band consists of Jin, Suga, J-Hope, RM, Jimin, V, and Jungkook, ...',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 100),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                width: double.infinity,
                child: const Text(
                  "PLACE BTS YUM YUM",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Place YUMYUM
              FutureBuilder<List<Map<String, dynamic>>>(
                future: loadYumCsvData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: snapshot.data!.map((data) {
                          return SizedBox(
                            width: 250,
                            height: 300,
                            child: Column(
                              children: [
                                Image.network(
                                  data['Image'] ?? '',
                                  width: 240,
                                  height: 150,
                                  fit: BoxFit.fill,
                                ),
                                const SizedBox(height: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      data['Restaurant'] ?? '',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: Color(0xff868181),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      data['Description'] ?? '',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      data['Location'] ?? '',
                                      style: const TextStyle(
                                          color: Color(0xff868181),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Text("Error loading data");
                  } else {
                    return const CircularProgressIndicator(); // 로딩 중일 때 보여줄 위젯
                  }
                },
              ),
              const SizedBox(height: 30),
              // Place visit
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                width: double.infinity,
                child: const Text(
                  "PLACE BTS VISIT",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: loadVisitCsvData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: snapshot.data!.map((data) {
                          return SizedBox(
                            width: 250,
                            height: 300,
                            child: Column(
                              children: [
                                Image.network(
                                  data['Image'] ?? '',
                                  width: 240,
                                  height: 150,
                                  fit: BoxFit.fill,
                                ),
                                const SizedBox(height: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      data['Visit'] ?? '',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: Color(0xff868181),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      data['Description'] ?? '',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      data['Location'] ?? '',
                                      style: const TextStyle(
                                          color: Color(0xff868181),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Text("Error loading data");
                  } else {
                    return const CircularProgressIndicator(); // 로딩 중일 때 보여줄 위젯
                  }
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }
}
