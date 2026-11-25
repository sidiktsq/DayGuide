import 'package:flutter/foundation.dart';
import '../data/models/category_model.dart';
import '../data/models/guide_model.dart';
import '../data/repositories/guide_repository.dart';

class GuideProvider with ChangeNotifier {
  final GuideRepository _repository = GuideRepository();

  List<CategoryModel> _categories = [];
  List<GuideModel> _allGuides = [];
  List<GuideModel> _searchResults = [];
  bool _isLoading = false;
  String _searchQuery = '';
  int? _selectedCategoryId;

  List<CategoryModel> get categories => _categories;
  List<GuideModel> get allGuides => _allGuides;
  List<GuideModel> get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;
  int? get selectedCategoryId => _selectedCategoryId;

  // Featured Guide (e.g. 50/30/20 Finance)
  GuideModel? get featuredGuide {
    if (_allGuides.isEmpty) return null;
    return _allGuides.firstWhere(
      (g) => g.id == 1,
      orElse: () => _allGuides.first,
    );
  }

  // Popular Guides
  List<GuideModel> get popularGuides {
    return _allGuides.where((g) => g.id == 2 || g.id == 3 || g.id == 5).toList();
  }

  // Recently Added
  List<GuideModel> get recentGuides {
    return _allGuides.where((g) => g.id == 4 || g.id == 7 || g.id == 8).toList();
  }

  Future<void> loadInitialData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _categories = await _repository.getAllCategories();
      _allGuides = await _repository.getAllGuides();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading initial data: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<List<GuideModel>> getGuidesByCategory(int categoryId) async {
    return await _repository.getAllGuides(categoryId: categoryId);
  }

  Future<GuideModel?> getGuideDetail(int guideId) async {
    return await _repository.getGuideById(guideId);
  }

  Future<void> searchGuides(String query, {int? categoryId}) async {
    _searchQuery = query;
    _selectedCategoryId = categoryId;
    _isLoading = true;
    notifyListeners();

    try {
      _searchResults = await _repository.getAllGuides(
        categoryId: categoryId,
        searchQuery: query,
      );
    } catch (e) {
      _searchResults = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearSearch() {
    _searchQuery = '';
    _selectedCategoryId = null;
    _searchResults = [];
    notifyListeners();
  }

  Future<void> refresh() async {
    _allGuides = await _repository.getAllGuides();
    notifyListeners();
  }
}
