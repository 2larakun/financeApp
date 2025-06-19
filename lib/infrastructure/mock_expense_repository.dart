import 'package:finance_app/domain/expense.dart';
import 'package:finance_app/domain/expense_repository.dart';

class MockExpenseRepository implements ExpenseRepository {
  static final _mockExpenses = <Expense>[
    // 固定のモックデータ
    Expense(id: '1', category: '食費', amount: 6500, date: DateTime(2025, 6, 3)),
    Expense(id: '2', category: '娯楽', amount: 8200, date: DateTime(2025, 6, 5)),
    Expense(id: '3', category: '交通費', amount: 3000, date: DateTime(2025, 6, 7)),
    Expense(
      id: '4',
      category: '食費',
      amount: 14500,
      date: DateTime(2025, 6, 10),
    ),
    Expense(
      id: '5',
      category: '娯楽',
      amount: 13800,
      date: DateTime(2025, 6, 15),
    ),
    Expense(
      id: '6',
      category: '日用品',
      amount: 2100,
      date: DateTime(2025, 6, 16),
    ),
  ];

  static const _mockIncome = 100000.0; // ¥100,000 月収入

  @override
  Future<List<Expense>> fetchMonthlyExpenses(DateTime forMonth) async {
    // 実際の DB/API はここ。今回は固定リストを返す。
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return _mockExpenses.where((e) => e.date.month == forMonth.month).toList();
  }

  @override
  Future<double> fetchMonthlyIncome(DateTime forMonth) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return _mockIncome;
  }

  @override
  Future<void> addExpense(Expense expense) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    _mockExpenses.add(expense);
  }
}
