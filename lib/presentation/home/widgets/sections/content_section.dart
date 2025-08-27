import 'package:digital_episode/presentation/home/widgets/movie_card.dart';
import 'package:flutter/material.dart';


class ContentSection extends StatelessWidget {
  final String title;
  final List<dynamic> items;
  final Color color;
  final IconData icon;

  const ContentSection({
    super.key,
    required this.title,
    required this.items,
    required this.color,
    required this.icon,
  });

  void _onSeeAllTap(BuildContext context, String category) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navigate to $category page'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 65, 9, 73),
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => _onSeeAllTap(context, title),
                style: TextButton.styleFrom(
                  foregroundColor: color,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "See All",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: color,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.arrow_forward_ios, size: 12, color: color),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 250, // Yüksekliği biraz artırdım
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return MovieCard(
                item: items[index],
                accentColor: color,
                index: index,
              );
            },
          ),
        ),
        const SizedBox(height: 16), // Bölümler arasına boşluk ekledim
      ],
    );
  }
}