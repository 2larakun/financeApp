import 'dart:math';
import 'package:finance_app/application/di.dart';
import 'package:finance_app/domain/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseInputScreen extends ConsumerStatefulWidget {
  const ExpenseInputScreen({super.key});

  @override
  ConsumerState<ExpenseInputScreen> createState() => _ExpenseInputScreenState();
}

class _ExpenseInputScreenState extends ConsumerState<ExpenseInputScreen> {
  final _amountCtl = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = '食費';
  final _memoCtl = TextEditingController();

  static const _categories = ['食費', '交通費', '娯楽', '日用品', '交際費', 'その他'];

  @override
  void dispose() {
    _amountCtl.dispose();
    _memoCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('支出を記録')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 金額入力
          TextField(
            controller: _amountCtl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              prefixText: '¥ ',
              labelText: '金額',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),

          // カテゴリ選択
          const Text('カテゴリ'),
          Wrap(
            spacing: 8,
            children: _categories.map((c) {
              final selected = c == _selectedCategory;
              return ChoiceChip(
                label: Text(c),
                selected: selected,
                onSelected: (_) => setState(() => _selectedCategory = c),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),

          // 日付選択
          ListTile(
            title: const Text('日付'),
            subtitle: Text(
              '${_selectedDate.year}/${_selectedDate.month}/${_selectedDate.day}',
            ),
            trailing: const Icon(Icons.calendar_today),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime(DateTime.now().year - 1),
                lastDate: DateTime(DateTime.now().year + 1),
              );
              if (picked != null) setState(() => _selectedDate = picked);
            },
          ),

          // メモ
          TextField(
            controller: _memoCtl,
            decoration: const InputDecoration(
              labelText: 'メモ',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),

          // 保存ボタン
          FilledButton(onPressed: _save, child: const Text('保存')),
        ],
      ),
    );
  }

  Future<void> _save() async {
    final amt = double.tryParse(_amountCtl.text.replaceAll(',', '').trim());
    if (amt == null || amt <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('金額を正しく入力してください')));
      return;
    }

    final expense = Expense(
      id: Random().nextInt(1 << 32).toString(),
      category: _selectedCategory,
      amount: amt,
      date: _selectedDate,
    );

    await ref.read(addExpenseUseCaseProvider).execute(expense);
    ref.invalidate(monthlySummaryProvider); // ホーム・レポート即時更新
    if (mounted) Navigator.pop(context);
  }
}
