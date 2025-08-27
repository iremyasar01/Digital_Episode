/*
import 'package:digital_episode/presentation/common/widgets/image_placeholder.dart';
import 'package:digital_episode/presentation/home/cubit/home_cubit.dart';
import 'package:digital_episode/presentation/home/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AiringTodayWidget extends StatelessWidget {
  const AiringTodayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoaded) {
          final airingTodayShows = state.tvShows.take(10).toList();
          
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Airing Today",
                      style: TextStyle(
                        color: Color.fromARGB(255, 65, 9, 73),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AiringTodayScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "see all",
                        style: TextStyle(
                          color: Color.fromARGB(255, 65, 9, 73),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(airingTodayShows.length, (index) {
                    final show = airingTodayShows[index];
                    final posterUrl = show.posterPath != null
                        ? "https://image.tmdb.org/t/p/w500${show.posterPath}"
                        : null;
                    
                    return Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: posterUrl != null
                                ? Image.network(
                                    posterUrl,
                                    height: 300,
                                    width: 200,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        const ImagePlaceholder(width: 200, height: 300),
                                  )
                                : const ImagePlaceholder(width: 200, height: 300),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 200,
                            child: Text(
                              show.name ?? 'Unknown',
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
*/