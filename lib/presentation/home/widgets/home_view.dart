import 'package:digital_episode/presentation/common/widgets/drawer.dart';
import 'package:digital_episode/presentation/common/widgets/my_appbar.dart';
import 'package:digital_episode/presentation/home/widgets/home_content.dart';
import 'package:digital_episode/presentation/home/widgets/notifications_bottom_sheet.dart';
import 'package:digital_episode/presentation/home/widgets/welcome_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  late final TextEditingController _searchController;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _setupUI();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _initializeControllers() {
    _searchController = TextEditingController();
    _scrollController = ScrollController();
  }

  void _setupUI() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<HomeCubit>().refreshHomeData();
    }
  }

  void _handleNotificationTap() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const NotificationsBottomSheet(),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red[700],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'Retry',
          textColor: Colors.white,
          onPressed: () => context.read<HomeCubit>().refreshHomeData(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      drawer: const MyDrawer(),
      appBar: MyAppBar(
        searchController: _searchController,
        onNotificationTap: _handleNotificationTap,
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeError) {
            _showErrorSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async => context.read<HomeCubit>().refreshHomeData(),
            color: const Color.fromARGB(255, 65, 9, 73),
            child: CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 24),
                    child: WelcomeHeader(),
                  ),
                ),
                SliverToBoxAdapter(child: HomeContent(state: state)),
                const SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            ),
          );
        },
      ),
    );
  }
}