class MonthlySummary {
  final double income;
  final double totalExpense;
  final double remainingBudget;
  final Map<String, double> byCategory; // "食費": 21000, etc.

  const MonthlySummary({
    required this.income,
    required this.totalExpense,
    required this.remainingBudget,
    required this.byCategory,
  });
}
