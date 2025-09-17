/// User model class
/// 
/// This file contains the User model that represents user data
/// throughout the application. It follows clean architecture principles
/// by separating data models from business logic.

class UserModel {
  /// Unique identifier for the user
  final String id;
  
  /// User's email address
  final String email;
  
  /// User's display name
  final String name;
  
  /// User's profile image URL
  final String? profileImageUrl;
  
  /// User's phone number
  final String? phoneNumber;
  
  /// Whether the user's email is verified
  final bool isEmailVerified;
  
  /// User's creation timestamp
  final DateTime createdAt;
  
  /// User's last update timestamp
  final DateTime updatedAt;

  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.profileImageUrl,
    this.phoneNumber,
    this.isEmailVerified = false,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Creates a UserModel from a JSON map
  /// 
  /// [json] - The JSON map containing user data
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      isEmailVerified: json['isEmailVerified'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// Converts the UserModel to a JSON map
  /// 
  /// Returns a Map<String, dynamic> representation of the user
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'profileImageUrl': profileImageUrl,
      'phoneNumber': phoneNumber,
      'isEmailVerified': isEmailVerified,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// Creates a copy of the UserModel with updated fields
  /// 
  /// [id] - New id value
  /// [email] - New email value
  /// [name] - New name value
  /// [profileImageUrl] - New profile image URL value
  /// [phoneNumber] - New phone number value
  /// [isEmailVerified] - New email verification status
  /// [createdAt] - New creation timestamp
  /// [updatedAt] - New update timestamp
  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? profileImageUrl,
    String? phoneNumber,
    bool? isEmailVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is UserModel &&
        other.id == id &&
        other.email == email &&
        other.name == name &&
        other.profileImageUrl == profileImageUrl &&
        other.phoneNumber == phoneNumber &&
        other.isEmailVerified == isEmailVerified &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      email,
      name,
      profileImageUrl,
      phoneNumber,
      isEmailVerified,
      createdAt,
      updatedAt,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, name: $name, profileImageUrl: $profileImageUrl, phoneNumber: $phoneNumber, isEmailVerified: $isEmailVerified, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
