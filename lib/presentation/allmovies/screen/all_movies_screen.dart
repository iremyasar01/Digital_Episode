import 'package:digital_episode/presentation/allmovies/cubit/movies_cubit.dart';
import 'package:digital_episode/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllMoviesScreen extends StatefulWidget {
  const AllMoviesScreen({super.key});

  @override
  AllMoviesScreenState createState() => AllMoviesScreenState();
}

class AllMoviesScreenState extends State<AllMoviesScreen> {
  @override
  void initState() {
    super.initState();
    // Local storage'ı başlat
    LocalStorageService.init();
    // Filmleri yükle
    context.read<MoviesCubit>().loadAllMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: MyAppBar(),
      body: BlocBuilder<MoviesCubit, MoviesState>(
        builder: (context, state) {
          if (state is MoviesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MoviesError) {
            return Center(child: Text(state.message));
          } else if (state is MoviesLoaded) {
            return SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: List.generate(state.movies.length, (index) {
                    String posterUrl = "https://image.tmdb.org/t/p/w500${state.movies[index].posterPath}";
                    String name = state.movies[index].title!;
                    String movieId = state.movies[index].id.toString();

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              posterUrl,
                              height: 70,
                              width: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              name,
                              style: const TextStyle(
                                fontSize: 22,
                                color: Color.fromARGB(255, 65, 9, 73),
                              ),
                            ),
                          ),
                          // Favorite Icon
                          IconButton(
                            icon: Icon(
                              LocalStorageService.isFavoriteMovie(movieId)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed: () async {
                              await LocalStorageService.toggleFavoriteMovie(movieId, name, posterUrl);
                              setState(() {});
                            },
                          ),
                          // Watchlist Icon
                          IconButton(
                            icon: Icon(
                              LocalStorageService.isInMovieWatchlist(movieId)
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                              color: Colors.blue,
                            ),
                            onPressed: () async {
                              await LocalStorageService.toggleMovieWatchlist(movieId, name, posterUrl);
                              setState(() {});
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigate to movie details screen if needed
                            },
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: Color.fromARGB(255, 65, 9, 73),
                              size: 23,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            );
          } else {
            return const Center(child: Text("There are no movies."));
          }
        },
      ),
    );
  }
}