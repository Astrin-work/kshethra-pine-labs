class Validation{
  static String? nameValidation(String? value) {
    RegExp regex = RegExp(r'^[a-zA-Z\s]+$');
    final name = value ?? "";
    if (name.isEmpty || name == "") {
      return ("Enter your name");
    }
    if (!regex.hasMatch(name)) {
      return ("Name should not contain special characters & numbers");
    }

    return null;
  }


  static String? phoneValidation(String? value) {
    RegExp regex = RegExp(r'^\d{10}$');
    final phone = value ?? "";
    if (phone.isEmpty || phone == "") {
      return ("Phone number is required");
    }
    if (!regex.hasMatch(phone)) {
      return ("Enter valid a Phone number");
    }
    return null;
  }

  static String? numberValidation(
      String? value,
      String nullMsg,
      String invldMsg,
      ) {
    RegExp regex = RegExp(r'[0-9]');

    final age = value ?? "";
    if (age.isEmpty || age == "") {
      return (nullMsg);
    }
    if (!regex.hasMatch(age)) {
      return (invldMsg);
    }
    return null;
  }


  static String? emptyValidation(String? value, String msg) {
    final adress = value ?? "";
    if (adress.isEmpty || adress == "") {
      return (msg);
    }

    return null;
  }

}