//Date Picker Function
import 'package:flutter/material.dart';

import '../Class/colorPallete.dart';

Future<DateTime?> customDatePicker(
    BuildContext context, DateTime selectedDate) {
  return showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            // Customize the dialog background color
            dialogBackgroundColor: Colors.white,
            // Customize the selected date color
            colorScheme: ColorScheme.light(
              primary: darkGreenColor, // Color for the selected date background
              onPrimary: Colors.white, // Color for the selected date text
              onSurface: Colors.black, // Color for the unselected dates
            ),
            // Customize the confirm and cancel buttons
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: darkGreenColor, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      });
}
