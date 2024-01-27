import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class MySnackBars {
  static SnackBar failureSnackBar(String message) {
    return SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Greška!',
        message: message,
        contentType: ContentType.failure,
      ),
    );
  }

  static SnackBar helpSnackBar(String message) {
    return SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Zdravo!',
        message: message,
        contentType: ContentType.help,
      ),
    );
  }

  static SnackBar successSnackBar(String message) {
    return SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Čestitke!',
        message: message,
        contentType: ContentType.success,
      ),
    );
  }

  static SnackBar warningSnackBar(String message) {
    return SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Upozorenje!',
        message: message,
        contentType: ContentType.warning,
      ),
    );
  }
}