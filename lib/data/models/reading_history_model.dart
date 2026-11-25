class ReadingHistoryModel {
  final int? id;
  final int guideId;
  final String lastReadAt;
  final int progress;

  ReadingHistoryModel({
    this.id,
    required this.guideId,
    required this.lastReadAt,
    required this.progress,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'guide_id': guideId,
      'last_read_at': lastReadAt,
      'progress': progress,
    };
  }

  factory ReadingHistoryModel.fromMap(Map<String, dynamic> map) {
    return ReadingHistoryModel(
      id: map['id'] as int?,
      guideId: map['guide_id'] as int,
      lastReadAt: map['last_read_at'] as String,
      progress: map['progress'] as int,
    );
  }
}
