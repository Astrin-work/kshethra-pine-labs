import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kshethra_mini/model/user_booking_model.dart';
import 'package:kshethra_mini/utils/app_color.dart';
import 'package:kshethra_mini/utils/components/qr_code_component.dart';
import 'package:kshethra_mini/utils/components/snack_bar_widget.dart';
import 'package:kshethra_mini/view/advance_booking_preview_view.dart';
import 'package:kshethra_mini/view/booking_preview_view.dart';
import 'package:kshethra_mini/view/card_payment_screen.dart';
import 'package:kshethra_mini/view/cash_payment.dart';
import 'package:kshethra_mini/view/widgets/booking_page_widget/vazhipaddu_dialogbox_widget.dart';
import '../api_services/api_service.dart';
import '../model/api models/get_donation_model.dart';
import '../model/api models/god_model.dart';
import '../view/advanced_booking_confirm_view.dart';
import '../view/widgets/advanced_booking_page_widget/advanced_vazhipaddu_dialog_BoxWidget.dart';
import '../view/widgets/payment_method_screen.dart';

class BookingViewmodel extends ChangeNotifier {
  final bookingKey = GlobalKey<FormState>();
  final advBookingKey = GlobalKey<FormState>();
  final Set<String> _selectedWeeklyDays = {};

  TextEditingController bookingNameController = TextEditingController();
  TextEditingController bookingPhnoController = TextEditingController();
  TextEditingController bookingRepController = TextEditingController();
  TextEditingController bookingAddressController = TextEditingController();
  TextEditingController bookingPinCodeController = TextEditingController();
  bool _isExistedDevotee = false;
  bool get isExistedDevotee => _isExistedDevotee;
  bool _isPostalAdded = false;
  bool _prasadamSelected = false;
  bool _isLoading = false;
  bool get prasadamSelected => _prasadamSelected;
  List<UserBookingModel> _vazhipaduBookingList = [];
  // List<UserBookingModel> _AdvvazhipaduBookingList = [];
  List<UserBookingModel> get vazhipaduBookingList => _vazhipaduBookingList;
  // List<UserBookingModel> get AdvVazhipaduBookingList => _AdvvazhipaduBookingList;
  List<Godmodel> _gods = [];
  List<Getdonationmodel> donations = [];
  int selectedIndex = 0;
  int get combinedTotalAmount => _totalAdvBookingAmt + _postalAmount.toInt();

  List<Godmodel> get gods => _gods;
  bool get isLoading => _isLoading;
  int _noOfBookingVazhipaddu = 1;
  int get noOfBookingVazhipaddu => _noOfBookingVazhipaddu;
  int _advBookingAmt = 0;
  int get advBookingAmt => _advBookingAmt;
  int _totalAdvBookingAmt = 0;
  int get totalAdvBookingAmt => _totalAdvBookingAmt;
  int _totalVazhipaduAmt = 0;
  int get totalVazhipaduAmt => _totalVazhipaduAmt;
  int _advBookingSavedAmt = 0;
  int get advBookingSavedAmt => _advBookingSavedAmt;
  int _amtOfBookingVazhipaddu = 0;
  int get amtOfBookingVazhipaddu => _amtOfBookingVazhipaddu;
  // // BookingModel _selectedGod = bList[0];
  // BookingModel get selectedGod => _selectedGod;
  Godmodel? selectedGods;

  String _selectedStar = "Star".tr();
  String get selectedStar => _selectedStar;
  String _selectedRepMethod = "Once";
  String get selectedRepMethod => _selectedRepMethod;
  String _selectedWeeklyDay = "Sun";
  String get selectedWeeklyDay => _selectedWeeklyDay;
  String _advBookOption = "";
  String get advBookOption => _advBookOption;
  String _selectedDate = "Date".tr();
  String get selectedDate => _selectedDate;
  String _postalOption = '';
  String get postalOption => _postalOption;
  int _repeatDays = 1;
  int get repeatDays => _repeatDays;
  double _postalAmount = 0.0;
  double get postalAmount => _postalAmount;
  double _totalAmount = 0.0;
  double get totalAmount => _totalAmount * noOfBookingVazhipaddu;
  bool _shouldResetPrasadam = false;

