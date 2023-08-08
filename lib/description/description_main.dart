import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DescriptionMain extends StatefulWidget {
  const DescriptionMain({super.key});

  @override
  State<DescriptionMain> createState() => _DescriptionMainState();
}

class _DescriptionMainState extends State<DescriptionMain> {
  // current index
  int mainPhotoIndex = 0;
  bool isLiked = false;
  Map<String, dynamic>? placeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadData(context);
  }

  Future<Map<String, dynamic>?> loadData(BuildContext context) async {
    final String code = ModalRoute.of(context)?.settings.arguments as String;
    print(code);

    // 1. CSV 파일 로드
    final data = await rootBundle.loadString('assets/data/bts_detail.csv');
    List<List<dynamic>> csvTable = const CsvToListConverter().convert(
      data,
      eol: '\n',
      fieldDelimiter: '\t',
    );

    for (List<dynamic> row in csvTable) {
      if (row[0] == code) {
        String name = row[1];
        List<String> mainPhotos = (row[2] as String)
            .substring(1, (row[2] as String).length - 1)
            .split(',')
            .map((e) => e.trim().replaceAll('"', ''))
            .toList();
        String description = row[3];
        List<String> subPhotos = (row[4] as String)
            .substring(1, (row[4] as String).length - 1)
            .split(',')
            .map((e) => e.trim().replaceAll('"', ''))
            .toList();
        List<String> idols = (row[5] as String)
            .substring(1, (row[5] as String).length - 1)
            .split(',')
            .map((e) => e.trim().replaceAll('"', ''))
            .toList();
        String location = row[6];
        double latitude = row[7];
        double longitude = row[8];
        String phone = row[9];
        String startTime = "10 AM";
        String endTime = "10 PM";
        placeData = {
          'name': name,
          'mainPhotos': mainPhotos,
          'description': description,
          'subPhotos': subPhotos,
          'idols': idols,
          'location': location,
          'latitude': latitude,
          'longitude': longitude,
          'phone': phone,
          'startTime': startTime,
          'endTime': endTime,
        };

        break;
      }
    }
    return placeData;
  }

  void flushData() {
    placeData = null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadData(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 로딩 중이면 로딩 인디케이터 표시
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // 오류 발생 시
            return const Text('An error occurred');
          } else {
            // 데이터가 준비되면 UI 구성
            final placeData = snapshot.data;
            final String name = placeData?['name'];
            final List<String> mainPhotos = placeData?['mainPhotos'];
            final String description = placeData?['description'];
            final List<String> subPhotos = placeData?['subPhotos'];
            final List<String> idols = placeData?['idols'];
            final String location = placeData?['location'];
            final double latitude = placeData?['latitude'];
            final double longitude = placeData?['longitude'];
            final String phone = placeData?['phone'];
            final String startTime = placeData?['startTime'];
            final String endTime = placeData?['endTime'];

            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    // flush datas
                    flushData();
                    Navigator.pop(context);
                  },
                ),
                title: const Text(
                  "IDOLICIOUS",
                  style: TextStyle(
                    color: Color(0xffF72FB3),
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.share,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      // 공유 기능 추가
                    },
                  ),
                ],
              ),
              body: ListView(
                children: [
                  Column(
                    children: [
                      buildImageSlider(mainPhotos),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          children: [
                            buildRestaurantInfo(name, description),
                            const SizedBox(height: 40),
                            buildPhotoSection(subPhotos),
                            const SizedBox(height: 40),
                            buildIdolInfo(idols),
                            const SizedBox(height: 40),
                            buildReviewSection(),
                            const SizedBox(height: 40),
                            buildMapInfo(latitude, longitude, location, phone,
                                startTime, endTime),
                            const SizedBox(height: 40),
                            buildAroundInfoButton(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        });
  }

  Widget buildImageSlider(List<String>? imageUrls) {
    List sampleImagesUrl = [
      'https://t1.daumcdn.net/cfile/tistory/99AB42375F85685F01',
      'https://pbs.twimg.com/media/EP1DCIBVAAAMY4z.jpg',
      'https://mblogthumb-phinf.pstatic.net/MjAyMTA4MDVfMjIx/MDAxNjI4MTY2MDQyNTM0.lGpNC8dwTTQJAyy-8L08i3-77E7nKE22rkMdE6-pZTEg.8iS9F5XFXYmTH0J7oOh2Asr6u2S3BdxF7ubdgw7RlYEg.JPEG.lantern/IMG_8681.jpg?type=w800',
      'https://mblogthumb-phinf.pstatic.net/MjAxOTEyMjlfMTQx/MDAxNTc3NjA2NTE4MDU1.P4x4bCHRjVQSfsVpBsAZKDkPldZzHWPvUAQXXYMMcq8g.h6RpuikRBk4osy9dfGnVTOeifpGZzvrne6s6tqUeqGEg.JPEG.kakoi77/IMG_6962.jpg?type=w800',
      'https://mblogthumb-phinf.pstatic.net/MjAyMTAzMDFfMjAx/MDAxNjE0NTMwNDYyMjU5.ONPfMYVSfKQZCgCltY2h-p7QAPw6pHpK_GYEKsUQ_cQg.Rivhxd02_AiiOskjloBdXp2Xi2EghV0AuY1XGmy_sLcg.PNG.goldenpark/%EB%8C%80%EA%B2%8C%ED%9A%9F%EC%A7%9101.png?type=w800'
    ];

    if (imageUrls == null || imageUrls.isEmpty) return const SizedBox();

    Widget buildIndicator() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imageUrls.map((url) {
          int index = imageUrls.indexOf(url);
          return Container(
            width: 8.0,
            height: 8.0,
            margin: const EdgeInsets.symmetric(horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: mainPhotoIndex == index
                  ? const Color(0xffF72FB3)
                  : Colors.white,
            ),
          );
        }).toList(),
      );
    }

    return Stack(children: [
      CarouselSlider(
        items: imageUrls.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return Image.network(
                item,
                fit: BoxFit.cover,
                width: double.infinity,
              ); // asset 이미지를 사용할 경우
            },
          );
        }).toList(),
        options: CarouselOptions(
          height: 300.0,
          autoPlay: false,
          enlargeCenterPage: false,
          enableInfiniteScroll: false,
          viewportFraction: 1.0,
          aspectRatio: 3.0,
          onPageChanged: (index, reason) {
            // 여기서 circular indicator 상태 변경 로직 추가
            setState(() {
              mainPhotoIndex = index;
            });
          },
        ),
      ),
      Positioned(
        bottom: 10,
        // left: 0,
        right: 10,
        child: buildIndicator(),
      ),
    ]);
  }

  Widget buildRestaurantInfo(String? name, String? description) {
    if (name == null || description == null) return const SizedBox();
    if (name.isEmpty || description.isEmpty) return const SizedBox();
    // 식당 정보 및 좋아요 버튼 구현
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name, // 실제 데이터로 대체해야 합니다.
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: -1,
              ),
            ),
            IconButton(
              icon: isLiked
                  ? const Icon(
                      Icons.favorite,
                      color: Color(0xffF72FB3),
                    )
                  : const Icon(
                      Icons.favorite_border,
                      color: Color(0xffF72FB3),
                    ), // 좋아요가 아닌 경우
              // icon: Icon(Icons.favorite), // 좋아요인 경우
              onPressed: () {
                // 좋아요 기능 로직
                setState(() {
                  isLiked = !isLiked;
                });
              },
            ),
          ],
        ),
        Container(
          width: double.infinity,
          alignment: Alignment.centerLeft,
          child: Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black.withOpacity(0.6),
              wordSpacing: 1,
              height: 2,
            ),
          ),
        )
      ],
    );
  }

  Widget buildPhotoSection(List<String>? imageUrls) {
    List sampleImagesUrl = [
      'https://t1.daumcdn.net/cfile/tistory/99AB42375F85685F01',
      'https://pbs.twimg.com/media/EP1DCIBVAAAMY4z.jpg',
      'https://mblogthumb-phinf.pstatic.net/MjAyMTA4MDVfMjIx/MDAxNjI4MTY2MDQyNTM0.lGpNC8dwTTQJAyy-8L08i3-77E7nKE22rkMdE6-pZTEg.8iS9F5XFXYmTH0J7oOh2Asr6u2S3BdxF7ubdgw7RlYEg.JPEG.lantern/IMG_8681.jpg?type=w800',
      'https://mblogthumb-phinf.pstatic.net/MjAxOTEyMjlfMTQx/MDAxNTc3NjA2NTE4MDU1.P4x4bCHRjVQSfsVpBsAZKDkPldZzHWPvUAQXXYMMcq8g.h6RpuikRBk4osy9dfGnVTOeifpGZzvrne6s6tqUeqGEg.JPEG.kakoi77/IMG_6962.jpg?type=w800',
      'https://mblogthumb-phinf.pstatic.net/MjAyMTAzMDFfMjAx/MDAxNjE0NTMwNDYyMjU5.ONPfMYVSfKQZCgCltY2h-p7QAPw6pHpK_GYEKsUQ_cQg.Rivhxd02_AiiOskjloBdXp2Xi2EghV0AuY1XGmy_sLcg.PNG.goldenpark/%EB%8C%80%EA%B2%8C%ED%9A%9F%EC%A7%9101.png?type=w800'
    ];

    if (imageUrls == null || imageUrls.isEmpty) return const SizedBox();
    // 가로로 스크롤 가능한 사진 섹션 구현
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'PICTURE',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: imageUrls.map((item) {
              return Container(
                margin: const EdgeInsets.only(right: 5),
                child: Image.network(
                  item,
                  fit: BoxFit.cover,
                  width: 200,
                  height: 150,
                ),
              );
            }).toList()),
          )
        ],
      ),
    );
  }

  Widget buildIdolInfo(List<String>? idols) {
    if (idols == null || idols.isEmpty) return const SizedBox();
    // 아이돌 관련 정보 구현
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'WHICH IDOL HAS BEEN TO THIS PLACE?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: idols.map((item) {
                return Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    child: Text(
                      '+ $item',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -1,
                          color: Colors.black.withOpacity(0.7)),
                    ),
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget buildReviewSection() {
    // sample review data
    // data에는 사용자 id, 별점, 리뷰 내용, thumbnail 사진 url, avatar url 포함
    List<Map<String, dynamic>> sampleReviews = [
      {
        'id': 'JEWEL',
        'content': 'Great Place!',
        'star': 5.0,
        'thumbnail': 'https://t1.daumcdn.net/cfile/tistory/99AB42375F85685F01',
        'avatar': 'https://i.pravatar.cc/100'
      },
      {
        'id': 'Chris',
        'content': 'I feel JIN',
        'star': 4.0,
        'thumbnail': 'https://pbs.twimg.com/media/EP1DCIBVAAAMY4z.jpg',
        'avatar': 'https://i.pravatar.cc/100'
      },
    ];
    // 아이돌 관련 정보 구현
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'LATEST REVIEWS',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
                children: sampleReviews.map((item) {
              return Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(item['avatar']),
                          radius: 20,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                item['id'],
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: -1,
                                    color: Colors.black.withOpacity(0.7)),
                              ),
                              const SizedBox(width: 10),
                              Row(
                                children: List.generate(
                                  5,
                                  (index) => Icon(
                                    Icons.star,
                                    color: index < item['star']
                                        ? Colors.amber
                                        : Colors.grey,
                                    size: 16,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 200,
                            child: Text(
                              item['content'],
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -1,
                                  color: Colors.black.withOpacity(0.7)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 50,
                        child: Image.network(
                          item['thumbnail'],
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList()),
          )
        ],
      ),
    );
  }

  Widget buildMapInfo(double? latitude, double? longitude, String? location,
      String? phone, String? startTime, String? endTime) {
    String mapApiKey = dotenv.get('GOOGLE_MAP_API_KEY');
    if (latitude == null ||
        longitude == null ||
        location == null ||
        phone == null ||
        startTime == null ||
        endTime == null) return const SizedBox();

    LatLng initialLocation = LatLng(latitude, longitude);

    // 지도 및 상세 정보 구현
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'INFORMATION',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: -1,
              color: Color(0xffF72FB3),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 250,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: initialLocation,
                zoom: 15,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('initialLocation'),
                  position: initialLocation,
                )
              },
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.grey,
                      size: 16,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Location: $location',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.6),
                        wordSpacing: 0,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.phone,
                      color: Colors.grey,
                      size: 16,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Phone: $phone',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.6),
                        wordSpacing: 0,
                        height: 2,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: Colors.grey,
                      size: 16,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Open: $startTime - $endTime',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.6),
                        wordSpacing: 0,
                        height: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildAroundInfoButton() {
    // 주변 정보 버튼 구현
    return MaterialButton(
      minWidth: 290,
      height: 47,
      color: const Color(0xfff72fb3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onPressed: () {},
      child: const Text(
        'WHAT IS AROUND',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
