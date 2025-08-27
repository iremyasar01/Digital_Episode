import 'package:dio/dio.dart';
import 'package:digital_episode/core/constants/api_constants.dart';
import 'package:digital_episode/data/models/all_movie_model.dart';
import 'package:digital_episode/data/models/all_series_model.dart';
import 'package:digital_episode/data/models/episode_model.dart';
import 'package:digital_episode/data/models/new_series_model.dart';
import 'package:digital_episode/data/models/seasons_model.dart';
import 'package:digital_episode/data/models/tv_shows_model.dart';
import 'package:flutter/material.dart';

class TVRepository {
  final String _baseurl = ApiConstants.BASE_URL;
  final String _apiKey = ApiConstants.API_KEY;
  late final Dio _dio;

  TVRepository() {
    _dio = Dio(BaseOptions(
      baseUrl: _baseurl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        debugPrint('RESPONSE[${response.statusCode}]');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        debugPrint('ERROR[${e.response?.statusCode}] => ${e.message}');
        return handler.next(e);
      },
    ));
  }

  Future<List<TvShowsModel>> getShows() async {
    try {
      final response = await _dio.get(
        '/trending/tv/week',
        queryParameters: {'api_key': _apiKey},
      );
      
      final responseList = response.data['results'] as List;
      return responseList.map((item) => TvShowsModel.fromJson(item)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to load shows: ${e.message}');
    }
  }

  Future<List<NewSeriesModel>> getNewSeries() async {
    try {
      final response = await _dio.get(
        '/tv/airing_today',
        queryParameters: {'api_key': _apiKey},
      );
      
      final responseList = response.data['results'] as List;
      return responseList.map((item) => NewSeriesModel.fromJson(item)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to load new series: ${e.message}');
    }
  }

  Future<List<AllMoviesModel>> getAllMovies() async {
    try {
      final response = await _dio.get(
        '/movie/popular',
        queryParameters: {'api_key': _apiKey},
      );
      
      final responseList = response.data['results'] as List;
      return responseList.map((item) => AllMoviesModel.fromJson(item)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to load movies: ${e.message}');
    }
  }

  Future<List<AllSeriesModel>> getAllSeries() async {
    try {
      final response = await _dio.get(
        '/tv/popular',
        queryParameters: {'api_key': _apiKey},
      );
      
      final responseList = response.data['results'] as List;
      return responseList.map((item) => AllSeriesModel.fromJson(item)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to load all series: ${e.message}');
    }
  }

  Future<List<Season>> getSeasons(int seriesId) async {
    try {
      final response = await _dio.get(
        '/tv/$seriesId',
        queryParameters: {
          'api_key': _apiKey,
          'append_to_response': 'seasons'
        },
      );
      
      final seasons = response.data['seasons'] as List;
      return seasons.map((season) => Season.fromJson(season)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to load seasons: ${e.message}');
    }
  }

  Future<List<EpisodeModel>> getEpisodes(int seriesId, int seasonNumber) async {
    try {
      final response = await _dio.get(
        '/tv/$seriesId/season/$seasonNumber',
        queryParameters: {'api_key': _apiKey},
      );
      
      final episodes = response.data['episodes'] as List;
      return episodes.map((episode) => EpisodeModel.fromJson(episode)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to load episodes: ${e.message}');
    }
  }
}