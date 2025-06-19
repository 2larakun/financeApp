import 'package:finance_app/application/add_expense_usecase.dart';
import 'package:finance_app/application/get_monthly_summary_useCase.dart';
import 'package:finance_app/domain/expense_repository.dart';
import 'package:finance_app/domain/monthly_summary.dart';
import 'package:finance_app/infrastructure/mock_expense_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final expenseRepositoryProvider = Provider<ExpenseRepository>((ref) {
  return MockExpenseRepository();
});

final getSummaryUseCaseProvider = Provider<GetMonthlySummaryUseCase>((ref) {
  final repo = ref.watch(expenseRepositoryProvider);
  return GetMonthlySummaryUseCase(repo);
});

final monthlySummaryProvider = FutureProvider<MonthlySummary>((ref) async {
  final useCase = ref.watch(getSummaryUseCaseProvider);
  final now = DateTime.now();
  return useCase.execute(DateTime(now.year, now.month));
});

// lib/presentation/di.dart などに DI 登録
final addExpenseUseCaseProvider = Provider<AddExpenseUseCase>(
  (ref) => AddExpenseUseCase(ref.watch(expenseRepositoryProvider)),
);
