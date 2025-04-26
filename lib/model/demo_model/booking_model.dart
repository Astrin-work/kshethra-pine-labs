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
      {"vazhi": "abhishekam".tr(), "prize": 50},
      {"vazhi": "abhishekam".tr(), "prize": 40},
      {"vazhi": "archana".tr(), "prize": 501},
      {"vazhi": "rudrabhishekam".tr(), "prize": 100},
      {"vazhi": "neyvilakku".tr(), "prize": 150},
      {"vazhi": "annadanam".tr(), "prize": 15000},
    ],
  ),
  BookingModel(
    god: "devi".tr(),
    godImg: Assets.images.lordDevi.path,
    vazhippad: [
      {"vazhi": "chuttuvillaku".tr(), "prize": 1001},
      {"vazhi": "trikala_pooja".tr(), "prize": 501},
      {"vazhi": "bhagavath_seva".tr(), "prize": 501},
      {"vazhi": "kalabhabishekam".tr(), "prize": 50},
      {"vazhi": "thrimadhuram".tr(), "prize": 50},
      {"vazhi": "chandhanam_charth".tr(), "prize": 150},
      {"vazhi": "neyvilakku".tr(), "prize": 150},
      {"vazhi": "annadanam".tr(), "prize": 15000},
    ],
  ),
  BookingModel(
    god: "vishnu".tr(),
    godImg: Assets.images.lordVishnu.path,
    vazhippad: [
      {"vazhi": "chuttuvillaku".tr(), "prize": 1000},
      {"vazhi": "trikala_pooja".tr(), "prize": 501},
      {"vazhi": "bhagavath_seva".tr(), "prize": 501},
      {"vazhi": "kalabhabishekam".tr(), "prize": 50},
    ],
  ),
  BookingModel(
    god: "saraswati".tr(),
    godImg: Assets.images.lordSaraswati.path,
    vazhippad: [
      {"vazhi": "mala".tr(), "prize": 150},
      {"vazhi": "malar_para".tr(), "prize": 10},
      {"vazhi": "neyvilakku".tr(), "prize": 10},
      {"vazhi": "payasam".tr(), "prize": 100},
      {"vazhi": "janma_nakshathra_pooja".tr(), "prize": 1001},
    ],
  ),
  BookingModel(
    god: "ganapathy".tr(),
    godImg: Assets.images.lordGanesh.path,
    vazhippad: [
      {"vazhi": "abhishekam".tr(), "prize": 50},
      {"vazhi": "abhishekam".tr(), "prize": 40},
      {"vazhi": "archana".tr(), "prize": 501},
      {"vazhi": "rudrabhishekam".tr(), "prize": 100},
      {"vazhi": "neyvilakku".tr(), "prize": 150},
      {"vazhi": "annadanam".tr(), "prize": 15000},
      {"vazhi": "mala".tr(), "prize": 150},
      {"vazhi": "malar_para".tr(), "prize": 10},
      {"vazhi": "neyvilakku".tr(), "prize": 10},
      {"vazhi": "payasam".tr(), "prize": 100},
      {"vazhi": "janma_nakshathra_pooja".tr(), "prize": 1001},
    ],
  ),
  BookingModel(
    god: "hanuman".tr(),
    godImg: Assets.images.lordHanuman.path,
    vazhippad: [
      {"vazhi": "neyvilakku".tr(), "prize": 10},
      {"vazhi": "payasam".tr(), "prize": 100},
      {"vazhi": "janma_nakshathra_pooja".tr(), "prize": 1001},
    ],
  ),
  BookingModel(
    god: "krishna".tr(),
    godImg: Assets.images.lordKrishna.path,
    vazhippad: [
      {"vazhi": "annadanam".tr(), "prize": 15000},
    ],
  ),
  BookingModel(
    god: "durga".tr(),
    godImg: Assets.images.lordDurga.path,
    vazhippad: [],
  ),
];
