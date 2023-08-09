import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DescriptionAround extends StatefulWidget {
  const DescriptionAround({super.key});

  @override
  State<DescriptionAround> createState() => _DescriptionAroundState();
}

class _DescriptionAroundState extends State<DescriptionAround> {
  // current index
  int mainPhotoIndex = 0;
  bool isLiked = false;
  Map<String, dynamic>? placeData;
  // 0 -> 관광지, 1 -> 문화 생활, 2 -> 축제
  int whichPlace = 0;

  List<Map<String, String>> tourList = [
    {
      "addr1": "35, Dogok-ro 25-gil, Gangnam-gu, Seoul",
      "addr2": "(Yeoksam-dong)",
      "areacode": "1",
      "booktour": "0",
      "cat1": "A02",
      "cat2": "A0201",
      "cat3": "A02010800",
      "contentid": "2782188",
      "contenttypeid": "12",
      "createdtime": "20211126233418",
      "dist": "898.255061898842",
      "firstimage":
          "http://tong.visitkorea.or.kr/cms/resource/18/2782218_image2_1.jpg",
      "firstimage2":
          "http://tong.visitkorea.or.kr/cms/resource/18/2782218_image2_1.jpg",
      "cpyrhtDivCd": "Type3",
      "mapx": "127.0403007532",
      "mapy": "37.4949275628",
      "mlevel": "6",
      "modifiedtime": "20221025105356",
      "sigungucode": "1",
      "tel": "",
      "title": "Buddhist Chongji Temple"
    },
    {
      "addr1": "1, Seolleung-ro 100-gil, Gangnam-gu, Seoul",
      "addr2": "",
      "areacode": "1",
      "booktour": "0",
      "cat1": "A02",
      "cat2": "A0201",
      "cat3": "A02010700",
      "contentid": "126525",
      "contenttypeid": "12",
      "createdtime": "20020510090000",
      "dist": "999.1638958836307",
      "firstimage":
          "https://royaltombs.cha.go.kr/new/images/content/gallery/story01/st38_04.jpg",
      "firstimage2": "",
      "cpyrhtDivCd": "",
      "mapx": "127.0471803291",
      "mapy": "37.5074206801",
      "mlevel": "6",
      "modifiedtime": "20230610054144",
      "sigungucode": "1",
      "tel": "",
      "title": "Seoneung and Jungneung [UNESCO]"
    },
    {
      "addr1": "611 Nonhyeon-ro, Gangnam-gu, Seoul",
      "addr2": "",
      "areacode": "1",
      "booktour": "0",
      "cat1": "A02",
      "cat2": "A0202",
      "cat3": "A02020300",
      "contentid": "2646372",
      "contenttypeid": "12",
      "createdtime": "20200203194006",
      "dist": "735.190183003982",
      "firstimage":
          "http://tong.visitkorea.or.kr/cms/resource/67/2646367_image2_1.bmp",
      "firstimage2":
          "http://tong.visitkorea.or.kr/cms/resource/67/2646367_image2_1.bmp",
      "cpyrhtDivCd": "Type3",
      "mapx": "127.0331260275",
      "mapy": "37.5082981035",
      "mlevel": "6",
      "modifiedtime": "20230525091544",
      "sigungucode": "1",
      "tel": "",
      "title": "Spa Escape"
    },
    {
      "addr1": "24, Nonhyeon-ro 79-gil, Gangnam-gu, Seoul",
      "addr2": "(Yeoksam-dong)",
      "areacode": "1",
      "booktour": "0",
      "cat1": "A02",
      "cat2": "A0202",
      "cat3": "A02020700",
      "contentid": "2752545",
      "contenttypeid": "12",
      "createdtime": "20211001230007",
      "dist": "574.5411689635109",
      "firstimage":
          "https://tong.visitkorea.or.kr/cms/resource/27/2768827_image2_1.jpg",
      "firstimage2": "",
      "cpyrhtDivCd": "",
      "mapx": "127.0363010397",
      "mapy": "37.4976521744",
      "mlevel": "6",
      "modifiedtime": "20230403112623",
      "sigungucode": "1",
      "tel": "",
      "title": "Yeoksamgaenari Park"
    },
    {
      "addr1": "23-11, Eonju-ro 85-gil, Gangnam-gu, Seoul",
      "addr2": "(Yeoksam-dong)",
      "areacode": "1",
      "booktour": "0",
      "cat1": "A02",
      "cat2": "A0201",
      "cat3": "A02010900",
      "contentid": "2733864",
      "contenttypeid": "12",
      "createdtime": "20210813222255",
      "dist": "445.54636084820504",
      "firstimage":
          "http://tong.visitkorea.or.kr/cms/resource/67/2779567_image2_1.jpg",
      "firstimage2":
          "http://tong.visitkorea.or.kr/cms/resource/67/2779567_image2_1.jpg",
      "cpyrhtDivCd": "Type3",
      "mapx": "127.0418004571",
      "mapy": "37.5005436041",
      "mlevel": "6",
      "modifiedtime": "20221212142508",
      "sigungucode": "1",
      "tel": "",
      "title": "Yeoksamdong Cathedral"
    },
    {
      "addr1": "SaeRom Building, 551 Seolleung-ro, Gangnam-gu, Seoul",
      "addr2": "4th floor",
      "areacode": "1",
      "booktour": "0",
      "cat1": "A02",
      "cat2": "A0204",
      "cat3": "A02040800",
      "contentid": "2553883",
      "contenttypeid": "12",
      "createdtime": "20180717024103",
      "dist": "890.7525097767344",
      "firstimage":
          "https://www.korea.kr/goNewsRes/attaches/editor/2017.10/29/20171029171256318_6DMB2YX6.jpg",
      "firstimage2": "",
      "cpyrhtDivCd": "",
      "mapx": "127.0452332695",
      "mapy": "37.5079150324",
      "mlevel": "6",
      "modifiedtime": "20220512173838",
      "sigungucode": "23",
      "tel": "",
      "title": "FabLab Seoul"
    }
  ];

