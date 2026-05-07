import 'package:hive_flutter/hive_flutter.dart';

part 'checklist_model.g.dart';

/// Hive adapter untuk ChecklistItem model
@HiveType(typeId: 2)
class ChecklistItem extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String category;

  @HiveField(3)
  final bool isChecked;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  final DateTime? completedAt;

  ChecklistItem({
    required this.id,
    required this.title,
    required this.category,
    this.isChecked = false,
    DateTime? createdAt,
    this.completedAt,
  })  : createdAt = createdAt ?? DateTime.now();

  factory ChecklistItem.fromJson(Map<String, dynamic> json) {
    return ChecklistItem(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      isChecked: json['isChecked'] as bool? ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'isChecked': isChecked,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  ChecklistItem copyWith({
    String? id,
    String? title,
    String? category,
    bool? isChecked,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return ChecklistItem(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      isChecked: isChecked ?? this.isChecked,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  ChecklistItem toggle() {
    return copyWith(
      isChecked: !isChecked,
      completedAt: isChecked ? null : DateTime.now(),
    );
  }
}