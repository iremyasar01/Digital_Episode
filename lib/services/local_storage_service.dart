// services/local_storage_service.dart
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Favori filmler
  static Future<void> toggleFavoriteMovie(String movieId, String title, String posterUrl) async {
    final key = 'favorite_movies';
    final String movieData = '$movieId,$title,$posterUrl';
    List<String> favorites = _preferences?.getStringList(key) ?? [];
    
    if (favorites.contains(movieData)) {
      favorites.remove(movieData);
    } else {
      favorites.add(movieData);
    }
    
    await _preferences?.setStringList(key, favorites);
  }

  static List<String> getFavoriteMovies() {
    return _preferences?.getStringList('favorite_movies') ?? [];
  }

  static bool isFavoriteMovie(String movieId) {
    final favorites = getFavoriteMovies();
    return favorites.any((element) => element.split(',')[0] == movieId);
  }

  // Film izleme listesi
  static Future<void> toggleMovieWatchlist(String movieId, String title, String posterUrl) async {
    final key = 'movie_watchlist';
    final String movieData = '$movieId,$title,$posterUrl';
    List<String> watchlist = _preferences?.getStringList(key) ?? [];
    
    if (watchlist.contains(movieData)) {
      watchlist.remove(movieData);
    } else {
      watchlist.add(movieData);
    }
    
    await _preferences?.setStringList(key, watchlist);
  }

  static List<String> getMovieWatchlist() {
    return _preferences?.getStringList('movie_watchlist') ?? [];
  }

  static bool isInMovieWatchlist(String movieId) {
    final watchlist = getMovieWatchlist();
    return watchlist.any((element) => element.split(',')[0] == movieId);
  }

  // Diziler için de benzer metodlar...
  static Future<void> toggleFavoriteSeries(String seriesId, String title, String posterUrl) async {
    final key = 'favorite_series';
    final String seriesData = '$seriesId,$title,$posterUrl';
    List<String> favorites = _preferences?.getStringList(key) ?? [];
    
    if (favorites.contains(seriesData)) {
      favorites.remove(seriesData);
    } else {
      favorites.add(seriesData);
    }
    
    await _preferences?.setStringList(key, favorites);
  }

  static bool isFavoriteSeries(String seriesId) {
    final favorites = _preferences?.getStringList('favorite_series') ?? [];
    return favorites.any((element) => element.split(',')[0] == seriesId);
  }

  static Future<void> toggleSeriesWatchlist(String seriesId, String title, String posterUrl) async {
    final key = 'series_watchlist';
    final String seriesData = '$seriesId,$title,$posterUrl';
    List<String> watchlist = _preferences?.getStringList(key) ?? [];
    
    if (watchlist.contains(seriesData)) {
      watchlist.remove(seriesData);
    } else {
      watchlist.add(seriesData);
    }
    
    await _preferences?.setStringList(key, watchlist);
  }

  static bool isInSeriesWatchlist(String seriesId) {
    final watchlist = _preferences?.getStringList('series_watchlist') ?? [];
    return watchlist.any((element) => element.split(',')[0] == seriesId);
  }
}