import 'package:digital_episode/presentation/home/cubit/home_cubit.dart';
import 'package:digital_episode/presentation/home/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController searchController;
  final VoidCallback? onNotificationTap;

  const MyAppBar({
    super.key,
    required this.searchController,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final isSearching = state is HomeLoaded ? state.isSearching : false;
        
        return AppBar(
          backgroundColor: const Color.fromARGB(255, 220, 179, 228),
          elevation: 0,
          flexibleSpace: Container(
            decoration:const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                   Color.fromARGB(255, 220, 179, 228),
                   Color.fromARGB(255, 200, 150, 210),
                ],
              ),
            ),
          ),
          title: isSearching ? _buildSearchField(context) : _buildTitle(),
          centerTitle: true,
          leading: isSearching ? null : _buildMenuButton(context),
          actions: _buildActions(context, isSearching),
        );
      },
    );
  }

  Widget _buildTitle() {
    return const Text(
      "Digital Episode App",
      style: TextStyle(
        color: Color.fromARGB(255, 65, 9, 73),
        fontSize: 22,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextFormField(
        controller: searchController,
        onChanged: (value) => context.read<HomeCubit>().updateSearchQuery(value),
        decoration: InputDecoration(
          hintText: 'Search movies, series...',
          hintStyle: TextStyle(
            color: Colors.grey[600],
            fontSize: 16,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey[600],
            size: 20,
          ),
          suffixIcon: searchController.text.isNotEmpty 
            ? IconButton(
                icon: Icon(Icons.clear, color: Colors.grey[600], size: 20),
                onPressed: () {
                  searchController.clear();
                  context.read<HomeCubit>().updateSearchQuery('');
                },
              )
            : null,
        ),
        style: const TextStyle(
          color: Color.fromARGB(255, 65, 9, 73),
          fontSize: 16,
        ),
        autofocus: true,
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.menu,
        color: Color.fromARGB(255, 65, 9, 73),
        size: 28,
      ),
      onPressed: () => Scaffold.of(context).openDrawer(),
    );
  }

  List<Widget> _buildActions(BuildContext context, bool isSearching) {
    return [
      // Search/Close Button
      IconButton(
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Icon(
            isSearching ? Icons.close : Icons.search_rounded,
            key: ValueKey(isSearching),
            color: const Color.fromARGB(255, 65, 9, 73),
            size: 26,
          ),
        ),
        onPressed: () => _handleSearchToggle(context, isSearching),
      ),
      
      const SizedBox(width: 8),
      
      // Notification Button
      Stack(
        children: [
          IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
              color: Color.fromARGB(255, 65, 9, 73),
              size: 26,
            ),
            onPressed: onNotificationTap ?? () => _showNotificationSnackBar(context),
          ),
          // Badge for notifications (örnek)
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6),
              ),
              constraints: const BoxConstraints(
                minWidth: 12,
                minHeight: 12,
              ),
              child: const Text(
                '3',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
      
      const SizedBox(width: 12),
    ];
  }

  void _handleSearchToggle(BuildContext context, bool isSearching) {
    if (isSearching) {
      searchController.clear();
      context.read<HomeCubit>().clearSearch();
    } else {
      context.read<HomeCubit>().toggleSearch();
    }
  }

  void _showNotificationSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.notifications, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text("You have 3 new notifications"),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 65, 9, 73),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}