  List<Map<String, String>> curtureList = [
    {
      "addr1": "36, Teheran-ro 8-gil, Gangnam-gu, Seoul",
      "addr2": "",
      "areacode": "1",
      "booktour": "0",
      "cat1": "A02",
      "cat2": "A0206",
      "cat3": "A02060700",
      "contentid": "130373",
      "contenttypeid": "14",
      "createdtime": "20071106105448",
      "dist": "850.7156748419164",
      "firstimage":
          "http://tong.visitkorea.or.kr/cms/resource/87/1807787_image2_1.jpg",
      "firstimage2":
          "http://tong.visitkorea.or.kr/cms/resource/87/1807787_image3_1.jpg",
      "cpyrhtDivCd": "Type3",
      "mapx": "127.0320236842",
      "mapy": "37.4964911212",
      "mlevel": "6",
      "modifiedtime": "20230423054733",
      "sigungucode": "1",
      "tel": "",
      "title": "Gangnam Cultural Center"
    },
    {
      "addr1": "32, Teheran-ro 7-gil, Gangnam-gu, Seoul",
      "addr2": "(Yeoksam-dong)",
      "areacode": "1",
      "booktour": "0",
      "cat1": "A02",
      "cat2": "A0206",
      "cat3": "A02061100",
      "contentid": "596511",
      "contenttypeid": "14",
      "createdtime": "20080728225036",
      "dist": "655.4918679187768",
      "firstimage":
          "http://tong.visitkorea.or.kr/cms/resource/77/919177_image2_1.jpg",
      "firstimage2":
          "http://tong.visitkorea.or.kr/cms/resource/77/919177_image3_1.jpg",
      "cpyrhtDivCd": "Type3",
      "mapx": "127.0302792433",
      "mapy": "37.5019710091",
      "mlevel": "6",
      "modifiedtime": "20230215160728",
      "sigungucode": "1",
      "tel": "",
      "title": "Kukkiwon (World Taekwondo Center)"
    },
    {
      "addr1": "Pavilion, 817-35 Yeoksam-dong, Gangnam-gu, Seoul, Korea",
      "addr2": "",
      "areacode": "1",
      "booktour": "",
      "cat1": "A02",
      "cat2": "A0203",
      "cat3": "A02030400",
      "contentid": "2946536",
      "contenttypeid": "14",
      "createdtime": "20230131135201",
      "dist": "879.6865139251905",
      "firstimage":
          "http://tong.visitkorea.or.kr/cms/resource/31/2947031_image2_1.jpg",
      "firstimage2":
          "http://tong.visitkorea.or.kr/cms/resource/31/2947031_image3_1.jpg",
      "cpyrhtDivCd": "Type1",
      "mapx": "127.0279961508",
      "mapy": "37.5007905496",
      "mlevel": "6",
      "modifiedtime": "20230206111130",
      "sigungucode": "1",
      "tel": "",
      "title": "Bultun Gangnam Station Branch"
    },
    {
      "addr1": "Centerfield, 676 Yeoksam-dong, Gangnam-gu, Seoul, Korea",
      "addr2": "",
      "areacode": "1",
      "booktour": "",
      "cat1": "A02",
      "cat2": "A0205",
      "cat3": "A02050600",
      "contentid": "2945612",
      "contenttypeid": "14",
      "createdtime": "20230128013357",
      "dist": "340.68620870279887",
      "firstimage":
          "http://tong.visitkorea.or.kr/cms/resource/96/2947796_image2_1.jpg",
      "firstimage2":
          "http://tong.visitkorea.or.kr/cms/resource/96/2947796_image3_1.jpg",
      "cpyrhtDivCd": "Type1",
      "mapx": "127.0414226547",
      "mapy": "37.5026239118",
      "mlevel": "6",
      "modifiedtime": "20230208132717",
      "sigungucode": "1",
      "tel": "",
      "title": "Centerfield"
    },
    {
      "addr1": "337, Eonju-ro, Gangnam-gu, Seoul",
      "addr2": "(Yeoksam-dong)",
      "areacode": "1",
      "booktour": "0",
      "cat1": "A02",
      "cat2": "A0206",
      "cat3": "A02060600",
      "contentid": "1188653",
      "contenttypeid": "14",
      "createdtime": "20110128014321",
      "dist": "803.0372437252056",
      "firstimage":
          "http://tong.visitkorea.or.kr/cms/resource/34/1837534_image2_1.jpg",
      "firstimage2":
          "http://tong.visitkorea.or.kr/cms/resource/34/1837534_image3_1.jpg",
      "cpyrhtDivCd": "Type3",
      "mapx": "127.0443114151",
      "mapy": "37.4978884026",
      "mlevel": "6",
      "modifiedtime": "20230120145529",
      "sigungucode": "1",
      "tel": "",
      "title": "Yerimdang Art Hall"
    },
    {
      "addr1": "41, Gangnam-daero 102-gil, Gangnam-gu, Seoul, Korea",
      "addr2": "(Yeoksam-dong)",
      "areacode": "1",
      "booktour": "0",
      "cat1": "A02",
      "cat2": "A0206",
      "cat3": "A02060500",
      "contentid": "2751869",
      "contenttypeid": "14",
      "createdtime": "20210930192140",
      "dist": "852.7764204230081",
      "firstimage":
          "https://tong.visitkorea.or.kr/cms/resource/68/2768968_image2_1.jpg",
      "firstimage2": "",
      "cpyrhtDivCd": "",
      "mapx": "127.0280655089",
      "mapy": "37.5036207781",
      "mlevel": "6",
      "modifiedtime": "20221226113618",
      "sigungucode": "1",
      "tel": "",
      "title": "United Gallery"
    },
    {
      "addr1": "12, Teheran-ro 26-gil, Gangnam-gu, Seoul",
      "addr2": "Little Star Building 2,3F (Yeoksam-dong)",
      "areacode": "1",
      "booktour": "0",
      "cat1": "A02",
      "cat2": "A0206",
      "cat3": "A02060800",
      "contentid": "231962",
      "contenttypeid": "14",
      "createdtime": "20070824090000",
      "dist": "397.8277827925673",
      "firstimage":
          "http://tong.visitkorea.or.kr/cms/resource/77/684077_image2_1.jpg",
      "firstimage2":
          "http://tong.visitkorea.or.kr/cms/resource/77/684077_image3_1.jpg",
      "cpyrhtDivCd": "Type3",
      "mapx": "127.0358454756",
      "mapy": "37.4994241830",
      "mlevel": "6",
      "modifiedtime": "20220524175607",
      "sigungucode": "1",
      "tel": "",
      "title": "Istanbul Cultural Center"
    },
    {
      "addr1": "Jinwoo Building, 426 Gangnam-daero, Gangnam-gu, Seoul",
      "addr2": "(Yeoksam-dong)",
      "areacode": "1",
      "booktour": "",
      "cat1": "A02",
      "cat2": "A0203",
      "cat3": "A02030400",
      "contentid": "2994661",
      "contenttypeid": "14",
      "createdtime": "20230719163613",
      "dist": "989.0697939430261",
      "firstimage":
          "http://tong.visitkorea.or.kr/cms/resource/82/2713482_image2_1.jpg",
      "firstimage2":
          "http://tong.visitkorea.or.kr/cms/resource/82/2713482_image3_1.jpg",
      "cpyrhtDivCd": "Type3",
      "mapx": "127.0267768219",
      "mapy": "37.5006349909",
      "mlevel": "6",
      "modifiedtime": "20230720105653",
      "sigungucode": "1",
      "tel": "",
      "title": "Gaps in the routine"
    },
    {
      "addr1":
          "Korea Intellectual Property Center, 131 Teheran-ro, Gangnam-gu, Seoul",
      "addr2": "3rd floor",
      "areacode": "1",
      "booktour": "0",
      "cat1": "A02",
      "cat2": "A0206",
      "cat3": "A02060900",
      "contentid": "719514",
      "contenttypeid": "14",
      "createdtime": "20090413202847",
      "dist": "502.59420571377217",
      "firstimage":
          "http://tong.visitkorea.or.kr/cms/resource/02/1807802_image2_1.jpg",
      "firstimage2":
          "http://tong.visitkorea.or.kr/cms/resource/02/1807802_image3_1.jpg",
      "cpyrhtDivCd": "Type3",
      "mapx": "127.0329540519",
      "mapy": "37.5001351590",
      "mlevel": "6",
      "modifiedtime": "20230410111028",
      "sigungucode": "1",
      "tel": "",
      "title": "Intellectual Property Library"
    },
    {
      "addr1": "120, Bongeunsa-ro, Gangnam-gu, Seoul",
      "addr2": "(Yeoksam-dong)",
      "areacode": "1",
      "booktour": "0",
      "cat1": "A02",
      "cat2": "A0206",
      "cat3": "A02060300",
      "contentid": "2754756",
      "contenttypeid": "14",
      "createdtime": "20211008001004",
      "dist": "924.0481217870729",
      "firstimage":
          "http://tong.visitkorea.or.kr/cms/resource/85/2790285_image2_1.jpg",
      "firstimage2":
          "http://tong.visitkorea.or.kr/cms/resource/85/2790285_image2_1.jpg",
      "cpyrhtDivCd": "Type3",
      "mapx": "127.0275460770",
      "mapy": "37.5048595138",
      "mlevel": "6",
      "modifiedtime": "20230125130608",
      "sigungucode": "1",
      "tel": "",
      "title": "MContemporary"
    }
  ];

