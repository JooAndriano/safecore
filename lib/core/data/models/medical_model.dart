import 'package:hive_flutter/hive_flutter.dart';

part 'medical_model.g.dart';

/// Hive adapter untuk MedicalEmergency model
@HiveType(typeId: 1)
class MedicalEmergency extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String assetPath;

  @HiveField(4)
  final String icon;

  @HiveField(5)
  final List<String> symptoms;

  @HiveField(6)
  final List<String> firstAid;

  @HiveField(7)
  final DateTime createdAt;

  @HiveField(8)
  final DateTime updatedAt;

  MedicalEmergency({
    required this.id,
    required this.title,
    required this.description,
    required this.assetPath,
    required this.icon,
    required this.symptoms,
    required this.firstAid,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory MedicalEmergency.fromJson(Map<String, dynamic> json) {
    return MedicalEmergency(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      assetPath: json['assetPath'] as String,
      icon: json['icon'] as String,
      symptoms: List<String>.from(json['symptoms'] ?? []),
      firstAid: List<String>.from(json['firstAid'] ?? []),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'assetPath': assetPath,
      'icon': icon,
      'symptoms': symptoms,
      'firstAid': firstAid,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  MedicalEmergency copyWith({
    String? id,
    String? title,
    String? description,
    String? assetPath,
    String? icon,
    List<String>? symptoms,
    List<String>? firstAid,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MedicalEmergency(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      assetPath: assetPath ?? this.assetPath,
      icon: icon ?? this.icon,
      symptoms: symptoms ?? this.symptoms,
      firstAid: firstAid ?? this.firstAid,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}