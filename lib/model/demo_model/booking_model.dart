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
    god: "Shivan".tr(),
    godImg: Assets.images.lordSiva.path,
    vazhippad: [
      {"vazhi": "Abhishekam".tr(), "prize": 50},
      {"vazhi": "Abhishekam".tr(), "prize": 40},
      {"vazhi": "Archana".tr(), "prize": 501},
      {"vazhi": "Rudrabhishekam".tr(), "prize": 100},
      {"vazhi": "Neyvilakku".tr(), "prize": 150},
      {"vazhi": "Annadanam".tr(), "prize": 15000},
    ],
  ),
  BookingModel(
    god: "Devi".tr(),
    godImg: Assets.images.lordDevi.path,
    vazhippad: [
      {"vazhi": "Chuttuvillaku".tr(), "prize": 1001},
      {"vazhi": "Trikala pooja".tr(), "prize": 501},
      {"vazhi": "Bhagavath seva".tr(), "prize": 501},
      {"vazhi": "Kalabhabishekam".tr(), "prize": 50},
      {"vazhi": "Thrimadhuram".tr(), "prize": 50},
      {"vazhi": "Chandhanam charth".tr(), "prize": 150},
      {"vazhi": "Neyvilakku".tr(), "prize": 150},
      {"vazhi": "Annadanam".tr(), "prize": 15000},
    ],
  ),
  BookingModel(
    god: "Vishnu".tr(),
    godImg: Assets.images.lordVishnu.path,
    vazhippad: [
      {"vazhi": "Chuttuvillaku".tr(), "prize": 1000},
      {"vazhi": "Trikala pooja".tr(), "prize": 501},
      {"vazhi": "Bhagavath seva".tr(), "prize": 501},
      {"vazhi": "Kalabhabishekam".tr(), "prize": 50},
    ],
  ),
  BookingModel(
    god: "Saraswati".tr(),
    godImg: Assets.images.lordSaraswati.path,
    vazhippad: [
      {"vazhi": "Mala".tr(), "prize": 150},
      {"vazhi": "Malar Para".tr(), "prize": 10},
      {"vazhi": "Ney Vilakku".tr(), "prize": 10},
      {"vazhi": "Payasam".tr(), "prize": 100},
      {"vazhi": "Janma Nakshathra Pooja".tr(), "prize": 1001},
    ],
  ),
  BookingModel(
    god: "Ganapathy".tr(),
    godImg: Assets.images.lordGanesh.path,
    vazhippad: [
      {"vazhi": "Abhishekam".tr(), "prize": 50},
      {"vazhi": "Abhishekam".tr(), "prize": 40},
      {"vazhi": "Archana".tr(), "prize": 501},
      {"vazhi": "Rudrabhishekam".tr(), "prize": 100},
      {"vazhi": "Neyvilakku".tr(), "prize": 150},
      {"vazhi": "Annadanam".tr(), "prize": 15000},
      {"vazhi": "Mala".tr(), "prize": 150},
      {"vazhi": "Malar Para".tr(), "prize": 10},
      {"vazhi": "Ney Vilakku".tr(), "prize": 10},
      {"vazhi": "Payasam".tr(), "prize": 100},
      {"vazhi": "Janma Nakshathra Pooja".tr(), "prize": 1001},
    ],
  ),
  BookingModel(
    god: "Hanuman".tr(),
    godImg: Assets.images.lordHanuman.path,
    vazhippad: [
      {"vazhi": "Ney Vilakku".tr(), "prize": 10},
      {"vazhi": "Payasam".tr(), "prize": 100},
      {"vazhi": "Janma Nakshathra Pooja".tr(), "prize": 1001},
    ],
  ),
  BookingModel(
    god: "Krishna".tr(),
    godImg: Assets.images.lordKrishna.path,
    vazhippad: [
      {"vazhi": "Annadanam".tr(), "prize": 15000},
    ],
  ),
  BookingModel(
    god: "Durga".tr(),
    godImg: Assets.images.lordDurga.path,
    vazhippad: [],
  ),
];
