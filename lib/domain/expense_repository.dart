import 'package:finance_app/domain/expense.dart';

abstract class ExpenseRepository {
  Future<List<Expense>> fetchMonthlyExpenses(DateTime forMonth);
  Future<double> fetchMonthlyIncome(DateTime forMonth);
  Future<void> addExpense(Expense expense);
}