  List<Map<String, String>> festivalList = [
    {
      "addr1": "COEX, 513 Yeongdong-daero, Gangnam-gu, Seoul",
      "addr2": "",
      "areacode": "1",
      "booktour": "",
      "cat1": "A02",
      "cat2": "A0207",
      "cat3": "A02070200",
      "contentid": "737479",
      "contenttypeid": "15",
      "createdtime": "20090521185913",
      "dist": "2176.576767029108",
      "firstimage":
          "http://tong.visitkorea.or.kr/cms/resource/24/2853024_image2_1.jpg",
      "firstimage2":
          "http://tong.visitkorea.or.kr/cms/resource/24/2853024_image3_1.jpg",
      "cpyrhtDivCd": "Type3",
      "mapx": "127.0592179950",
      "mapy": "37.5119175967",
      "mlevel": "6",
      "modifiedtime": "20230425092008",
      "sigungucode": "1",
      "tel": "02-3423-5534",
      "title": "Gangnam Festival"
    },
    {
      "addr1": "COEX, 513 Yeongdong-daero, Gangnam-gu, Seoul",
      "addr2": "",
      "areacode": "1",
      "booktour": "",
      "cat1": "A02",
      "cat2": "A0208",
      "cat3": "A02080600",
      "contentid": "2827820",
      "contenttypeid": "15",
      "createdtime": "20220714133526",
      "dist": "2176.576767029108",
      "firstimage":
          "http://tong.visitkorea.or.kr/cms/resource/19/2827819_image2_1.jpg",
      "firstimage2":
          "http://tong.visitkorea.or.kr/cms/resource/19/2827819_image3_1.jpg",
      "cpyrhtDivCd": "Type3",
      "mapx": "127.0592179950",
      "mapy": "37.5119175967",
      "mlevel": "6",
      "modifiedtime": "20220714133544",
      "sigungucode": "1",
      "tel": "02-6000-4290",
      "title": "4th Industrial Revolution Festival"
    },
    {
      "addr1": "COEX, 513 Yeongdong-daero, Gangnam-gu, Seoul",
      "addr2": "",
      "areacode": "1",
      "booktour": "",
      "cat1": "A02",
      "cat2": "A0208",
      "cat3": "A02080600",
      "contentid": "2852362",
      "contenttypeid": "15",
      "createdtime": "20220913085506",
      "dist": "2176.576767029108",
      "firstimage":
          "http://tong.visitkorea.or.kr/cms/resource/61/2852361_image2_1.jpg",
      "firstimage2":
          "http://tong.visitkorea.or.kr/cms/resource/61/2852361_image3_1.jpg",
      "cpyrhtDivCd": "Type3",
      "mapx": "127.0592179950",
      "mapy": "37.5119175967",
      "mlevel": "6",
      "modifiedtime": "20221021113827",
      "sigungucode": "1",
      "tel": "02-761-2864",
      "title": "Pet Lifestyle Fair (Pet Health Fair)"
    },
    {
      "addr1":
          "2584 Nambusunhwan-ro, Seocho-gu, Seoul, Korea, Seocho-gu Council",
      "addr2": "",
      "areacode": "1",
      "booktour": "",
      "cat1": "A02",
      "cat2": "A0207",
      "cat3": "A02070200",
      "contentid": "2759788",
      "contenttypeid": "15",
      "createdtime": "20211020200152",
      "dist": "2082.386103612087",
      "firstimage":
          "http://tong.visitkorea.or.kr/cms/resource/59/2865259_image2_1.jpg",
      "firstimage2":
          "http://tong.visitkorea.or.kr/cms/resource/59/2865259_image3_1.jpg",
      "cpyrhtDivCd": "Type3",
      "mapx": "127.0333739068",
      "mapy": "37.4842703421",
      "mlevel": "6",
      "modifiedtime": "20230425145228",
      "sigungucode": "15",
      "tel": "02-520-8723",
      "title": "Seoripul Book Culture Festival"
    },
    {
      "addr1": "COEX, 513 Yeongdong-daero, Gangnam-gu, Seoul",
      "addr2": "",
      "areacode": "1",
      "booktour": "",
      "cat1": "A02",
      "cat2": "A0208",
      "cat3": "A02080600",
      "contentid": "2948590",
      "contenttypeid": "15",
      "createdtime": "20230213093720",
      "dist": "2176.576767029108",
      "firstimage":
          "http://tong.visitkorea.or.kr/cms/resource/89/2948689_image2_1.jpg",
      "firstimage2":
          "http://tong.visitkorea.or.kr/cms/resource/89/2948689_image3_1.jpg",
      "cpyrhtDivCd": "Type3",
      "mapx": "127.0592179950",
      "mapy": "37.5119175967",
      "mlevel": "6",
      "modifiedtime": "20230214112738",
      "sigungucode": "1",
      "tel": "02-2215-8838",
      "title": "SOFUN & Life Show"
    },
    {
      "addr1": "513, Yeongdong-daero, Gangnam-gu, Seoul",
      "addr2": "(Samseong-dong)",
      "areacode": "1",
      "booktour": "",
      "cat1": "A02",
      "cat2": "A0208",
      "cat3": "A02080500",
      "contentid": "650752",
      "contenttypeid": "15",
      "createdtime": "20081112202018",
      "dist": "2183.887402284497",
      "firstimage":
          "http://tong.visitkorea.or.kr/cms/resource/06/2935206_image2_1.jpg",
      "firstimage2":
          "http://tong.visitkorea.or.kr/cms/resource/06/2935206_image3_1.jpg",
      "cpyrhtDivCd": "Type3",
      "mapx": "127.0594429796",
      "mapy": "37.5117148467",
      "mlevel": "6",
      "modifiedtime": "20221219181933",
      "sigungucode": "1",
      "tel": "02-2262-7193",
      "title": "Seoul Design Festival"
    },
    {
      "addr1": "35, Bongeunsa-ro 63-gil, Gangnam-gu, Seoul",
      "addr2": "(Samseong-dong)",
      "areacode": "1",
      "booktour": "",
      "cat1": "A02",
      "cat2": "A0208",
      "cat3": "A02080500",
      "contentid": "2718984",
      "contenttypeid": "15",
      "createdtime": "20210601221819",
      "dist": "1438.9073169500562",
      "firstimage":
          "http://tong.visitkorea.or.kr/cms/resource/73/2951673_image2_1.jpg",
      "firstimage2":
          "http://tong.visitkorea.or.kr/cms/resource/73/2951673_image3_1.jpg",
      "cpyrhtDivCd": "Type3",
      "mapx": "127.0462413481",
      "mapy": "37.5136810472",
      "mlevel": "6",
      "modifiedtime": "20230308162658",
      "sigungucode": "1",
      "tel": "02-2062-8601",
      "title": "Seoul Illustration Fair V.15"
    },
    {
      "addr1": "513, Yeongdong-daero, Gangnam-gu, Seoul (COEX)",
      "addr2": "",
      "areacode": "1",
      "booktour": "",
      "cat1": "A02",
      "cat2": "A0207",
      "cat3": "A02070200",
      "contentid": "2805988",
      "contenttypeid": "15",
      "createdtime": "20220204090941",
      "dist": "2183.887402284497",
      "firstimage":
          "http://tong.visitkorea.or.kr/cms/resource/49/2806349_image2_1.png",
      "firstimage2":
          "http://tong.visitkorea.or.kr/cms/resource/49/2806349_image2_1.png",
      "cpyrhtDivCd": "Type1",
      "mapx": "127.0594429796",
      "mapy": "37.5117148467",
      "mlevel": "6",
      "modifiedtime": "20230428152838",
      "sigungucode": "1",
      "tel": "02-6000-6709",
      "title": "Seoul Coffee Festival"
    }
  ];

