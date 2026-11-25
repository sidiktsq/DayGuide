class GuideStepModel {
  final int? id;
  final int guideId;
  final int stepNumber;
  final String title;
  final String content;
  final String? image;

  GuideStepModel({
    this.id,
    required this.guideId,
    required this.stepNumber,
    required this.title,
    required this.content,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'guide_id': guideId,
      'step_number': stepNumber,
      'title': title,
      'content': content,
      'image': image,
    };
  }

  factory GuideStepModel.fromMap(Map<String, dynamic> map) {
    return GuideStepModel(
      id: map['id'] as int?,
      guideId: map['guide_id'] as int,
      stepNumber: map['step_number'] as int,
      title: map['title'] as String,
      content: map['content'] as String,
      image: map['image'] as String?,
    );
  }
}
