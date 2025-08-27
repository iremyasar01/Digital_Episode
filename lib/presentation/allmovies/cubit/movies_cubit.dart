

import 'package:digital_episode/data/models/all_movie_model.dart';
import 'package:digital_episode/domain/repositories/home_repository_interface.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final HomeRepositoryInterface homeRepository;

  MoviesCubit(this.homeRepository) : super(MoviesInitial());

  Future<void> loadAllMovies() async {
    emit(MoviesLoading());
    try {
      final movies = await homeRepository.getAllMovies();
      emit(MoviesLoaded(movies));
    } catch (e) {
      emit(MoviesError(e.toString()));
    }
  }
}