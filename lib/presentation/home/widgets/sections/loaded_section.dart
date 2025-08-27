import 'package:digital_episode/presentation/home/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'content_section.dart';

class LoadedSection extends StatelessWidget {
  final HomeLoaded loadedState;

  const LoadedSection({super.key, required this.loadedState});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (loadedState.newSeries.isNotEmpty)
          ContentSection(
            title: 'New Series',
            items: loadedState.newSeries,
            color: Colors.blue,
            icon: Icons.new_releases_outlined,
          ),
        if (loadedState.tvShows.isNotEmpty)
          ContentSection(
            title: 'TV Shows',
            items: loadedState.tvShows,
            color: Colors.green,
            icon: Icons.tv_outlined,
          ),
        if (loadedState.movies.isNotEmpty)
          ContentSection(
            title: 'Movies',
            items: loadedState.movies,
            color: Colors.orange,
            icon: Icons.movie_outlined,
          ),
        if (loadedState.allSeries.isNotEmpty)
          ContentSection(
            title: 'All Series',
            items: loadedState.allSeries,
            color: Colors.purple,
            icon: Icons.video_library_outlined,
          ),
      ],
    );
  }
}