  @override
  void dispose() {
    bookingNameController.dispose();
    bookingPhnoController.dispose();
    bookingRepController.dispose();
    bookingAddressController.dispose();
    super.dispose();
  }

  Future<void> submitVazhipadu() async {
    if (vazhipaduBookingList.isEmpty) {
      print(' No vazhipadu bookings to submit.');
      return;
    }

    final now = DateTime.now().toIso8601String();

    List<Map<String, dynamic>> receipts = [];

    for (var item in vazhipaduBookingList) {
      final int quantity = int.tryParse(item.count.toString()) ?? 1;
      final int rate = int.tryParse(item.price.toString()) ?? 0;

      receipts.add({
        "personName": item.name ?? "Unknown",
        "personStar": item.star ?? "Unknown",
        "quantity": quantity,
        "rate": rate,
        "offerDate": item.date ?? now,
        "receiptDate": now,
        "type": "CB",
        "offerName": item.vazhipadu ?? "vazhipadu2",
      });
    }

    final postData = {
      "receipts": receipts,
      "paymentType": "upi",
      "transactionId": "1122",
      "bankId": "",
      "bankName": "icici",
    };

    try {
      final response = await ApiService().postVazhipaduDetails(postData);

      if (response is List && response.isNotEmpty) {
        final List<Map<String, dynamic>> allReceipts = [];

        for (var entry in response) {
          if (entry is Map<String, dynamic>) {
            final receiptsList = entry['receipts'];
            if (receiptsList is List) {
              allReceipts.addAll(receiptsList.cast<Map<String, dynamic>>());
            }
          }
        }

        final groupedResponse = [
          {
            "serialNumber": response.first['serialNumber'],
            "receipts": allReceipts,
          },
        ];

        print(" Submitted ${receipts.length} items successfully.");
        print("Grouped Response: $groupedResponse");
      } else {
        print(" Submitted ${receipts.length} items successfully.");
        print("Response: $response");
      }
    } catch (e) {
      print(" Failed to submit vazhipadu: $e");
    }
  }

  Future<void> submitAdvVazhipadu() async {
    if (vazhipaduBookingList.isEmpty) {
      print(' No advanced vazhipadu bookings to submit.');
      return;
    }

    final List<Map<String, dynamic>> receipts = vazhipaduBookingList.map((item) {
      DateTime selectedDate = DateTime.now();
      String formattedDate = "${DateFormat('yyyy-MM-dd').format(selectedDate)}T00:00:00";

      return {
      // "devathaName": "ഭഗവതി",
      // "offerName": "കുങ്കുമാര്ചന",
      // "personName": "vvv",
      // "personStar": "Makayiram"
        "devathaName": item.godname??"",
        "offerName": item.vazhipadu ?? "vazhipadu2",
        "personName": item.name ?? "",
        "personStar": item.star,
        "phoneNumber": item.phno ?? "",
        "address": bookingAddressController.text.trim(),
        "startDate": formattedDate,
        "repeatType": item.repMethode ?? "once",
        "repeatCount": int.tryParse(bookingRepController.text.trim()) ?? 1,
        "repeatDays": [
          "monday"
        ],
        "rate": int.tryParse(item.price?.toString() ?? "0") ?? 0,
        "quantity": int.tryParse(item.count?.toString() ?? "1") ?? 1,
        "type": "AB",
        "pincode": bookingPinCodeController.text.trim(),
        "paymentMode": "UPI",
        "postalCharge": 10,
        "prasadham": true,
        "prasadhamType": "standard",
        "postalType": "registered",
      };
    }).toList();

    final Map<String, dynamic> postData = {
      "receipts": receipts,
      "paymentType": "upi",
      "transactionId": "4444",
      "bankId": "333/sbi",
      "bankName": "canara",
    };

    // 🔍 Print full data to debug before sending
    print("🧾 Final POST Data:\n${jsonEncode(postData)}");

    try {
      final response = await ApiService().postAdvVazhipaduDetails(postData);

      if (response != null && response['success'] == true) {
        List<dynamic> successList = response['successList'];
        for (int i = 0; i < successList.length; i++) {
          final item = successList[i];
          print("✅ Booking ${i + 1}: ${item['offerName']} for ${item['personName']}");
        }
      } else {
        print("⚠️ Submission failed or no successList.");
        print("Response: $response");
      }
    } catch (e) {
      if (e is DioException) {
        print("❌ DioException (400 Bad Request):");
        print("Status: ${e.response?.statusCode}");
        print("Error Body: ${e.response?.data}");
      } else {
        print("❌ Unexpected exception: $e");
      }
    }
  }


