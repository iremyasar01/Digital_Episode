import 'package:digital_episode/data/models/all_movie_model.dart';
import 'package:digital_episode/data/models/all_series_model.dart';
import 'package:digital_episode/data/models/new_series_model.dart';
import 'package:digital_episode/data/models/tv_shows_model.dart';

abstract class HomeRepositoryInterface {
  Future<List<NewSeriesModel>> getNewSeries();
  Future<List<TvShowsModel>> getTvShows();
  Future<List<AllMoviesModel>> getAllMovies();
  Future<List<AllSeriesModel>> getAllSeries();
}