  List<Map<String, String>> placeList = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      placeList = tourList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 로딩 중이면 로딩 인디케이터 표시
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // 오류 발생 시
            return const Text('An error occurred');
          } else {
            // 데이터가 준비되면 UI 구성

            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    // flush datas

                    Navigator.pop(context);
                  },
                ),
                title: Container(
                  padding: const EdgeInsets.only(right: 50),
                  alignment: Alignment.center,
                  child: const Text(
                    "IDOLICIOUS",
                    style: TextStyle(
                      color: Color(0xffF72FB3),
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              body: ListView(
                children: [
                  Column(
                    children: [
                      // buildImageSlider(mainPhotos),
                      // const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          children: [
                            buildMapInfo(),
                            const SizedBox(height: 10),
                            buildPlaceChoice(),
                            // 줄긋기
                            const Divider(
                              color: Colors.grey,
                              height: 5,
                              thickness: 0.5,
                              indent: 0,
                              endIndent: 0,
                            ),

                            const SizedBox(height: 10),
                            buildAroundListSection(),
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

  Widget buildAroundListSection() {
    String getDistanceFromInitiateByLatLng(double lat1, double lng1) {
      double standdardLat = 37.5027238316;
      double standdardLng = 127.0375924452;

      double distance =
          Geolocator.distanceBetween(lat1, lng1, standdardLat, standdardLng);
      // km 단위로 변환
      distance = distance / 1000;
      return distance.toStringAsFixed(2);
    }

    // 아이돌 관련 정보 구현
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: placeList
                  .map(
                    (e) => SizedBox(
                      height: 110,
                      width: double.infinity,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Image.network(
                              e['firstimage']!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e['title']!,
                                      style: const TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: -1,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        e['addr1']!,
                                        style: const TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -1,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // 거리 계산해서 km 단위로
                                Text(
                                  '${getDistanceFromInitiateByLatLng(double.parse(e['mapy']!), double.parse(e['mapx']!))} km',
                                  style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -1,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget buildPlaceChoice() {
    // 0,1,2 중에서 선택하는 메뉴 구현
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                whichPlace = 0;
                placeList = tourList;
              });
            },
            child: Text(
              'Tourism',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: -1,
                color: whichPlace == 0
                    ? const Color(0xffF72FB3)
                    : Colors.black.withOpacity(0.7),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                whichPlace = 1;
                placeList = curtureList;
              });
            },
            child: Text(
              'Culture',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: -1,
                color: whichPlace == 1
                    ? const Color(0xffF72FB3)
                    : Colors.black.withOpacity(0.7),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                whichPlace = 2;
                placeList = festivalList;
              });
            },
            child: Text(
              'Festival',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: -1,
                color: whichPlace == 2
                    ? const Color(0xffF72FB3)
                    : Colors.black.withOpacity(0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMapInfo() {
    double latitude = 37.5027238316;
    double longitude = 127.0375924452;
    String location = '서울특별시 중구 을지로 281';
    String phone = '02-2266-9101';
    String startTime = '10:00';
    String endTime = '22:00';

    if (longitude == null) return const SizedBox();

    LatLng initialLocation = LatLng(latitude, longitude);

    // 지도 및 상세 정보 구현
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 250,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: initialLocation,
                zoom: 14,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('now here'),
                  position: initialLocation,
                  infoWindow: const InfoWindow(
                    title: 'Now Here',
                    snippet: 'You are here',
                  ),
                ),
                for (int i = 0; i < placeList.length; i++)
                  Marker(
                    markerId: MarkerId(placeList[i]['title']!),
                    position: LatLng(
                      double.parse(placeList[i]['mapy']!),
                      double.parse(placeList[i]['mapx']!),
                    ),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueViolet,
                    ),
                    infoWindow: InfoWindow(
                      title: placeList[i]['title']!,
                      snippet: placeList[i]['addr1'] ?? "",
                    ),
                  ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
