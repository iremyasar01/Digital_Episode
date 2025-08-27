

import 'package:digital_episode/data/models/all_movie_model.dart';
import 'package:digital_episode/data/models/all_series_model.dart';
import 'package:digital_episode/data/models/new_series_model.dart';
import 'package:digital_episode/data/models/tv_shows_model.dart';
import 'package:digital_episode/domain/repositories/home_repository_interface.dart';
import 'package:digital_episode/presentation/home/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepositoryInterface _repository;

  HomeCubit(this._repository) : super(const HomeInitial());

  /// Ana veri yükleme fonksiyonu
  Future<void> loadHomeData() async {
    if (state is HomeLoading) return; // Zaten yükleniyor
    
    try {
      emit(const HomeLoading());

      // Paralel olarak tüm veriyi yükle
      final results = await Future.wait([
        _repository.getNewSeries(),
        _repository.getTvShows(),
        _repository.getAllMovies(),
        _repository.getAllSeries(),
      ]);

      emit(HomeLoaded(
        newSeries: results[0] as List<NewSeriesModel>,
        tvShows: results[1] as List<TvShowsModel>,
        movies: results[2] as List<AllMoviesModel>,
        allSeries: results[3] as List<AllSeriesModel>,
      ));
    } catch (error) {
      emit(HomeError(_getErrorMessage(error), errorCode: _getErrorCode(error)));
    }
  }

  /// Refresh - veriyi yeniden yükle
  Future<void> refreshHomeData() async {
    await loadHomeData();
  }

  /// Arama modunu aç/kapat
  void toggleSearch() {
    if (state is! HomeLoaded) return;

    final currentState = state as HomeLoaded;
    
    emit(currentState.copyWith(
      isSearching: !currentState.isSearching,
      searchResults: currentState.isSearching ? [] : currentState.searchResults,
      searchQuery: currentState.isSearching ? '' : currentState.searchQuery,
    ));
  }

  /// Arama sorgusunu güncelle
  void updateSearchQuery(String query) {
    if (state is! HomeLoaded) return;

    final currentState = state as HomeLoaded;
    
    if (query.isEmpty) {
      emit(currentState.copyWith(
        searchResults: [],
        searchQuery: '',
      ));
      return;
    }

    final searchResults = _performSearch(currentState, query);
    
    emit(currentState.copyWith(
      searchResults: searchResults,
      searchQuery: query,
    ));
  }

  /// Aramayı temizle
  void clearSearch() {
    if (state is! HomeLoaded) return;

    final currentState = state as HomeLoaded;
    emit(currentState.copyWith(
      isSearching: false,
      searchResults: [],
      searchQuery: '',
    ));
  }

  /// Arama işlemini gerçekleştir
  List<dynamic> _performSearch(HomeLoaded state, String query) {
    final lowerCaseQuery = query.toLowerCase().trim();
    
    if (lowerCaseQuery.isEmpty) return [];

    final searchResults = <dynamic>[];

    // New Series'te ara
    searchResults.addAll(
      state.newSeries.where((item) => 
        item.name?.toLowerCase().contains(lowerCaseQuery) ?? false
      ),
    );

    // TV Shows'ta ara
    searchResults.addAll(
      state.tvShows.where((item) => 
        item.name?.toLowerCase().contains(lowerCaseQuery) ?? false
      ),
    );

    // Movies'te ara
    searchResults.addAll(
      state.movies.where((item) => 
        item.title?.toLowerCase().contains(lowerCaseQuery) ?? false
      ),
    );

    // All Series'te ara
    searchResults.addAll(
      state.allSeries.where((item) => 
        item.name?.toLowerCase().contains(lowerCaseQuery) ?? false
      ),
    );

    // Sonuçları skorlayalım (tam eşleşme > başlangıç eşleşmesi > içerik eşleşmesi)
    searchResults.sort((a, b) {
      final aName = _getItemName(a)?.toLowerCase() ?? '';
      final bName = _getItemName(b)?.toLowerCase() ?? '';
      
      // Tam eşleşme kontrolü
      if (aName == lowerCaseQuery && bName != lowerCaseQuery) return -1;
      if (bName == lowerCaseQuery && aName != lowerCaseQuery) return 1;
      
      // Başlangıç eşleşmesi kontrolü
      if (aName.startsWith(lowerCaseQuery) && !bName.startsWith(lowerCaseQuery)) return -1;
      if (bName.startsWith(lowerCaseQuery) && !aName.startsWith(lowerCaseQuery)) return 1;
      
      // Alfabetik sıralama
      return aName.compareTo(bName);
    });

    return searchResults;
  }

  /// Item'dan isim çıkar
  String? _getItemName(dynamic item) {
    if (item is NewSeriesModel) return item.name;
    if (item is TvShowsModel) return item.name;
    if (item is AllMoviesModel) return item.title;
    if (item is AllSeriesModel) return item.name;
    return null;
  }

  /// Hata mesajını düzenle
  String _getErrorMessage(dynamic error) {
    final errorString = error.toString();
    
    if (errorString.contains('Failed to host lookup')) {
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

  /// Hata kodunu çıkar
  String? _getErrorCode(dynamic error) {
    final errorString = error.toString();
    
    if (errorString.contains('401')) return '401';
    if (errorString.contains('404')) return '404';
    if (errorString.contains('500')) return '500';
    if (errorString.contains('timeout')) return 'TIMEOUT';
    if (errorString.contains('network')) return 'NETWORK';
    
    return null;
  }

  @override
  void onChange(Change<HomeState> change) {
    super.onChange(change);
    debugPrint('🔄 HomeState changed: ${change.currentState} -> ${change.nextState}');
  }
}