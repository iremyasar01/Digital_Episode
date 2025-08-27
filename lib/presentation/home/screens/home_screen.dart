import 'package:digital_episode/core/network/dio_client.dart';
import 'package:digital_episode/data/repositories/home_repository.dart';
import 'package:digital_episode/presentation/home/cubit/home_cubit.dart';
import 'package:digital_episode/presentation/home/widgets/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        HomeRepository(DioClient()),
      )..loadHomeData(),
      child: const HomeView(),
    );
  }
}