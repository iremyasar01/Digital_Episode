import 'package:digital_episode/data/models/all_movie_model.dart';
import 'package:digital_episode/data/models/all_series_model.dart';
import 'package:digital_episode/data/models/new_series_model.dart';
import 'package:digital_episode/data/models/tv_shows_model.dart';
import 'package:equatable/equatable.dart';

/// Ana sayfa state'lerini temsil eden abstract sınıf
/// Tüm state'ler bu sınıftan türer
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

/// İlk state - veri yüklenmemiş
class HomeInitial extends HomeState {
  const HomeInitial();
}

/// Yükleme state'i - veriler yükleniyor
class HomeLoading extends HomeState {
  const HomeLoading();
}

/// Yüklendi state'i - veriler başarıyla yüklendi
class HomeLoaded extends HomeState {
  final List<NewSeriesModel> newSeries;
  final List<TvShowsModel> tvShows;
  final List<AllMoviesModel> movies;
  final List<AllSeriesModel> allSeries;
  final bool isSearching;
  final List<dynamic> searchResults;
  final String searchQuery;

  const HomeLoaded({
    required this.newSeries,
    required this.tvShows,
    required this.movies,
    required this.allSeries,
    this.isSearching = false,
    this.searchResults = const [],
    this.searchQuery = '',
  });

  /// State'i kopyalar - immutable state yönetimi için
  HomeLoaded copyWith({
    List<NewSeriesModel>? newSeries,
    List<TvShowsModel>? tvShows,
    List<AllMoviesModel>? movies,
    List<AllSeriesModel>? allSeries,
    bool? isSearching,
    List<dynamic>? searchResults,
    String? searchQuery,
  }) {
    return HomeLoaded(
      newSeries: newSeries ?? this.newSeries,
      tvShows: tvShows ?? this.tvShows,
      movies: movies ?? this.movies,
      allSeries: allSeries ?? this.allSeries,
      isSearching: isSearching ?? this.isSearching,
      searchResults: searchResults ?? this.searchResults,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  // Kolay erişim için getter'lar
  bool get hasSearchResults => searchResults.isNotEmpty;
  bool get isSearchActive => isSearching && searchQuery.isNotEmpty;
  int get totalItemsCount => newSeries.length + tvShows.length + movies.length + allSeries.length;

  @override
  List<Object?> get props => [
        newSeries,
        tvShows,
        movies,
        allSeries,
        isSearching,
        searchResults,
        searchQuery,
      ];

  @override
  String toString() {
    return 'HomeLoaded(newSeries: ${newSeries.length}, tvShows: ${tvShows.length}, '
           'movies: ${movies.length}, allSeries: ${allSeries.length}, '
           'isSearching: $isSearching, searchQuery: $searchQuery)';
  }
}

/// Hata state'i - veri yükleme sırasında hata oluştu
class HomeError extends HomeState {
  final String message;
  final String? errorCode;

  const HomeError(this.message, {this.errorCode});

  @override
  List<Object?> get props => [message, errorCode];

  @override
  String toString() => 'HomeError(message: $message, errorCode: $errorCode)';
}