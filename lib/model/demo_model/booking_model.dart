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
    god: "Shivan",
    godImg: Assets.images.lordSiva.path,
    vazhippad: [
      {"vazhi": "Abhishekam", "prize": 50},
      {"vazhi": "Abhishekam", "prize": 40},
      {"vazhi": "Archana", "prize": 501},
      {"vazhi": "Rudrabhishekam", "prize": 100},
      {"vazhi": "Neyvilakku", "prize": 150},
      {"vazhi": "Annadanam", "prize": 15000},
    ],
  ),
  BookingModel(
    god: "Devi",
    godImg: Assets.images.lordDevi.path,
    vazhippad: [
      {"vazhi": "Chuttuvillaku", "prize": 1001},
      {"vazhi": "Trikala pooja", "prize": 501},
      {"vazhi": "Bhagavath seva", "prize": 501},
      {"vazhi": "Kalabhabishekam", "prize": 50},
      {"vazhi": "Thrimadhuram", "prize": 50},
      {"vazhi": "Chandhanam charth", "prize": 150},
      {"vazhi": "Neyvilakku", "prize": 150},
      {"vazhi": "Annadanam", "prize": 15000},
    ],
  ),
  BookingModel(
    god: "Vishnu",
    godImg: Assets.images.lordVishnu.path,
    vazhippad: [
      {"vazhi": "Chuttuvillaku", "prize": 1000},
      {"vazhi": "Trikala pooja", "prize": 501},
      {"vazhi": "Bhagavath seva", "prize": 501},
      {"vazhi": "Kalabhabishekam", "prize": 50},
    ],
  ),
  BookingModel(
    god: "Saraswati",
    godImg: Assets.images.lordSaraswati.path,
    vazhippad: [
      {"vazhi": "Mala", "prize": 150},
      {"vazhi": "Malar Para", "prize": 10},
      {"vazhi": "Ney Vilakku", "prize": 10},
      {"vazhi": "Payasam", "prize": 100},
      {"vazhi": "Janma Nakshathra Pooja", "prize": 1001},
    ],
  ),
  BookingModel(
    god: "Ganapathy",
    godImg: Assets.images.lordGanesh.path,
    vazhippad: [
      {"vazhi": "Abhishekam", "prize": 50},
      {"vazhi": "Abhishekam", "prize": 40},
      {"vazhi": "Archana", "prize": 501},
      {"vazhi": "Rudrabhishekam", "prize": 100},
      {"vazhi": "Neyvilakku", "prize": 150},
      {"vazhi": "Annadanam", "prize": 15000},
      {"vazhi": "Mala", "prize": 150},
      {"vazhi": "Malar Para", "prize": 10},
      {"vazhi": "Ney Vilakku", "prize": 10},
      {"vazhi": "Payasam", "prize": 100},
      {"vazhi": "Janma Nakshathra Pooja", "prize": 1001},
    ],
  ),
  BookingModel(
    god: "Hanuman",
    godImg: Assets.images.lordHanuman.path,
    vazhippad: [
      {"vazhi": "Ney Vilakku", "prize": 10},
      {"vazhi": "Payasam", "prize": 100},
      {"vazhi": "Janma Nakshathra Pooja", "prize": 1001},
    ],
  ),
  BookingModel(
    god: "Krishna",
    godImg: Assets.images.lordKrishna.path,
    vazhippad: [
      {"vazhi": "Annadanam", "prize": 15000},
    ],
  ),
  BookingModel(
    god: "Durga",
    godImg: Assets.images.lordDurga.path,
    vazhippad: [],
  ),
];
