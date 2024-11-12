class Worker {
  final String id;
  final String name;
  final String email;
  final String password;
  final String role;
  final String registrationDate;
  final String createdBy;

  Worker({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.registrationDate,
    required this.createdBy,
  });

  // Factory method to create Worker from JSON
  factory Worker.fromJson(Map<String, dynamic> json) {
    return Worker(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
      registrationDate: json['registration'],
      createdBy: json['createdBy'],
    );
  }
}
