

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kshethra_mini/utils/app_color.dart';
import 'package:kshethra_mini/utils/components/dialog_box_widget.dart';
import 'package:kshethra_mini/utils/components/snack_bar_widget.dart';
import 'package:kshethra_mini/view/booking_view.dart';
import 'package:kshethra_mini/view/donation_view.dart';
import 'package:kshethra_mini/view/e_hundi_view.dart';
import 'package:kshethra_mini/view/home_view_admin.dart';
import 'package:kshethra_mini/view/advance_booking.dart';
import 'package:kshethra_mini/view/home_view_users.dart';
import 'package:kshethra_mini/view/super_admin_add_donation_view.dart';
import 'package:kshethra_mini/view/super_admin_add_prathistta_view.dart';
import 'package:kshethra_mini/view/super_admin_add_temple_view.dart';
import 'package:kshethra_mini/view/super_admin_add_vazhipaddu_view.dart';
import 'package:kshethra_mini/view/super_admin_god_list_view.dart';
import 'package:kshethra_mini/view/super_admin_home_view.dart';
import 'package:kshethra_mini/view_model/booking_viewmodel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class HomePageViewmodel extends ChangeNotifier {
  final addTempleFormKey = GlobalKey<FormState>();
  TextEditingController addTempleName = TextEditingController();
  TextEditingController addTempleAdminUname = TextEditingController();
  TextEditingController addTempleAdminPass = TextEditingController();
  TextEditingController addTempleDevoteeUname = TextEditingController();
  TextEditingController addTempleDevoteePass = TextEditingController();
  TextEditingController addTemplePhno = TextEditingController();
  TextEditingController addTempleAddress = TextEditingController();

  final addPrathishttaKey = GlobalKey<FormState>();
  TextEditingController addPrathishttaNameController = TextEditingController();

  final addVazhippaduKey = GlobalKey<FormState>();
  TextEditingController addVazhippaduNameController = TextEditingController();
  TextEditingController addVazhippaduPrizeController = TextEditingController();

  final addDonationKey = GlobalKey<FormState>();
  TextEditingController addDonationNameController = TextEditingController();

  Uint8List? _addGodImage;
  Uint8List? get addGodImage => _addGodImage;

  String _selectedPrathishtta = "Add prathishtta";
  String get selectedPrathishtta => _selectedPrathishtta;

  String _selectedTemple = "Select temple".tr();
  String get selectedTemple => _selectedTemple;

  bool _isDropdownVissible = false;
  bool get isDropdownVissible => _isDropdownVissible;

  bool _isTempleDropdownVissible = false;
  bool get isTempleDropdownVissible => _isTempleDropdownVissible;
  String _currentLanguage = "en";

  String get currentLanguage => _currentLanguage;

  final ImagePicker _imagePicker = ImagePicker();

  void homePageNavigate(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeViewUsers()),
    );
  }


  void bookingPageNavigate(BuildContext context) {
    context.read<BookingViewmodel>().setBookingPage();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookingView()),
    );
  }

  void updateLanguage(String languageCode) {
    _currentLanguage = languageCode;
    notifyListeners();
  }

  void preBookingPageNavigate(BuildContext context) {
    context.read<BookingViewmodel>().setBookingPage();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AdvanceBooking()),
    );
  }

  void donationPageNavigate(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DonationView()),
    );
  }

  void eHundiPageNavigate(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EHundiView()),
    );
  }

  void popFunction(BuildContext context) {
    Navigator.pop(context);
  }

  void backtoHomePage(BuildContext context, int noOfPage) {
    for (int i = 1; i <= noOfPage; i++) {
      popFunction(context);
    }
  }

  String setQrAmount(String amount) {
    String value = "upi://pay?pa=astrinstechnologies@okaxis&am=$amount&cu=INR";

    return value;
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => DialogBoxWidget(
            title: 'Do you want to Logout ?',
            fButton: 'Logout',
            fOnTap: () {},
            sButton: 'Cancel',
            sOnTap: () => popFunction(context),
          ),
    );
  }

  void navigateSuperAdminHomeView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SuperAdminHomeView()),
    );
  }

  void navigateSuperAdminAddTempleView(BuildContext context) {
    clearController();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SuperAdminAddTempleView()),
    );
  }

  void navigateSuperAdminAddPrathisttaView(BuildContext context) {
    clearController();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SuperAdminAddPrathisttaView()),
    );
  }

  void showAddPrsthishttaFirstDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => DialogBoxWidget(
            title: "Where should you add the picture from ?",
            fButton: "Storage",
            fOnTap: () {
              popFunction(context);
              showAddImageBottomSheet(context);
            },
            sButton: "Images",
            sOnTap: () {
              popFunction(context);
              navigateSuperAdminGodListView(context);
            },
          ),
    );
  }

  void showAddImageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CameraAndGalleryBottomSheet(
          cameraButton: () {
            pickImageFromCamera(context);
          },
          galleryButton: () {
            pickImageFromGallery(context);
          },
        );
      },
    );
  }

  Future<void> pickImageFromCamera(BuildContext context) async {
    popFunction(context);
    try {
      final img = await _imagePicker.pickImage(source: ImageSource.camera);
      if (img != null) {
        _addGodImage = await img.readAsBytes();
      }
    } catch (e) {
      DialogBoxWidget(
        title: "Camera permission required !",
        fButton: "Allow",
        fOnTap: () async {
          popFunction(context);
          await openAppSettings();
        },
        sButton: "Cancel",
        sOnTap: () => popFunction(context),
      );
    }
    notifyListeners();
  }

  Future<void> pickImageFromGallery(BuildContext context) async {
    popFunction(context);
    try {
      final img = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (img != null) {
        _addGodImage = await img.readAsBytes();
      }
    } catch (e) {
      DialogBoxWidget(
        title: "Camera permission required !",
        fButton: "Allow",
        fOnTap: () async {
          popFunction(context);
          await openAppSettings();
        },
        sButton: "Cancel",
        sOnTap: () => popFunction(context),
      );
    }
    notifyListeners();
  }

  void addGodFloatButton(BuildContext context) {
    bool valid = addPrathishttaKey.currentState?.validate() ?? false;

    if (!valid) {
      return;
    }

    if (_addGodImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarWidget(
          msg: "Please add Prathishtta image",
          color: kGrey,
        ).build(context),
      );
      return;
    }

    if (_selectedTemple == "Select temple".tr()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarWidget(
          msg: "Please Select a temple",
          color: kGrey,
        ).build(context),
      );
      return;
    }
    popFunction(context);
  }

  void navigateSuperAdminGodListView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SuperAdminGodListView()),
    );
  }

  Future<void> stringImageToUint(String image) async {
    final ByteData data = await rootBundle.load(image);

    _addGodImage = data.buffer.asUint8List();
    notifyListeners();
  }

  void navigateSuperAdminAddVazhipadduView(BuildContext context) {
    clearController();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SuperAdminAddVazhipadduView()),
    );
  }

  void addPoojaDropDownOnchange(String value) {
    _selectedPrathishtta = value;
    _isDropdownVissible = false;
    notifyListeners();
  }

  void templeDropDownOnchange(String value) {
    _selectedTemple = value;
    _isTempleDropdownVissible = false;
    notifyListeners();
  }

  void toggleIsDropdownVissible() {
    _isDropdownVissible = !_isDropdownVissible;
    notifyListeners();
  }

  void toggleTempleDropdownVissible() {
    _isTempleDropdownVissible = !_isTempleDropdownVissible;
    notifyListeners();
  }

  void addVazhipaddFloatButton(BuildContext context) {
    bool valid = addVazhippaduKey.currentState?.validate() ?? false;

    if (!valid) {
      return;
    }

    if (_selectedTemple == "Select temple".tr()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarWidget(
          msg: "Please Select a temple",
          color: kGrey,
        ).build(context),
      );
      return;
    }

    if (_selectedPrathishtta == "Add prathishtta") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarWidget(
          msg: "Please select a Prathishtta",
          color: kGrey,
        ).build(context),
      );
      return;
    }

    popFunction(context);
  }

  void navigateSuperAdminAddDonationView(BuildContext context) {
    clearController();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SuperAdminAddDonationView()),
    );
  }

  void addDonationFloatButton(BuildContext context) {
    bool valid = addDonationKey.currentState?.validate() ?? false;
    if (!valid) {
      return;
    }
    if (_selectedTemple == "Select temple") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarWidget(
          msg: "Please Select a temple",
          color: kGrey,
        ).build(context),
      );
      return;
    }
    popFunction(context);
  }

  void addTempleFloatButton(BuildContext context) {
    bool valid = addTempleFormKey.currentState?.validate() ?? false;
    if (!valid) {
      return;
    }
    popFunction(context);
  }

  void clearController() {
    addTempleName.clear();
    addTempleAdminUname.clear();
    addTempleAdminPass.clear();
    addTempleDevoteeUname.clear();
    addTempleDevoteePass.clear();
    addTemplePhno.clear();
    addTempleAddress.clear();
    addPrathishttaNameController.clear();
    addVazhippaduNameController.clear();
    addVazhippaduPrizeController.clear();
    addDonationNameController.clear();
    _selectedTemple = "Select temple".tr();
    _isTempleDropdownVissible = false;
    _isDropdownVissible = false;
    _selectedPrathishtta = "Add prathishtta";
    _addGodImage = null;
  }
}
