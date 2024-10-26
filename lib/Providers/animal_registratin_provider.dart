import 'dart:io';

import 'package:dairyfarmflow/Functions/showPopsScreen.dart';
import 'package:dairyfarmflow/Providers/user_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class AnimalRegistratinProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String message = '';
  // get message => _message;

  Future<void> uploadAnimalData(BuildContext context, String animalNumber,
      String breed, age, File image) async {
    _isLoading = true;
    notifyListeners();
    if (image == null || animalNumber.isEmpty || breed.isEmpty) {
      print("Please complete all fields and select an image.");
      return;
    }

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://dairy-app-production-4bb8.up.railway.app/api/cow/register'),
    );

    // Add headers and fields

    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        image!.path,
        filename: basename(image!.path),
      ),
    );

    request.headers['Authorization'] =
        'Bearer ${Provider.of<UserDetail>(context, listen: false).token}';
    request.fields['animalNumber'] = animalNumber;
    request.fields['breed'] = breed;
    request.fields['age'] = age.toString();

    // Send request and handle response
    try {
      var response = await request.send();
      if (response.statusCode == 201 || response.statusCode == 200) {
        _isLoading = false;
        notifyListeners();
        message = "Animal data uploaded successfully!";
        showSuccessSnackbar(message, context);

        print('Animal data uploaded successfully!');
      } else {
        _isLoading = false;
        notifyListeners();
        message = "Failed to upload data ${response.statusCode}";
        showErrorSnackbar(message, context);
        print('Failed to upload data: ${response.statusCode}');
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      message = "Error uploading data: $e";
      showErrorSnackbar(message, context);
      print('Error uploading data: $e');
    }
  }
}
