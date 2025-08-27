import 'package:digital_episode/core/utils/debouncer.dart';
import 'package:digital_episode/data/models/all_movie_model.dart';
import 'package:digital_episode/data/models/all_series_model.dart';
import 'package:digital_episode/data/models/new_series_model.dart';
import 'package:digital_episode/data/models/tv_shows_model.dart';
import 'package:digital_episode/domain/repositories/home_repository_interface.dart';
import 'package:digital_episode/presentation/home/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Ana sayfa business logic'ini yöneten Cubit sınıfı
/// State yönetimi, veri çekme, arama ve hata yönetimi işlemlerini gerçekleştirir
class HomeCubit extends Cubit<HomeState> {
  final HomeRepositoryInterface _repository;
  final Debouncer _searchDebouncer = Debouncer(milliseconds: 500);

  HomeCubit(this._repository) : super(const HomeInitial());

  /// Tüm ana sayfa verilerini yükler
  Future<void> loadHomeData() async {
    if (state is HomeLoading) return; // Zaten yükleniyorsa tekrar yükleme
    
    emit(const HomeLoading());

    try {
      final homeData = await _repository.loadAllHomeData();
      
      emit(HomeLoaded(
        newSeries: homeData['newSeries'] as List<NewSeriesModel>,
        tvShows: homeData['tvShows'] as List<TvShowsModel>,
        movies: homeData['movies'] as List<AllMoviesModel>,
        allSeries: homeData['allSeries'] as List<AllSeriesModel>,
      ));
    } catch (error) {
      emit(HomeError(_getErrorMessage(error)));
    }
  }

  /// Verileri yeniden yükler (pull-to-refresh için)
  Future<void> refreshHomeData() async {
    await loadHomeData();
  }

  /// Arama modunu açar/kapatır
  void toggleSearch() {
    if (state is! HomeLoaded) return;

    final currentState = state as HomeLoaded;
    
    emit(currentState.copyWith(
      isSearching: !currentState.isSearching,
      searchResults: currentState.isSearching ? [] : currentState.searchResults,
      searchQuery: currentState.isSearching ? '' : currentState.searchQuery,
    ));
  }

  /// Arama sorgusunu günceller (debounce ile)
  void updateSearchQuery(String query) {
    if (state is! HomeLoaded) return;

    final currentState = state as HomeLoaded;
    
    if (query.isEmpty) {
      emit(currentState.copyWith(
        searchResults: const [],
        searchQuery: '',
      ));
      return;
    }

    // Debounce uygula: Kullanıcı yazmayı bitirdikten 500ms sonra arama yap
    _searchDebouncer.run(() {
      final searchResults = _performSearch(currentState, query);
      emit(currentState.copyWith(
        searchResults: searchResults,
        searchQuery: query,
      ));
    });
  }

  /// Aramayı temizler
  void clearSearch() {
    if (state is! HomeLoaded) return;

    final currentState = state as HomeLoaded;
    emit(currentState.copyWith(
      isSearching: false,
      searchResults: const [],
      searchQuery: '',
    ));
  }

  /// Arama işlemini gerçekleştirir - tüm listelerde arar
  List<dynamic> _performSearch(HomeLoaded state, String query) {
    final lowerCaseQuery = query.toLowerCase().trim();
    if (lowerCaseQuery.isEmpty) return [];

    final searchResults = <dynamic>[];

    // Tüm listelerde ara
    searchResults.addAll(
      state.newSeries.where((item) => 
        item.name?.toLowerCase().contains(lowerCaseQuery) ?? false
      ),
    );
    searchResults.addAll(
      state.tvShows.where((item) => 
        item.name?.toLowerCase().contains(lowerCaseQuery) ?? false
      ),
    );
    searchResults.addAll(
      state.movies.where((item) => 
        item.title?.toLowerCase().contains(lowerCaseQuery) ?? false
      ),
    );
    searchResults.addAll(
      state.allSeries.where((item) => 
        item.name?.toLowerCase().contains(lowerCaseQuery) ?? false
      ),
    );

    // Sonuçları sırala: önce tam eşleşme, sonra başlangıç eşleşmesi
    searchResults.sort((a, b) {
      final aName = _getItemName(a)?.toLowerCase() ?? '';
      final bName = _getItemName(b)?.toLowerCase() ?? '';
      
      if (aName == lowerCaseQuery && bName != lowerCaseQuery) return -1;
      if (bName == lowerCaseQuery && aName != lowerCaseQuery) return 1;
      
      if (aName.startsWith(lowerCaseQuery) && !bName.startsWith(lowerCaseQuery)) return -1;
      if (bName.startsWith(lowerCaseQuery) && !aName.startsWith(lowerCaseQuery)) return 1;
      
      return aName.compareTo(bName);
    });

    return searchResults;
  }

  /// Öğenin ismini döndürür - polymorphic davranış
  String? _getItemName(dynamic item) {
    if (item is NewSeriesModel) return item.name;
    if (item is TvShowsModel) return item.name;
    if (item is AllMoviesModel) return item.title;
    if (item is AllSeriesModel) return item.name;
    return null;
  }

  /// Hata mesajını düzenler - kullanıcı dostu hata mesajları
  String _getErrorMessage(dynamic error) {
    final errorString = error.toString();
    
    if (errorString.contains('Failed host lookup')) {
      return 'İnternet bağlantınızı kontrol edin';
    } else if (errorString.contains('Connection timeout')) {
      return 'Bağlantı zaman aşımına uğradı';
    } else if (errorString.contains('401')) {
      return 'API anahtarı geçersiz';
    } else if (errorString.contains('404')) {
      return 'Veri bulunamadı';
    } else if (errorString.contains('500')) {
      return 'Sunucu hatası, lütfen daha sonra tekrar deneyin';
    }
    
    return 'Bir hata oluştu, lütfen tekrar deneyin';
  }

  @override
  Future<void> close() {
    _searchDebouncer.dispose(); // Debouncer'ı temizle
    return super.close();
  }
}