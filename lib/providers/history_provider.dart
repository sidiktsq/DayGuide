import 'package:flutter/foundation.dart';
import '../data/models/guide_model.dart';
import '../data/repositories/guide_repository.dart';

class HistoryProvider with ChangeNotifier {
  final GuideRepository _repository = GuideRepository();

  List<GuideModel> _historyGuides = [];
  bool _isLoading = false;

  List<GuideModel> get historyGuides => _historyGuides;
  bool get isLoading => _isLoading;

  int get completedCount {
    return _historyGuides.where((g) => (g.readProgress ?? 0) >= 100).length;
  }

  int get totalGuidesRead => _historyGuides.length;

  Future<void> loadHistory() async {
    _isLoading = true;
    notifyListeners();

    try {
      _historyGuides = await _repository.getReadingHistory();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading reading history: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> recordProgress(int guideId, int progress) async {
    await _repository.updateReadingProgress(guideId, progress);
    await loadHistory();
  }

  Future<void> markCompleted(int guideId) async {
    await _repository.updateReadingProgress(guideId, 100);
    await loadHistory();
  }

  Future<void> clearAll() async {
    await _repository.clearReadingHistory();
    _historyGuides = [];
    notifyListeners();
  }
}
