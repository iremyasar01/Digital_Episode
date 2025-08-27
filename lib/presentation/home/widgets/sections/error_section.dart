import 'package:digital_episode/presentation/home/cubit/home_cubit.dart';
import 'package:digital_episode/presentation/home/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ErrorSection extends StatelessWidget {
  final HomeError errorState;

  const ErrorSection({super.key, required this.errorState});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red[200]!, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red[100],
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.error_outline, color: Colors.red[700], size: 48),
          ),
          const SizedBox(height: 16),
          Text(
            "Something went wrong",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.red[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            errorState.message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.red[600],
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => context.read<HomeCubit>().refreshHomeData(),
              icon: const Icon(Icons.refresh, color: Colors.white),
              label: const Text(
                "Try Again",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[700],
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}