import 'package:easy_localization/easy_localization.dart';
import 'package:kshethra_mini/utils/asset/assets.gen.dart';

class EHundiModel {
  String? god;
  String? godImg;

  EHundiModel({required this.god, required this.godImg});
}

List<EHundiModel> hundiList = [
  EHundiModel(god: "Shivan".tr(), godImg: Assets.images.lordSiva.path),
  EHundiModel(god: "Devi".tr(), godImg: Assets.images.lordDevi.path),
  EHundiModel(god: "Vishnu".tr(), godImg: Assets.images.lordVishnu.path),
  EHundiModel(god: "Saraswati".tr(), godImg: Assets.images.lordSaraswati.path),
  EHundiModel(god: "Ganapathy".tr(), godImg: Assets.images.lordGanesh.path),
  EHundiModel(god: "Hanuman".tr(), godImg: Assets.images.lordHanuman.path),
  EHundiModel(god: "Krishna".tr(), godImg: Assets.images.lordKrishna.path),
  EHundiModel(god: "Durga".tr(), godImg: Assets.images.lordDurga.path),
];
