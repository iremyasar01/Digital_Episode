import 'package:digital_episode/data/models/all_movie_model.dart';
import 'package:digital_episode/data/models/all_series_model.dart';
import 'package:digital_episode/data/models/new_series_model.dart';
import 'package:digital_episode/data/models/tv_shows_model.dart';
import 'package:flutter/material.dart';


class MovieCard extends StatelessWidget {
  final dynamic item;
  final Color accentColor;
  final int index;

  const MovieCard({
    super.key,
    required this.item,
    required this.accentColor,
    required this.index,
  });

  void _onItemTap(BuildContext context, dynamic item) {
    String itemName = "Unknown";
    
    if (item is NewSeriesModel) {
      itemName = item.name ?? "Unknown";
    } else if (item is TvShowsModel) {
      itemName = item.name ?? "Unknown";
    } else if (item is AllMoviesModel) {
      itemName = item.title ?? "Unknown";
    } else if (item is AllSeriesModel) {
      itemName = item.name ?? "Unknown";
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening $itemName'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  Widget _buildErrorPlaceholder(Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.broken_image_outlined, color: color, size: 40),
          const SizedBox(height: 8),
          Text(
            "No Image",
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
      width: 140,
      margin: const EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: () => _onItemTap(context, item),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Bu satırı ekleyin
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster container
            Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: accentColor.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: posterPath != null
                        ? Image.network(
                            "https://image.tmdb.org/t/p/w500$posterPath",
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return _buildErrorPlaceholder(accentColor);
                            },
                          )
                        : _buildErrorPlaceholder(accentColor),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                        stops: const [0.6, 1.0],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: accentColor.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "HD",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom: 8,
                    right: 8,
                    child: Icon(
                      Icons.play_circle_filled,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8), // 12'den 8'e düşürdüm
            // Title
            Text(
              name ?? 'Unknown',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 65, 9, 73),
                height: 1.3,
              ),
            ),
            const SizedBox(height: 4),
            // Rating
            Row(
              children: [
                Icon(Icons.star, size: 12, color: Colors.amber[600]),
                const SizedBox(width: 4),
                Text(
                  "8.5",
                  style: TextStyle(
                    fontSize: 11, // Boyutu biraz küçülttüm
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "2023",
                  style: TextStyle(
                    fontSize: 11, // Boyutu biraz küçülttüm
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}