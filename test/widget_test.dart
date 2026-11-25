import 'package:flutter_test/flutter_test.dart';
import 'package:dayguide/data/models/category_model.dart';
import 'package:dayguide/data/models/guide_model.dart';
import 'package:dayguide/data/models/guide_step_model.dart';
import 'package:dayguide/data/models/bookmark_model.dart';
import 'package:dayguide/data/models/reading_history_model.dart';

void main() {
  group('DAYGUIDE Schema Models Test', () {
    test('CategoryModel serialization and deserialization', () {
      final category = CategoryModel(
        id: 1,
        name: 'Kehidupan Sehari-hari',
        description: 'Tips praktis rutinitas harian',
        icon: 'cottage',
        color: '#6EE7B7',
      );

      final map = category.toMap();
      expect(map['id'], 1);
      expect(map['name'], 'Kehidupan Sehari-hari');
      expect(map['color'], '#6EE7B7');

      final fromMap = CategoryModel.fromMap(map);
      expect(fromMap.id, 1);
      expect(fromMap.name, 'Kehidupan Sehari-hari');
      expect(fromMap.color, '#6EE7B7');
    });

    test('GuideModel and GuideStepModel serialization', () {
      final step = GuideStepModel(
        id: 1,
        guideId: 1,
        stepNumber: 1,
        title: 'Hitung Pemasukan Bersih',
        content: 'Hitung seluruh pemasukan bulanan.',
      );

      final stepMap = step.toMap();
      expect(stepMap['guide_id'], 1);
      expect(stepMap['step_number'], 1);

      final guide = GuideModel(
        id: 1,
        categoryId: 3,
        title: 'Cara Mengatur Keuangan Bulanan dengan Metode 50/30/20',
        description: 'Alokasikan 50/30/20 untuk gaji bulanan.',
        thumbnail: 'https://example.com/image.jpg',
        difficulty: 'Pemula',
        estimatedMinutes: 5,
        source: 'OJK',
        steps: [step],
        isBookmarked: true,
        readProgress: 75,
      );

      final guideMap = guide.toMap();
      expect(guideMap['category_id'], 3);
      expect(guideMap['estimated_minutes'], 5);
      expect(guide.steps?.length, 1);
      expect(guide.isBookmarked, true);
      expect(guide.readProgress, 75);
    });

    test('BookmarkModel and ReadingHistoryModel serialization', () {
      final bookmark = BookmarkModel(
        id: 1,
        guideId: 2,
        savedAt: '2026-11-24T12:00:00Z',
      );
      expect(bookmark.toMap()['guide_id'], 2);

      final history = ReadingHistoryModel(
        id: 1,
        guideId: 2,
        lastReadAt: '2026-11-24T12:00:00Z',
        progress: 100,
      );
      expect(history.toMap()['progress'], 100);
    });
  });
}
