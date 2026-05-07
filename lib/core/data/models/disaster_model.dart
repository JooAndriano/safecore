import 'package:hive_flutter/hive_flutter.dart';

part 'disaster_model.g.dart';

/// Hive adapter untuk Disaster model
@HiveType(typeId: 0)
class Disaster extends HiveObject {
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
  final List<String> precautions;

  @HiveField(7)
  final DateTime createdAt;

  @HiveField(8)
  final DateTime updatedAt;

  Disaster({
    required this.id,
    required this.title,
    required this.description,
    required this.assetPath,
    required this.icon,
    required this.symptoms,
    required this.precautions,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory Disaster.fromJson(Map<String, dynamic> json) {
    return Disaster(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      assetPath: json['assetPath'] as String,
      icon: json['icon'] as String,
      symptoms: List<String>.from(json['symptoms'] ?? []),
      precautions: List<String>.from(json['precautions'] ?? []),
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
      'precautions': precautions,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Disaster copyWith({
    String? id,
    String? title,
    String? description,
    String? assetPath,
    String? icon,
    List<String>? symptoms,
    List<String>? precautions,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Disaster(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      assetPath: assetPath ?? this.assetPath,
      icon: icon ?? this.icon,
      symptoms: symptoms ?? this.symptoms,
      precautions: precautions ?? this.precautions,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}