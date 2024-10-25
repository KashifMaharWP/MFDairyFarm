import 'package:dairyfarmflow/Class/colorPallete.dart';
import 'package:dairyfarmflow/Class/textSizing.dart';
import 'package:dairyfarmflow/Widget/Text1.dart';
import 'package:flutter/material.dart';

import '../Class/screenMediaQuery.dart';

void customPopUp(BuildContext context, double height, Function saveFunction) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Save Animal'),
      content: Container(
        height: height,
        child: Column(
          children: [
            Text('Would you like to save the animal details?'),
            // Add additional content if necessary
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close popup without saving
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            saveFunction(); // Trigger the save function
            Navigator.pop(context); // Close popup after saving
          },
          child: Text('Save'),
        ),
      ],
    ),
  );
}