class Vendor {
  final String id;
  final String name;

  Vendor({required this.id, required this.name});

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['_id'],
      name: json['name'],
    );
  }
}

class VendorResponse {
  final bool success;
  final String message;
  final List<Vendor> vendors;

  VendorResponse({required this.success, required this.message, required this.vendors});

  factory VendorResponse.fromJson(Map<String, dynamic> json) {
    return VendorResponse(
      success: json['success'],
      message: json['message'],
      vendors: (json['vendors'] as List).map((v) => Vendor.fromJson(v)).toList(),
    );
  }
}
