import 'package:finance_app/application/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportScreen extends ConsumerWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(monthlySummaryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('レポート')),
      body: summaryAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
        data: (summary) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Toggle tabs (月/週) — only visual for now
              ToggleButtons(
                isSelected: const [true, false],
                onPressed: (_) {},
                children: const [
                  Padding(padding: EdgeInsets.all(8), child: Text('月')),
                  Padding(padding: EdgeInsets.all(8), child: Text('週')),
                ],
              ),
              const SizedBox(height: 24),
              ...summary.byCategory.entries.map((e) {
                final ratio = e.value / (summary.income * 0.3); // 30% 仮予算
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            e.key,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('¥${e.value.toStringAsFixed(0)}'),
                        ],
                      ),
                      const SizedBox(height: 4),
                      LinearProgressIndicator(value: ratio.clamp(0, 1)),
                    ],
                  ),
                );
              }).toList(),
              const SizedBox(height: 32),
              const Text(
                '先月比: +¥8,000',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          );
        },
      ),
    );
  }
}
