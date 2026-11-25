class CategoryModel {
  final int? id;
  final String name;
  final String? description;
  final String? icon;
  final String? color;

  CategoryModel({
    this.id,
    required this.name,
    this.description,
    this.icon,
    this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'description': description,
      'icon': icon,
      'color': color,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      description: map['description'] as String?,
      icon: map['icon'] as String?,
      color: map['color'] as String?,
    );
  }
}
