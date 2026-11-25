import 'package:dayguide/data/models/category_model.dart';
import 'package:dayguide/data/models/guide_model.dart';
import 'package:dayguide/data/models/guide_step_model.dart';
import 'package:dayguide/data/models/bookmark_model.dart';
import 'package:dayguide/data/models/reading_history_model.dart';

void main() {
  print('Running DAYGUIDE schema and model unit tests...');

  // 1. CategoryModel
  final cat = CategoryModel(
    id: 1,
    name: 'Kehidupan Sehari-hari',
    description: 'Tips praktis rutinitas harian',
    icon: 'cottage',
    color: '#6EE7B7',
  );
  assert(cat.id == 1);
  assert(cat.name == 'Kehidupan Sehari-hari');
  assert(cat.color == '#6EE7B7');
  final catMap = cat.toMap();
  final catFromMap = CategoryModel.fromMap(catMap);
  assert(catFromMap.name == 'Kehidupan Sehari-hari');
  print('✓ CategoryModel serialization verified');

  // 2. GuideStepModel
  final step = GuideStepModel(
    id: 1,
    guideId: 1,
    stepNumber: 1,
    title: 'Hitung Pemasukan Bersih',
    content: 'Hitung seluruh pemasukan bulanan.',
  );
  assert(step.guideId == 1);
  assert(step.stepNumber == 1);
  final stepMap = step.toMap();
  final stepFromMap = GuideStepModel.fromMap(stepMap);
  assert(stepFromMap.title == 'Hitung Pemasukan Bersih');
  print('✓ GuideStepModel serialization verified');

  // 3. GuideModel
  final guide = GuideModel(
    id: 1,
    categoryId: 3,
    title: 'Cara Mengatur Keuangan Bulanan dengan Metode 50/30/20',
    description: 'Budgeting 50/30/20',
    difficulty: 'Pemula',
    estimatedMinutes: 5,
    source: 'OJK',
    steps: [step],
    isBookmarked: true,
    readProgress: 75,
  );
  assert(guide.id == 1);
  assert(guide.estimatedMinutes == 5);
  assert(guide.isBookmarked == true);
  assert(guide.readProgress == 75);
  final guideMap = guide.toMap();
  final guideFromMap = GuideModel.fromMap(guideMap, steps: [step], isBookmarked: true, readProgress: 75);
  assert(guideFromMap.title == guide.title);
  assert(guideFromMap.steps?.length == 1);
  print('✓ GuideModel serialization verified');

  // 4. BookmarkModel
  final bm = BookmarkModel(
    id: 1,
    guideId: 1,
    savedAt: '2026-11-24T12:00:00Z',
  );
  assert(bm.guideId == 1);
  final bmMap = bm.toMap();
  final bmFromMap = BookmarkModel.fromMap(bmMap);
  assert(bmFromMap.guideId == 1);
  print('✓ BookmarkModel serialization verified');

  // 5. ReadingHistoryModel
  final rh = ReadingHistoryModel(
    id: 1,
    guideId: 1,
    lastReadAt: '2026-11-24T12:00:00Z',
    progress: 80,
  );
  assert(rh.guideId == 1);
  assert(rh.progress == 80);
  final rhMap = rh.toMap();
  final rhFromMap = ReadingHistoryModel.fromMap(rhMap);
  assert(rhFromMap.progress == 80);
  print('✓ ReadingHistoryModel serialization verified');

  print('All DAYGUIDE schema and model unit tests passed successfully!');
}
