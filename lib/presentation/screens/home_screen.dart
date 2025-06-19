import 'package:finance_app/application/di.dart';
import 'package:finance_app/presentation/router/route_path.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(monthlySummaryProvider);

    return summaryAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
      data: (summary) {
        return SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Remaining budget card
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '今月の残り予算',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              '¥${summary.remainingBudget.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '収入 ¥${summary.income.toStringAsFixed(0)}',
                                ),
                                Text(
                                  '支出 ¥${summary.totalExpense.toStringAsFixed(0)}',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Pie chart
                    AspectRatio(
                      aspectRatio: 1.2,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: PieChart(
                            PieChartData(
                              sectionsSpace: 2,
                              centerSpaceRadius: 40,
                              startDegreeOffset: -90,
                              sections: summary.byCategory.entries
                                  .toList()
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                    final index = entry.key;
                                    final e = entry.value;
                                    final colors = [
                                      Colors.blue,
                                      Colors.red,
                                      Colors.green,
                                      Colors.orange,
                                      Colors.purple,
                                      Colors.teal,
                                      Colors.brown,
                                      Colors.pink,
                                    ];
                                    return PieChartSectionData(
                                      value: e.value,
                                      title: e.key,
                                      radius: 80,
                                      titlePositionPercentageOffset:
                                          1.4, // Move outside
                                      titleStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      color: colors[index % colors.length],
                                      badgeWidget: Container(), // No badge
                                      badgePositionPercentageOffset: 1.2,
                                      showTitle: true,
                                    );
                                  })
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 80), // space for FAB
                  ],
                ),
              ),
              // Floating add button
              Positioned(
                bottom: 24,
                right: 24,
                child: FloatingActionButton(
                  onPressed: () {
                    context.push(
                      AppRoutes.expenseInput.path,
                    ); // => '/expense_input'
                  },
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
