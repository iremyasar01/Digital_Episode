
import 'package:digital_episode/core/network/dio_client.dart';
import 'package:digital_episode/data/models/all_movie_model.dart';
import 'package:digital_episode/data/models/all_series_model.dart';
import 'package:digital_episode/data/models/new_series_model.dart';
import 'package:digital_episode/data/models/tv_shows_model.dart';
import 'package:digital_episode/domain/repositories/home_repository_interface.dart';

class HomeRepository implements HomeRepositoryInterface {
  final DioClient _dioClient;

  HomeRepository(this._dioClient);

  @override
  Future<List<NewSeriesModel>> getNewSeries() async {
    try {
      final response = await _dioClient.get('/tv/airing_today');
      
      if (response.data == null || response.data['results'] == null) {
        throw Exception('Invalid response format for new series');
      }
      
      final responseList = response.data['results'] as List;
      return responseList
          .map((item) => NewSeriesModel.fromJson(item))
          .toList();
    } catch (e) {
      throw Exception('Failed to load new series: ${e.toString()}');
    }
  }

  @override
  Future<List<TvShowsModel>> getTvShows() async {
    try {
      final response = await _dioClient.get('/trending/tv/week');
      
      if (response.data == null || response.data['results'] == null) {
        throw Exception('Invalid response format for TV shows');
      }
      
      final responseList = response.data['results'] as List;
      return responseList
          .map((item) => TvShowsModel.fromJson(item))
          .toList();
    } catch (e) {
      throw Exception('Failed to load TV shows: ${e.toString()}');
    }
  }

  @override
  Future<List<AllMoviesModel>> getAllMovies() async {
    try {
      final response = await _dioClient.get('/movie/popular');
      
      if (response.data == null || response.data['results'] == null) {
        throw Exception('Invalid response format for movies');
      }
      
      final responseList = response.data['results'] as List;
      return responseList
          .map((item) => AllMoviesModel.fromJson(item))
          .toList();
    } catch (e) {
      throw Exception('Failed to load movies: ${e.toString()}');
    }
  }

  @override
  Future<List<AllSeriesModel>> getAllSeries() async {
    try {
      final response = await _dioClient.get('/tv/popular');
      
      if (response.data == null || response.data['results'] == null) {
        throw Exception('Invalid response format for series');
      }
      
      final responseList = response.data['results'] as List;
      return responseList
          .map((item) => AllSeriesModel.fromJson(item))
          .toList();
    } catch (e) {
      throw Exception('Failed to load series: ${e.toString()}');
    }
  }

  // Batch loading - tüm veriyi tek seferde yükle
  Future<Map<String, List<dynamic>>> loadAllHomeData() async {
    try {
      final results = await Future.wait([
        getNewSeries(),
        getTvShows(),
        getAllMovies(),
        getAllSeries(),
      ]);

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