import 'package:kshethra_mini/utils/asset/assets.gen.dart';

class EHundiModel {
  String? god;
  String? godImg;

  EHundiModel({required this.god, required this.godImg});
}

List<EHundiModel> hundiList = [
  EHundiModel(god: "Shivan", godImg: Assets.images.lordSiva.path),
  EHundiModel(god: "Devi", godImg: Assets.images.lordDevi.path),
  EHundiModel(god: "Vishnu", godImg: Assets.images.lordVishnu.path),
  EHundiModel(god: "Saraswati", godImg: Assets.images.lordSaraswati.path),
  EHundiModel(god: "Ganapathy", godImg: Assets.images.lordGanesh.path),
  EHundiModel(god: "Hanuman", godImg: Assets.images.lordHanuman.path),
  EHundiModel(god: "Krishna", godImg: Assets.images.lordKrishna.path),
  EHundiModel(god: "Durga", godImg: Assets.images.lordDurga.path),
];
