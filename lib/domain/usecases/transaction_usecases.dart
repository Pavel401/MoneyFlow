import '../entities/transaction_entity.dart';
import '../repositories/transaction_repository.dart';

class AddTransactionUseCase {
  final TransactionRepository repository;

  AddTransactionUseCase(this.repository);

  Future<String> call(TransactionEntity transaction) async {
    return await repository.addTransaction(transaction);
  }
}

class GetAllTransactionsUseCase {
  final TransactionRepository repository;

  GetAllTransactionsUseCase(this.repository);

  Future<List<TransactionEntity>> call() async {
    final transactions = await repository.getAllTransactions();
    // Sort by date (newest first)
    transactions.sort((a, b) => b.date.compareTo(a.date));
    return transactions;
  }
}

class GetTransactionsByTypeUseCase {
  final TransactionRepository repository;

  GetTransactionsByTypeUseCase(this.repository);

  Future<List<TransactionEntity>> call(TransactionType type) async {
    return await repository.getTransactionsByType(type);
  }
}

class GetTransactionsByCategoryUseCase {
  final TransactionRepository repository;

  GetTransactionsByCategoryUseCase(this.repository);

  Future<List<TransactionEntity>> call(TransactionCategory category) async {
    return await repository.getTransactionsByCategory(category);
  }
}

class GetTransactionsByDateRangeUseCase {
  final TransactionRepository repository;

  GetTransactionsByDateRangeUseCase(this.repository);

  Future<List<TransactionEntity>> call(DateTime start, DateTime end) async {
    return await repository.getTransactionsByDateRange(start, end);
  }
}

class UpdateTransactionUseCase {
  final TransactionRepository repository;

  UpdateTransactionUseCase(this.repository);

  Future<bool> call(TransactionEntity transaction) async {
    return await repository.updateTransaction(transaction);
  }
}

class DeleteTransactionUseCase {
  final TransactionRepository repository;

  DeleteTransactionUseCase(this.repository);

  Future<bool> call(String id) async {
    return await repository.deleteTransaction(id);
  }
}

class GetCategoryWiseExpensesUseCase {
  final TransactionRepository repository;

  GetCategoryWiseExpensesUseCase(this.repository);

  Future<Map<TransactionCategory, double>> call() async {
    return await repository.getCategoryWiseExpenses();
  }
}

class GetTotalAmountByTypeUseCase {
  final TransactionRepository repository;

  GetTotalAmountByTypeUseCase(this.repository);

  Future<double> call(TransactionType type) async {
    return await repository.getTotalAmountByType(type);
  }
}
