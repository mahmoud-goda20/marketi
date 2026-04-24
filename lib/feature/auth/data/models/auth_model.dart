import 'package:marketi/feature/auth/domain/entites/auth_entites.dart';

class AuthModel {
  final String message;
  final String token;
  final String name;
  final String phone;
  final String email;
  final String role;
  final String image;

  AuthModel({
    required this.message,
    required this.token,
    required this.name,
    required this.phone,
    required this.email,
    required this.role,
    required this.image,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>?;
    return AuthModel(
      message: json['message'] as String? ?? '',
      token: json['token'] as String? ?? '',
      name: user?['name'] as String? ?? '',
      phone: user?['phone'] as String? ?? '',
      email: user?['email'] as String? ?? '',
      role: user?['role'] as String? ?? '',
      image: user?['image'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'token': token,
      'user': {
        'name': name,
        'phone': phone,
        'email': email,
        'role': role,
        'image': image,
      },
    };
  }

  AuthEntity toEntity({
    String? message,
    String? token,
    String? name,
    String? phone,
    String? email,
    String? role,
    String? image,
  }) {
    return AuthEntity(
      message: message ?? this.message,
      token: token ?? this.token,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      role: role ?? this.role,
      image: image ?? this.image,
    );
  }
}