  Future<void> fetchGods() async {
    _isLoading = true;
    notifyListeners();

    try {
      _gods = await ApiService().getDevatha();

      if (_gods.isNotEmpty) {
        selectedGods = _gods[0];
      }
    } catch (e) {
      print("Error fetching gods: $e");
      _gods = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  set repeatDays(int value) {
    _repeatDays = value;
    _updatePostalAmount();
    _recalculateTotalAmount();
    notifyListeners();
  }

  void _updatePostalAmount() {
    if (_postalOption == 'Postal') {
      _postalAmount = 5.0 * _repeatDays;
    } else if (_postalOption == 'Speed Post') {
      _postalAmount = 45.0 * _repeatDays;
    } else {
      _postalAmount = 0.0;
    }
  }

  void togglePrasadam(bool value) {
    _prasadamSelected = value;

    if (!_prasadamSelected) {
      if (_isPostalAdded) {
        _totalVazhipaduAmt -= _postalAmount.toInt();
        _isPostalAdded = false;
      }
      _postalOption = '';
      _postalAmount = 0.0;
    }
    notifyListeners();
  }

  void setShouldResetPrasadam(bool value) {
    _shouldResetPrasadam = value;
  }

  void resetPrasadamSelection() {
    _prasadamSelected = false;
    _postalOption = '';
    _postalAmount = 0.0;
    notifyListeners();
  }

  void selectPostalOption(String option) {
    if (_isPostalAdded) {
      _totalVazhipaduAmt -= _postalAmount.toInt();
      _isPostalAdded = false;
    }
    _postalOption = option;
    if (_postalOption.isNotEmpty) {
      _updatePostalAmount();
      _totalVazhipaduAmt += _postalAmount.toInt();
      _isPostalAdded = true;
    } else {
      _postalAmount = 0.0;
    }
    _recalculateTotalAmount();

    print("Selected Postal Option: $_postalOption");
    print("Repeat Days: $_repeatDays");
    print("Postal Amount: ₹$_postalAmount");
    print("Total Vazhipaadu Amount (with postal): ₹$_totalVazhipaduAmt");

    notifyListeners();
  }

  void updateRepeatDays(int days) {
    _repeatDays = days;
    notifyListeners();
  }

  void _recalculateTotalAmount() {
    _totalAmount = _totalVazhipaduAmt + _postalAmount;
  }

  // void setBookingPage() {
  //   _advBookOption = "";
  //   _advBookingSavedAmt = 0;
  //   _totalAdvBookingAmt = 0;
  //   _selectedGod = bList[0];
  //   _selectedStar = "Star".tr();
  //   _selectedDate = "Date".tr();
  //   bookingAddressController.clear();
  //   bookingNameController.clear();
  //   _isExistedDevotee = false;
  //   _vazhipaduBookingList = [];
  //   _totalVazhipaduAmt = 0;
  //   bookingPhnoController.clear();
  // }

  void setBookingPage() {
    _advBookOption = "";
    _advBookingSavedAmt = 0;
    _totalAdvBookingAmt = 0;
    if (_gods.isNotEmpty) {
      selectedGods = _gods[0];
    } else {
      selectedGods = null;
    }
    _selectedStar = "Star".tr();
    _selectedDate = "Date".tr();
    bookingAddressController.clear();
    bookingNameController.clear();
    _isExistedDevotee = false;
    _vazhipaduBookingList = [];
    _totalVazhipaduAmt = 0;
    bookingPhnoController.clear();
  }

  void clearBookingControllers() {
    bookingNameController.clear();
    bookingPhnoController.clear();
    bookingRepController.clear();
    bookingAddressController.clear();
  }

  void popFunction(BuildContext context) {
    Navigator.pop(context);
  }

  String setQrAmount(String amount) {
    String value = "upi://pay?pa=6282488785@superyes&am=$amount&cu=INR";
    return value;
  }

  void backtoHomePage(BuildContext context, int noOfPage) {
    for (int i = 1; i <= noOfPage; i++) {
      popFunction(context);
    }
  }

  void navigateAdvBookingPreview(BuildContext context) {
    print('Quantity: $noOfBookingVazhipaddu');
    print('Total Amount: ₹$totalAmount');
    print('Total Amount: ₹$advBookingAmt');
    print('Total Amount: ₹$totalAdvBookingAmt');
    print('Total Amount: ₹$totalVazhipaduAmt');

    if (_totalVazhipaduAmt == 0) {
      print(totalVazhipaduAmt);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarWidget(
          msg: "Payment request denied!",
          color: kRed,
        ).build(context),
      );
      return;
    }

    selectedGods = gods[0];
    _selectedStar = "Star".tr();
    bookingNameController.clear();
    _isExistedDevotee = false;

    final selectedDays = selectedWeeklyDays;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => AdvancedBookingPreviewView(
          selectedRepMethod: selectedRepMethod,
          selectedDays: selectedDays,
          totalAmount: totalVazhipaduAmt,
        ),
      ),
    );

