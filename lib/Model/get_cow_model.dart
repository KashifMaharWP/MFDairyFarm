// cows_response.dart

class CowsResponse {
  final String message;
  final bool success;
  final List<Cow> cows;

  CowsResponse({
    required this.message,
    required this.success,
    required this.cows,
  });

  // Factory method to create a CowsResponse from JSON
  factory CowsResponse.fromJson(Map<String, dynamic> json) {
    return CowsResponse(
      message: json['message'],
      success: json['success'],
      cows: List<Cow>.from(json['cows'].map((cow) => Cow.fromJson(cow))),
    );
  }
}

class Cow {
  final String id;
  final int animalNumber;
  final String image;
  final int age;
  final bool pregnancyStatus;
  final String breed;
  final String createdBy;

  Cow({
    required this.id,
    required this.animalNumber,
    required this.image,
    required this.age,
    required this.pregnancyStatus,
    required this.breed,
    required this.createdBy,
  });

  // Factory method to create a Cow from JSON
  factory Cow.fromJson(Map<String, dynamic> json) {
    return Cow(
      id: json['_id'],
      animalNumber: json['animalNumber'],
      image: json['image'],
      age: json['age'],
      pregnancyStatus: json['pregnancyStatus'] == 'true',
      breed: json['breed'],
      createdBy: json['createdBy'],
    );
  }
}
