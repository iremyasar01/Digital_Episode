import 'package:digital_episode/core/network/dio_client.dart';
import 'package:digital_episode/data/models/all_movie_model.dart';
import 'package:digital_episode/data/models/all_series_model.dart';
import 'package:digital_episode/data/models/new_series_model.dart';
import 'package:digital_episode/data/models/tv_shows_model.dart';
import 'package:digital_episode/domain/repositories/home_repository_interface.dart';
import 'package:dio/dio.dart';

/// Ana sayfa verilerini yöneten repository sınıfı
/// API çağrılarını merkezileştirir ve veri dönüşümlerini yönetir
class HomeRepository implements HomeRepositoryInterface {
  final DioClient _dioClient;

  HomeRepository(this._dioClient);

  @override
  Future<List<NewSeriesModel>> getNewSeries() async {
    final response = await _dioClient.get('/tv/airing_today');
    return _parseResponse<NewSeriesModel>(response, NewSeriesModel.fromJson);
  }

  @override
  Future<List<TvShowsModel>> getTvShows() async {
    final response = await _dioClient.get('/trending/tv/week');
    return _parseResponse<TvShowsModel>(response, TvShowsModel.fromJson);
  }

  @override
  Future<List<AllMoviesModel>> getAllMovies() async {
    final response = await _dioClient.get('/movie/popular');
    return _parseResponse<AllMoviesModel>(response, AllMoviesModel.fromJson);
  }

  @override
  Future<List<AllSeriesModel>> getAllSeries() async {
    final response = await _dioClient.get('/tv/popular');
    return _parseResponse<AllSeriesModel>(response, AllSeriesModel.fromJson);
  }

  /// Yardımcı metod: API yanıtını parse eder ve modele dönüştürür
  List<T> _parseResponse<T>(Response response, T Function(Map<String, dynamic>) fromJson) {
    if (response.data == null || response.data['results'] == null) {
      throw Exception('Invalid response format');
    }
    
    final responseList = response.data['results'] as List;
    return responseList.map((item) => fromJson(item)).toList();
  }

  /// Tüm ana sayfa verilerini paralel olarak yükler
  /// Bu sayede tek seferde tüm verileri alır ve performansı artırır
  Future<Map<String, List<dynamic>>> loadAllHomeData() async {
    try {
      final results = await Future.wait([
        getNewSeries(),
        getTvShows(),
        getAllMovies(),
        getAllSeries(),
      ], eagerError: true); // eagerError: true -> hata durumunda hemen throw eder

      return {
        'newSeries': results[0],
        'tvShows': results[1],
        'movies': results[2],
        'allSeries': results[3],
      };
    } catch (e) {
      throw Exception('Failed to load home data: ${e.toString()}');
    }
  }
}