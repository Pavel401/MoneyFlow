import '../../domain/entities/transaction_entity.dart';

abstract class TransactionRepository {
  Future<List<TransactionEntity>> getAllTransactions();
  Future<List<TransactionEntity>> getTransactionsByType(TransactionType type);
  Future<List<TransactionEntity>> getTransactionsByCategory(
    TransactionCategory category,
  );
  Future<List<TransactionEntity>> getTransactionsByDateRange(
    DateTime start,
    DateTime end,
  );
  Future<TransactionEntity?> getTransactionById(String id);
  Future<String> addTransaction(TransactionEntity transaction);
  Future<bool> updateTransaction(TransactionEntity transaction);
  Future<bool> deleteTransaction(String id);
  Future<double> getTotalAmountByType(TransactionType type);
  Future<Map<TransactionCategory, double>> getCategoryWiseExpenses();
}
