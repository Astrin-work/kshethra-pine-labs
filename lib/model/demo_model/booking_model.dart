import 'package:easy_localization/easy_localization.dart';
import 'package:kshethra_mini/utils/asset/assets.gen.dart';

class BookingModel {
  String? god;
  String? godImg;
  List<Map<String, dynamic>>? vazhippad;

  BookingModel({
    required this.god,
    required this.godImg,
    required this.vazhippad,
  });
}

List<BookingModel> bList = [
  BookingModel(
    god: "shivan".tr(),
    godImg: Assets.images.lordSiva.path,
    vazhippad: [
      {"vazhi": "abhishekam", "prize": 50},
      {"vazhi": "abhishekam", "prize": 40},
      {"vazhi": "archana", "prize": 501},
      {"vazhi": "rudrabhishekam", "prize": 100},
      {"vazhi": "neyvilakku", "prize": 150},
      {"vazhi": "annadanam", "prize": 15000},
    ],
  ),
  BookingModel(
    god: "devi",
    godImg: Assets.images.lordDevi.path,
    vazhippad: [
      {"vazhi": "chuttuvillaku", "prize": 1001},
      {"vazhi": "trikala_pooja", "prize": 501},
      {"vazhi": "bhagavath_seva", "prize": 501},
      {"vazhi": "kalabhabishekam", "prize": 50},
      {"vazhi": "thrimadhuram", "prize": 50},
      {"vazhi": "chandhanam_charth", "prize": 150},
      {"vazhi": "neyvilakku", "prize": 150},
      {"vazhi": "annadanam", "prize": 15000},
    ],
  ),
  BookingModel(
    god: "vishnu",
    godImg: Assets.images.lordVishnu.path,
    vazhippad: [
      {"vazhi": "chuttuvillaku", "prize": 1000},
      {"vazhi": "trikala_pooja", "prize": 501},
      {"vazhi": "bhagavath_seva", "prize": 501},
      {"vazhi": "kalabhabishekam", "prize": 50},
    ],
  ),
  BookingModel(
    god: "saraswati",
    godImg: Assets.images.lordSaraswati.path,
    vazhippad: [
      {"vazhi": "mala", "prize": 150},
      {"vazhi": "malar_para", "prize": 10},
      {"vazhi": "neyvilakku", "prize": 10},
      {"vazhi": "payasam", "prize": 100},
      {"vazhi": "janma_nakshathra_pooja", "prize": 1001},
    ],
  ),
  BookingModel(
    god: "ganapathy",
    godImg: Assets.images.lordGanesh.path,
    vazhippad: [
      {"vazhi": "abhishekam", "prize": 50},
      {"vazhi": "abhishekam", "prize": 40},
      {"vazhi": "archana", "prize": 501},
      {"vazhi": "rudrabhishekam", "prize": 100},
      {"vazhi": "neyvilakku", "prize": 150},
      {"vazhi": "annadanam", "prize": 15000},
      {"vazhi": "mala", "prize": 150},
      {"vazhi": "malar_para", "prize": 10},
      {"vazhi": "neyvilakku", "prize": 10},
      {"vazhi": "payasam", "prize": 100},
      {"vazhi": "janma_nakshathra_pooja", "prize": 1001},
    ],
  ),
  BookingModel(
    god: "hanuman",
    godImg: Assets.images.lordHanuman.path,
    vazhippad: [
      {"vazhi": "neyvilakku", "prize": 10},
      {"vazhi": "payasam", "prize": 100},
      {"vazhi": "janma_nakshathra_pooja", "prize": 1001},
    ],
  ),
  BookingModel(
    god: "krishna",
    godImg: Assets.images.lordKrishna.path,
    vazhippad: [
      {"vazhi": "annadanam", "prize": 15000},
    ],
  ),
  BookingModel(
    god: "durga",
    godImg: Assets.images.lordDurga.path,
    vazhippad: [],
  ),
];
