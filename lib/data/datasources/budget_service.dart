import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';
import '../models/database.dart';

/// Service for managing monthly budget preferences using Drift database
class BudgetService {
  final AppDatabase _database;
  static const _uuid = Uuid();

  BudgetService(this._database);

  /// Saves the monthly budget amount (deprecated - use setMonthlyBudgetForMonth)
  Future<void> setMonthlyBudget(double amount) async {
    final now = DateTime.now();
    await setMonthlyBudgetForMonth(now.year, now.month, amount);
  }

  /// Retrieves the monthly budget amount (deprecated - use getMonthlyBudgetForMonth)
  /// Returns 0.0 if no budget is set
  Future<double> getMonthlyBudget() async {
    final now = DateTime.now();
    return await getMonthlyBudgetForMonth(now.year, now.month);
  }

  /// Sets budget for a specific month and year
  Future<void> setMonthlyBudgetForMonth(
    int year,
    int month,
    double amount,
  ) async {
    if (amount <= 0) {
      // Remove budget if amount is 0 or negative
      await clearBudgetForMonth(year, month);
      return;
    }

    final existingBudget = await _database.getBudgetForMonth(year, month);
    final now = DateTime.now();

    if (existingBudget != null) {
      // Update existing budget
      await _database.updateBudget(
        BudgetsCompanion(
          id: Value(existingBudget.id),
          year: Value(year),
          month: Value(month),
          amount: Value(amount),
          createdAt: Value(existingBudget.createdAt),
          updatedAt: Value(now),
        ),
      );
    } else {
      // Create new budget
      await _database.insertBudget(
        BudgetsCompanion(
          id: Value(_uuid.v4()),
          year: Value(year),
          month: Value(month),
          amount: Value(amount),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
    }
  }

  /// Gets budget for a specific month and year
  Future<double> getMonthlyBudgetForMonth(int year, int month) async {
    final budget = await _database.getBudgetForMonth(year, month);
    return budget?.amount ?? 0.0;
  }

  /// Gets all monthly budgets as a list
  Future<List<Map<String, dynamic>>> getAllMonthlyBudgetsList() async {
    final budgets = await _database.getAllBudgets();
    return budgets
        .map(
          (budget) => {
            'id': budget.id,
            'amount': budget.amount,
            'year': budget.year,
            'month': budget.month,
            'createdAt': budget.createdAt.toIso8601String(),
            'updatedAt': budget.updatedAt.toIso8601String(),
          },
        )
        .toList()
      ..sort((a, b) {
        final aDate = DateTime(a['year'] as int, a['month'] as int);
        final bDate = DateTime(b['year'] as int, b['month'] as int);
        return bDate.compareTo(aDate); // Most recent first
      });
  }

  /// Gets recent budgets (last 6 months)
  Future<List<Map<String, dynamic>>> getRecentMonthlyBudgets() async {
    final allBudgets = await getAllMonthlyBudgetsList();
    final now = DateTime.now();
    final sixMonthsAgo = DateTime(now.year, now.month - 6);

    return allBudgets.where((budget) {
      final budgetDate = DateTime(
        budget['year'] as int,
        budget['month'] as int,
      );
      return budgetDate.isAfter(sixMonthsAgo) ||
          budgetDate.isAtSameMomentAs(sixMonthsAgo);
    }).toList();
  }

  /// Checks if a monthly budget has been set for current month
  Future<bool> hasBudgetSet() async {
    final budget = await getMonthlyBudget();
    return budget > 0.0;
  }

  /// Checks if a monthly budget has been set for specific month
  Future<bool> hasBudgetSetForMonth(int year, int month) async {
    final budget = await getMonthlyBudgetForMonth(year, month);
    return budget > 0.0;
  }

  /// Clears the stored monthly budget for current month
  Future<void> clearBudget() async {
    final now = DateTime.now();
    await clearBudgetForMonth(now.year, now.month);
  }

  /// Clears budget for a specific month
  Future<void> clearBudgetForMonth(int year, int month) async {
    await _database.deleteBudgetForMonth(year, month);
  }

  /// Clears all monthly budgets
  Future<void> clearAllBudgets() async {
    await _database.deleteAllBudgets();
  }

  /// Get month name
  String getMonthName(int month) {
    const monthNames = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return monthNames[month];
  }
}
