import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:idolicious/widgets/home_bottom_navbar.dart';

class DetailPhotos extends StatefulWidget {
  const DetailPhotos({super.key});

  @override
  _DetailPhotosState createState() => _DetailPhotosState();
}

class _DetailPhotosState extends State<DetailPhotos> {
  late Future<List<Map<String, dynamic>>> yumData;
  late Future<List<Map<String, dynamic>>> visitData;

  @override
  void initState() {
    super.initState();
    yumData = loadYumCsvData();
    visitData = loadVisitCsvData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 60,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "PHOTO",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                        color: Color(0xfff72fb3),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    width: 170,
                    height: 20,
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
                        // Uncomment below once functionality is added
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
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: Future.wait([yumData, visitData])
                  .then((lists) => lists.expand((list) => list).toList()),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                var data = snapshot.data!;
                return SingleChildScrollView(
                    child: StaggeredGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  children: [
                    for (var i = 0; i < data.length; i++)
                      if (i % 3 == 2)
                        StaggeredGridTile.count(
                            crossAxisCellCount: 2,
                            mainAxisCellCount: 1,
                            child: buildImageWidget(data[i]['Image'], i))
                      else
                        buildImageWidget(data[i]['Image'], i),
                  ],
                ));
              },
            ),
          ),
        ]),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }

  Widget buildImageWidget(String? imagePath, int index) {
    return GestureDetector(
      onTap: () {
        // navigate to detail page
      },
      child: Image.network(
        imagePath!,
        height: index % 3 == 2 ? 200 : 200,
        fit: BoxFit.cover,
      ),
    );
  }

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
}
