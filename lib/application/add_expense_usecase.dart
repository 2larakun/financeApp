// lib/application/usecases/add_expense_usecase.dart
import 'package:finance_app/domain/expense.dart';
import 'package:finance_app/domain/expense_repository.dart';

class AddExpenseUseCase {
  final ExpenseRepository _repo;
  AddExpenseUseCase(this._repo);

  Future<void> execute(Expense e) => _repo.addExpense(e);
}