    notifyListeners();
  }

  // void navigateAdvBookingPreview(BuildContext context) {
  //   if (_totalVazhipaduAmt == 0) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBarWidget(
  //         msg: "Payment request denied!",
  //         color: kRed,
  //       ).build(context),
  //     );
  //     return;
  //   }
  //
  //   if (_gods.isNotEmpty) {
  //     selectedGods = _gods[0];
  //   }
  //   _selectedStar = "Star".tr();
  //   bookingNameController.clear();
  //   _isExistedDevotee = false;
  //
  //   final selectedDays = selectedWeeklyDays;
  //
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => AdvancedBookingPreviewView(
  //         selectedRepMethod: selectedRepMethod,
  //         selectedDays: selectedDays,
  //         totalAmount: totalVazhipaduAmt,
  //       ),
  //     ),
  //   );
  //
  //   notifyListeners();
  // }

  // void navigateBookingPreviewView(BuildContext context) {
  //   if (_totalVazhipaduAmt != 0) {
  //     _selectedGod = bList[0];
  //     _selectedStar = "Star".tr();
  //     bookingNameController.clear();
  //     _isExistedDevotee = false;
  //
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => BookingPreviewView(
  //           page: 'booking',
  //           selectedRepMethod: selectedRepMethod,
  //         ),
  //       ),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBarWidget(
  //         msg: "Please select a Vazhippadu",
  //         color: kGrey,
  //       ).build(context),
  //     );
  //   }
  //
  //   notifyListeners();
  // }

  // Future<void> fetchDonations() async {
  //   donations = await ApiService().getDonation();
  //   notifyListeners(); // if using Provider
  // }

  // Future<void> fetchVazhipadu() async {
  //   try {
  //     final response = await ApiService().getVazhipadu();
  //     vazhipaduList = response;
  //     notifyListeners();
  //   } catch (e) {
  //     print("Error in fetchVazhipadu: $e");
  //   }
  // }
  void navigateBookingPreviewView(BuildContext context) {
    if (_totalVazhipaduAmt != 0) {
      if (_gods.isNotEmpty) {
        selectedGods = _gods[0];
      }
      _selectedStar = "Star".tr();
      bookingNameController.clear();
      _isExistedDevotee = false;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => BookingPreviewView(
            page: 'booking',
            selectedRepMethod: selectedRepMethod,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarWidget(
          msg: "Please select a Vazhippadu",
          color: kGrey,
        ).build(context),
      );
    }

    notifyListeners();
  }

  void setAdvBookOption(String value) {
    _advBookOption = value;
    notifyListeners();
  }

  void selectBookingDate(BuildContext context) async {
    DateTime? value = await showDatePicker(
      context: context,
      firstDate: getTomorrow(),
      lastDate: getOneYear(),
    );
    if (value != null) {
      _selectedDate = formatDateTime(value);
    }
    notifyListeners();
  }

  String formatDateTime(DateTime dateTime) {
    String year = dateTime.year.toString();
    String month = dateTime.month.toString().padLeft(2, '0');
    String day = dateTime.day.toString().padLeft(2, '0');
    return '$day/$month/$year';
  }

  DateTime getTomorrow() {
    return DateTime.now().add(Duration(days: 1));
  }

  DateTime getOneYear() {
    return DateTime.now().add(Duration(days: 365));
  }

  void bookingRepOnchange(
      String value,
      Vazhipadus selectedVazhipaadu,
      Map<String, double> postalRates,
      double amount,
      ) {
    int? repCount = int.tryParse(value.trim());

    if (repCount == null || repCount <= 0) {
      _repeatDays = 1;
      _totalVazhipaduAmt = _advBookingSavedAmt;
      notifyListeners();
      return;
    }

    _repeatDays = repCount;
    print("Number of repeat days: $_repeatDays");

    int unitPrice = selectedVazhipaadu.cost;
    int quantity = noOfBookingVazhipaddu;
    int baseAmount = unitPrice * quantity;

    _totalVazhipaduAmt = baseAmount * _repeatDays;

    print("---------------------- Total Calculation -------------------");
    print("Unit Price: ₹$unitPrice");
    print("Quantity: $quantity");
    print("Repeat Days: $_repeatDays");
    print("Base Amount: ₹$baseAmount");
    print("Total Vazhipaadu Amount (without postal): ₹$_totalVazhipaduAmt");

    if (_postalOption.isNotEmpty) {
      _updatePostalAmount();
      _totalVazhipaduAmt += _postalAmount.toInt();
      _isPostalAdded = true;
    }

    print("Total Postal Amount: ₹$_postalAmount");
    print("Final Total Vazhipaadu Amount (with postal): ₹$_totalVazhipaduAmt");

    notifyListeners();
  }

  void navigateAdvancedBookingConfirm(
      BuildContext context,
      Vazhipadus selectedVazhipaadu,
      BookingViewmodel bookingViewmodel,
      ) {
    _selectedRepMethod = "Once";
    _selectedWeeklyDay = "Sun";
    bookingRepController.text = "1";

    int unitPrice = selectedVazhipaadu.cost;
    int quantity = bookingViewmodel.noOfBookingVazhipaddu;
    _totalVazhipaduAmt = _advBookingSavedAmt + (quantity * unitPrice);
    //
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder:
            (context) => AdvancedBookingConfirmView(
          selectedVazhipaadu: selectedVazhipaadu,
          totalAmount: _totalVazhipaduAmt,
        ),
      ),
    );

    print("-----------amount------------");
    print(_totalVazhipaduAmt);
  }

  // void advBookingAddVazhipadu(
  //     Map<String, dynamic> selectedVazhipaadu,
  //     BuildContext context,
  //     ) {
  //   bool valid = advBookingKey.currentState?.validate() ?? false;
  //   if (!valid) return;
  //
  //   if (_advBookOption == "") {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBarWidget(
  //         msg: "Select one option from Star or Date",
  //         color: kGrey,
  //       ).build(context),
  //     );
  //     return;
  //   }
  //
  //   final int repeatCount = selectedRepMethod == "Once"
  //       ? 1
  //       : int.tryParse(bookingRepController.text) ?? 1;
  //
  //   final double itemPrice = selectedVazhipaadu["price"] ?? 0.0;
  //   final double postalAmt = prasadamSelected ? postalAmount : 0.0;
  //
  //
  //   _totalVazhipaduAmt = ((itemPrice * repeatCount) + postalAmt) as int;
  //   _advBookingSavedAmt = _totalVazhipaduAmt;
  //   print(totalVazhipaduAmt);
  //   print(totalAdvBookingAmt);
  //
  //
  //   setVazhipaduAdvBookingList(selectedVazhipaadu, context);
  //   bookingAddNewDevottee();
  //   popFunction(context);
  // }
  void advBookingAddVazhipadu(
      Vazhipadus selectedVazhipaadu,
      BuildContext context,
      ) {
    bool valid = advBookingKey.currentState?.validate() ?? false;
    if (!valid) return;

    if (_advBookOption.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarWidget(
          msg: "Select one option from Star or Date",
          color: kGrey,
        ).build(context),
      );
      return;
    }

    final int repeatCount =
    selectedRepMethod == "Once"
        ? 1
        : int.tryParse(bookingRepController.text.trim()) ?? 1;

    final double itemPrice = selectedVazhipaadu.cost.toDouble(); // from model
    final double postalAmt = prasadamSelected ? postalAmount : 0.0;

    _totalVazhipaduAmt = ((itemPrice * repeatCount) + postalAmt).toInt();
    _advBookingSavedAmt = _totalVazhipaduAmt;

    print(_totalVazhipaduAmt);
    print(_totalAdvBookingAmt);

    setVazhipaduAdvBookingList(selectedVazhipaadu, context);
    bookingAddNewDevottee();
    popFunction(context);
  }

  void updateTotalAmount(double value) {
    _totalAmount = value;
    notifyListeners();
  }

  void setGod(Godmodel value) {
    selectedGods = value;
    notifyListeners();
  }

  // void setGod(BookingModel value) {
  //   _selectedGod = value;
  //   notifyListeners();
  // }

  // void showVazhipadduDialogBox(
  //     BuildContext context,
  //     Map<String, dynamic> selectedVazhipaadu,
  //     ) {
  //   bool valid = bookingKey.currentState?.validate() ?? false;
  //   if (!valid) return;
  //
  //   _noOfBookingVazhipaddu = 1;
  //   int x = int.tryParse(selectedVazhipaadu["prize"]?.toString() ?? "0") ?? 0;
  //   _amtOfBookingVazhipaddu = 1 * x;
  //
  //   if (_selectedStar != "Star") {
  //     showDialog(
  //       context: context,
  //       builder: (context) => VazhipadduDialogBoxWidget(
  //         selectedVazhippadu: selectedVazhipaadu,
  //       ),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBarWidget(msg: "Select your star", color: kGrey).build(context),
  //     );
  //   }
  //
  //   notifyListeners();
  // }

  void showVazhipadduDialogBox(
      BuildContext context,
      Vazhipadus selectedVazhipaadu,
      ) {
    bool valid = bookingKey.currentState?.validate() ?? false;
    if (!valid) return;

    _noOfBookingVazhipaddu = 1;
    _amtOfBookingVazhipaddu = selectedVazhipaadu.cost;

    if (_selectedStar != "Star") {
      showDialog(
        context: context,
        builder:
            (context) => VazhipadduDialogBoxWidget(
          selectedVazhippadu: selectedVazhipaadu,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarWidget(msg: "Select your star", color: kGrey).build(context),
      );
    }

    notifyListeners();
  }

  void showAdvancedVazhipadduDialogBox(
      BuildContext context,
      Vazhipadus selectedVazhipaadu,
      ) {
    _noOfBookingVazhipaddu = 1;
    _amtOfBookingVazhipaddu = selectedVazhipaadu.cost;

    showDialog(
      context: context,
      builder:
          (context) => AdvancedVazhipadduDialogBoxwidget(
        selectedVazhippadu: selectedVazhipaadu,
      ),
    );

    notifyListeners();
  }

  void resetDialogState() {
    _noOfBookingVazhipaddu = 1;
    _amtOfBookingVazhipaddu = 0;
  }

  void addNoOfBookingVazhipaddu(int ammount) {
    _noOfBookingVazhipaddu++;
    _amtOfBookingVazhipaddu = _noOfBookingVazhipaddu * ammount;
    notifyListeners();
  }

  void removeNoOfBookingVazhipaddu(int ammount) {
    if (_noOfBookingVazhipaddu > 1) {
      _noOfBookingVazhipaddu--;
      _amtOfBookingVazhipaddu = _noOfBookingVazhipaddu * ammount;
    }
    notifyListeners();
  }

  void setStar(String star, BuildContext context) {
    _selectedStar = star;
    popFunction(context);
    notifyListeners();
  }

  void clearSelectedStar() {
    _selectedStar = "";
    notifyListeners();
  }

  void bookingAddNewDevottee() {
    bookingNameController.clear();
    bookingPhnoController.clear();
    _selectedStar = "Star".tr();
    _isExistedDevotee = false;
    notifyListeners();
  }

  void setVazhipaduBookingList(
      String vazhipaduName,
      String vazhipaduPrice,
      BuildContext context,
      ) {
    final newBooking = UserBookingModel(
      name: bookingNameController.text.trim(),
      phno: bookingPhnoController.text.trim(),
      star: _selectedStar.tr(),
      godname: selectedGods?.devathaName.toString(),
      vazhipadu: vazhipaduName,
      price: vazhipaduPrice,
      count: _noOfBookingVazhipaddu.toString(),
      totalPrice: _amtOfBookingVazhipaddu.toString(),
    );

    _vazhipaduBookingList.add(newBooking);

    print("Added new booking: ${newBooking.toString()}");

    print("Current Booking List:");
    for (var booking in _vazhipaduBookingList) {
      print(booking.toString());
    }

    _totalVazhipaduAmt += _amtOfBookingVazhipaddu;
    _isExistedDevotee = true;
    popFunction(context);
    notifyListeners();
  }

  // void setVazhipaduAdvBookingList(
  //     Map<String, dynamic> selectedVazhipaadu,
  //     BuildContext context,
  //     ) {
  //   bool valid = advBookingKey.currentState?.validate() ?? false;
  //   if (!valid) return;
  //
  //   if (_advBookOption.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBarWidget(
  //         msg: "Select one option from Star or Date",
  //         color: kGrey,
  //       ).build(context),
  //     );
  //     return;
  //   }
  //
  //   int repetitions = int.tryParse(bookingRepController.text.trim()) ?? 1;
  //   if (repetitions == 0) repetitions = 1;
  //
  //   int unitPrice = selectedVazhipaadu["prize"] ?? 0;
  //   int totalAmount = unitPrice *  noOfBookingVazhipaddu;
  //
  //   _vazhipaduBookingList.add(
  //     UserBookingModel(
  //       name: bookingNameController.text.trim(),
  //       phno: bookingPhnoController.text.trim(),
  //       star: _selectedStar.tr(),
  //       date: _selectedDate,
  //       option: _advBookOption == "star".tr() ? _selectedStar : _selectedDate,
  //       repMethode: _selectedRepMethod,
  //       day: _selectedRepMethod == "Weekly" ? _selectedWeeklyDay : '',
  //       godname: selectedGods?.devathaName.toString(),
  //       vazhipadu: selectedVazhipaadu["vazhi"] ?? "",
  //       price: unitPrice.toString(),
  //       count: noOfBookingVazhipaddu.toString(),
  //       totalPrice: totalAmount.toString(),
  //     ),
  //   );
  //   print('------------tyr----------');
  //   print(unitPrice);
  //   print(noOfBookingVazhipaddu);
  //   print(totalAmount);
  //   _totalAdvBookingAmt += totalAmount;
  //   log(_totalAdvBookingAmt.toString(), name: "adv booking");
  //
  //   popFunction(context);
  //   navigateAdvBookingPreview(context);
  //   notifyListeners();
  // }

  void setVazhipaduAdvBookingList(
      Vazhipadus selectedVazhipaadu,
      BuildContext context,
      ) {
    bool valid = advBookingKey.currentState?.validate() ?? false;
    if (!valid) return;

    if (_advBookOption.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarWidget(
          msg: "Select one option from Star or Date",
          color: kGrey,
        ).build(context),
      );
      return;
    }

    int repetitions = int.tryParse(bookingRepController.text.trim()) ?? 1;
    if (repetitions == 0) repetitions = 1;

    int unitPrice = selectedVazhipaadu.cost; // use model field directly
    int totalAmount = unitPrice * noOfBookingVazhipaddu;

    _vazhipaduBookingList.add(
      UserBookingModel(
        name: bookingNameController.text.trim(),
        phno: bookingPhnoController.text.trim(),
        star: _selectedStar.tr(),
        date: _selectedDate,
        option: _advBookOption == "star".tr() ? _selectedStar : _selectedDate,
        repMethode: _selectedRepMethod,
        day: _selectedRepMethod == "Weekly" ? _selectedWeeklyDay : '',
        godname: selectedGods?.devathaName.toString(),
        vazhipadu: selectedVazhipaadu.offerName,
        price: unitPrice.toString(),
        count: noOfBookingVazhipaddu.toString(),
        totalPrice: totalAmount.toString(),
      ),
    );

    print('------------debug values----------');
    print(unitPrice);
    print(noOfBookingVazhipaddu);
    print(totalAmount);

    _totalAdvBookingAmt += totalAmount;
    log(_totalAdvBookingAmt.toString(), name: "adv booking");

    popFunction(context);
    navigateAdvBookingPreview(context);
    notifyListeners();
  }

  int calculateBookingTotalAmt() {
    if (_vazhipaduBookingList.isEmpty) return 0;

    UserBookingModel value = _vazhipaduBookingList.last;
    return int.tryParse(value.totalPrice ?? '0') ?? 0;
  }

  void addVazhipaddToExisting(
      String vazhipaduName,
      int price,
      BuildContext context,
      ) {
    final lastDevotee = _vazhipaduBookingList.last;
    final newBooking = UserBookingModel(
      name: lastDevotee.name,
      phno: lastDevotee.phno,
      star: lastDevotee.star,
      date: lastDevotee.date,
      option: lastDevotee.option,
      repMethode: lastDevotee.repMethode,
      day: lastDevotee.day,
      godname: selectedGods?.devathaName.toString(),
      vazhipadu: vazhipaduName,
      price: price.toString(),
      count: _noOfBookingVazhipaddu.toString(),
      totalPrice: (_noOfBookingVazhipaddu * price).toString(),
    );

    _vazhipaduBookingList.add(newBooking);
    _totalVazhipaduAmt += _noOfBookingVazhipaddu * price;

    log(_totalVazhipaduAmt.toString(), name: "Existing Devotee");

    popFunction(context);
    notifyListeners();
  }

  void vazhipaduDelete(int index) {
    final booking = _vazhipaduBookingList[index];

    int amount = int.tryParse(booking.totalPrice ?? '0') ?? 0;
    _totalVazhipaduAmt -= amount;

    _vazhipaduBookingList.removeAt(index);

    print("Deleted amount: $amount");
    notifyListeners();
  }

  void advBookingDelete(int index) {
    if (index < 0 || index >= vazhipaduBookingList.length) return;

    final booking = vazhipaduBookingList[index];
    int amount = int.tryParse(booking.totalPrice ?? '0') ?? 0;

    _totalAdvBookingAmt -= amount;

    vazhipaduBookingList.removeAt(index);

    print("Deleted advanced booking combined amount: $amount");
    print("Updated total advanced booking amount: $_totalAdvBookingAmt");

    notifyListeners();
  }

  void bookingPreviewSecondFloatButton(
      BuildContext context,
      int? amount,
      int noOfScreens,
      String title,
      ) {
    if (totalVazhipaduAmt == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarWidget(
          msg: "Payment request denied !",
          color: kRed,
        ).build(context),
      );
      return;
    }
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder:
    //         (context) => QrScannerComponent(
    //       amount: amount != null ? "$amount" : "$totalVazhipaduAmt",
    //       noOfScreen: noOfScreens,
    //       title: title,
    //     ),
    //   ),
    // );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaymentMethodScreen()),
    );
    notifyListeners();
  }

  void navigateToQrScanner(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => QrScannerComponent(
          amount: "$totalVazhipaduAmt",
          noOfScreen: 1,
          title: "QR Scanner",
        ),
      ),
    );
  }

  void navigateToCashPayment(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CashPayment(amount: totalVazhipaduAmt),
      ),
    );
  }

  void navigateCardScreen(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CardPaymentScreen()),
    );
  }

  // void switchSelectedRepMethod(String value) {
  //   _selectedRepMethod = value;
  //   notifyListeners();
  // }
  void switchSelectedRepMethod(String method) {
    _selectedRepMethod = method;
    notifyListeners();
  }

  bool toggleSelectedRepMethod(String method) {
    return _selectedRepMethod == method;
  }

  // bool toggleSelectedRepMethod(String value) {
  //   return _selectedRepMethod == value;
  // }
  void switchSelectedWeeklyDay(String day) {
    if (_selectedWeeklyDays.contains(day)) {
      _selectedWeeklyDays.remove(day);
    } else {
      _selectedWeeklyDays.add(day);
    }
    notifyListeners();
  }

  bool toggleSelectedWeeklyDay(String day) {
    return _selectedWeeklyDays.contains(day);
  }

  int get totalBookingAmount {
    int total = 0;
    for (var booking in vazhipaduBookingList) {
      total += int.tryParse(booking.totalPrice?.toString() ?? '0') ?? 0;
    }
    return total;
  }

  List<String> get selectedWeeklyDays => _selectedWeeklyDays.toList();
}