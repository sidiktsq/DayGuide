class BookmarkModel {
  final int? id;
  final int guideId;
  final String savedAt;

  BookmarkModel({
    this.id,
    required this.guideId,
    required this.savedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'guide_id': guideId,
      'saved_at': savedAt,
    };
  }

  factory BookmarkModel.fromMap(Map<String, dynamic> map) {
    return BookmarkModel(
      id: map['id'] as int?,
      guideId: map['guide_id'] as int,
      savedAt: map['saved_at'] as String,
    );
  }
}
