import 'package:flutter/material.dart';

import '../../../../Utils/colors.dart';


class EmptyJobState extends StatelessWidget {
  final String query;
  final VoidCallback onClear;

  const EmptyJobState({super.key, required this.query, required this.onClear});

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustration
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: AppColors.buttonPrimary.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.search_off_rounded,
                size: 52,
                color: AppColors.buttonPrimary.withOpacity(0.5),
              ),
            ),

            SizedBox(height: sh * 0.028),

            const Text(
              'No Jobs Found',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              query.isNotEmpty
                  ? 'No results for "$query".\nTry a different keyword or adjust your filters.'
                  : 'No jobs match your current filters.\nTry adjusting or clearing them.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.6,
              ),
            ),

            SizedBox(height: sh * 0.032),

            SizedBox(
              height: 46,
              child: ElevatedButton.icon(
                onPressed: onClear,
                icon: const Icon(Icons.refresh_rounded, size: 18, color: Colors.white),
                label: const Text(
                  'Clear Search & Filters',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonPrimary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}