import 'package:digital_episode/data/models/all_movie_model.dart';
import 'package:digital_episode/data/models/all_series_model.dart';
import 'package:digital_episode/data/models/new_series_model.dart';
import 'package:digital_episode/data/models/tv_shows_model.dart';
import 'package:digital_episode/presentation/home/cubit/home_state.dart';
import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  final HomeState state;

  const HomeContent({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state is HomeLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is HomeError) {
      return Center(child: Text((state as HomeError).message));
    } else if (state is HomeLoaded) {
      final homeLoaded = state as HomeLoaded;
      return Column(
        children: [
          _buildSection('New Series', homeLoaded.newSeries),
          _buildSection('TV Shows', homeLoaded.tvShows),
          _buildSection('Movies', homeLoaded.movies),
          _buildSection('All Series', homeLoaded.allSeries),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildSection(String title, List<dynamic> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 65, 9, 73),
            ),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              String? name;
              String? posterPath;

              if (item is NewSeriesModel) {
                name = item.name;
                posterPath = item.posterPath;
              } else if (item is TvShowsModel) {
                name = item.name;
                posterPath = item.posterPath;
              } else if (item is AllMoviesModel) {
                name = item.title;
                posterPath = item.posterPath;
              } else if (item is AllSeriesModel) {
                name = item.name;
                posterPath = item.posterPath;
              }

              return Container(
                width: 120,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        "https://image.tmdb.org/t/p/w500$posterPath",
                        width: 100,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      name ?? 'Unknown',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}