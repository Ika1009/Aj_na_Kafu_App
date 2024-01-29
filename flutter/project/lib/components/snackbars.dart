import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class MySnackBars {
  static SnackBar failureSnackBar() {
    return SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Greška!',
        message: "Pogrešan unos podataka",
        contentType: ContentType.failure,
      ),
    );
  }

  static SnackBar helpSnackBar() {
    return SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Zdravo!',
        message: "Ovo je obaveštenje",
        contentType: ContentType.help,
      ),
    );
  }

  static SnackBar successSnackBar() {
    return SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Čestitke!',
        message: "Uspešno ste izvršili",
        contentType: ContentType.success,
      ),
    );
  }

  static SnackBar warningSnackBar(String title, String message) {
    return SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: ContentType.warning,
      ),
    );
  }
}