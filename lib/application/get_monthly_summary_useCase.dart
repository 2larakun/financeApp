import 'package:finance_app/domain/expense_repository.dart';
import 'package:finance_app/domain/monthly_summary.dart';

class GetMonthlySummaryUseCase {
  final ExpenseRepository _repository;
  GetMonthlySummaryUseCase(this._repository);

  Future<MonthlySummary> execute(DateTime forMonth) async {
    final expenses = await _repository.fetchMonthlyExpenses(forMonth);
    final income = await _repository.fetchMonthlyIncome(forMonth);
    final totalExpense = expenses.fold<double>(0, (sum, e) => sum + e.amount);

    final byCat = <String, double>{};
    for (final e in expenses) {
      byCat.update(e.category, (v) => v + e.amount, ifAbsent: () => e.amount);
    }

    return MonthlySummary(
      income: income,
      totalExpense: totalExpense,
      remainingBudget: income - totalExpense,
      byCategory: byCat,
    );
  }
}
