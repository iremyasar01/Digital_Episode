import 'package:digital_episode/presentation/home/widgets/sections/error_section.dart';
import 'package:digital_episode/presentation/home/widgets/sections/loaded_section.dart';
import 'package:digital_episode/presentation/home/widgets/sections/loading_section.dart';
import 'package:flutter/material.dart';
import '../cubit/home_state.dart';


class HomeContent extends StatelessWidget {
  final HomeState state;

  const HomeContent({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state is HomeLoading) {
      return const LoadingSection();
    } else if (state is HomeError) {
      return ErrorSection(errorState: state as HomeError);
    } else if (state is HomeLoaded) {
      return LoadedSection(loadedState: state as HomeLoaded);
    } else {
      return const SizedBox.shrink();
    }
  }
}