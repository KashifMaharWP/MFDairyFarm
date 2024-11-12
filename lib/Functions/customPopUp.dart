import 'package:flutter/material.dart';

void customPopUp(BuildContext context, double height, Function saveFunction) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Save Animal'),
      content: SizedBox(
        height: height,
        child: const Column(
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
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            saveFunction(); // Trigger the save function
            Navigator.pop(context); // Close popup after saving
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );
}
