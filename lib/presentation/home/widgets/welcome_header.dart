import 'package:flutter/material.dart';

class HomeWelcomeHeader extends StatelessWidget {
  final String? userName;
  
  const HomeWelcomeHeader({
    super.key,
    this.userName,
  });

  @override
  Widget build(BuildContext context) {
    final currentHour = DateTime.now().hour;
    final greeting = _getGreeting(currentHour);
    
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.purple.shade50,
            Colors.white,
            Colors.purple,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  greeting.emoji,
                  style: const TextStyle(fontSize: 32),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${greeting.text}${userName != null ? ', $userName' : ''}!",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 65, 9, 73),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "What would you like to watch today?",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildQuickStats(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStats() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.purple.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            icon: Icons.movie_outlined,
            label: "Movies",
            color: Colors.blue,
          ),
          _buildStatItem(
            icon: Icons.tv_outlined,
            label: "Series",
            color: Colors.green,
          ),
          _buildStatItem(
            icon: Icons.trending_up,
            label: "Trending",
            color: Colors.orange,
          ),
          _buildStatItem(
            icon: Icons.fiber_new_outlined,
            label: "New",
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  GreetingModel _getGreeting(int hour) {
    if (hour < 6) {
      return GreetingModel("Good night", "🌙");
    } else if (hour < 12) {
      return GreetingModel("Good morning", "🌅");
    } else if (hour < 17) {
      return GreetingModel("Good afternoon", "☀️");
    } else if (hour < 21) {
      return GreetingModel("Good evening", "🌆");
    } else {
      return GreetingModel("Good night", "🌙");
    }
  }
}

class GreetingModel {
  final String text;
  final String emoji;

  GreetingModel(this.text, this.emoji);
}