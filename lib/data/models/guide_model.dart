import 'guide_step_model.dart';

class GuideModel {
  final int? id;
  final int categoryId;
  final String title;
  final String? description;
  final String? thumbnail;
  final String? difficulty;
  final int? estimatedMinutes;
  final String? source;
  final String? createdAt;
  final String? updatedAt;

  // Additional joined or computed fields
  final String? categoryName;
  final String? categoryColor;
  final String? categoryIcon;
  final List<GuideStepModel>? steps;
  final bool isBookmarked;
  final int? readProgress;

  GuideModel({
    this.id,
    required this.categoryId,
    required this.title,
    this.description,
    this.thumbnail,
    this.difficulty,
    this.estimatedMinutes,
    this.source,
    this.createdAt,
    this.updatedAt,
    this.categoryName,
    this.categoryColor,
    this.categoryIcon,
    this.steps,
    this.isBookmarked = false,
    this.readProgress,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'category_id': categoryId,
      'title': title,
      'description': description,
      'thumbnail': thumbnail,
      'difficulty': difficulty,
      'estimated_minutes': estimatedMinutes,
      'source': source,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory GuideModel.fromMap(Map<String, dynamic> map, {
    String? categoryName,
    String? categoryColor,
    String? categoryIcon,
    List<GuideStepModel>? steps,
    bool isBookmarked = false,
    int? readProgress,
  }) {
    return GuideModel(
      id: map['id'] as int?,
      categoryId: map['category_id'] as int,
      title: map['title'] as String,
      description: map['description'] as String?,
      thumbnail: map['thumbnail'] as String?,
      difficulty: map['difficulty'] as String?,
      estimatedMinutes: map['estimated_minutes'] as int?,
      source: map['source'] as String?,
      createdAt: map['created_at'] as String?,
      updatedAt: map['updated_at'] as String?,
      categoryName: categoryName ?? map['category_name'] as String?,
      categoryColor: categoryColor ?? map['category_color'] as String?,
      categoryIcon: categoryIcon ?? map['category_icon'] as String?,
      steps: steps,
      isBookmarked: isBookmarked,
      readProgress: readProgress,
    );
  }

  GuideModel copyWith({
    int? id,
    int? categoryId,
    String? title,
    String? description,
    String? thumbnail,
    String? difficulty,
    int? estimatedMinutes,
    String? source,
    String? createdAt,
    String? updatedAt,
    String? categoryName,
    String? categoryColor,
    String? categoryIcon,
    List<GuideStepModel>? steps,
    bool? isBookmarked,
    int? readProgress,
  }) {
    return GuideModel(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      description: description ?? this.description,
      thumbnail: thumbnail ?? this.thumbnail,
      difficulty: difficulty ?? this.difficulty,
      estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
      source: source ?? this.source,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      categoryName: categoryName ?? this.categoryName,
      categoryColor: categoryColor ?? this.categoryColor,
      categoryIcon: categoryIcon ?? this.categoryIcon,
      steps: steps ?? this.steps,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      readProgress: readProgress ?? this.readProgress,
    );
  }
}
