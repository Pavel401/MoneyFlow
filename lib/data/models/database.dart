import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

/// Transactions table to store all transaction data including SMS parser info
class Transactions extends Table {
  // Primary key
  TextColumn get id => text()();

  // Basic transaction info
  DateTimeColumn get date => dateTime()();
  TextColumn get type => text()(); // 'credit' or 'debit'
  TextColumn get title => text()();
  TextColumn get description => text()();
  RealColumn get amount => real()();
  TextColumn get category => text()();

  // Optional fields
  TextColumn get location => text().nullable()();
  TextColumn get photos => text().nullable()(); // JSON array as string
  TextColumn get smsContent => text().nullable()();
  TextColumn get accountId => text().nullable()(); // Foreign key to BankAccounts

  // SMS Parser - Account Info
  TextColumn get accountType =>
      text().nullable()(); // 'card', 'wallet', 'account', 'upi'
  TextColumn get accountNumber => text().nullable()(); // Last 4 digits
  TextColumn get accountName => text().nullable()();
  TextColumn get walletType => text().nullable()();
  TextColumn get cardType => text().nullable()(); // 'credit' or 'debit'
  TextColumn get cardScheme =>
      text().nullable()(); // 'visa', 'mastercard', etc.
  TextColumn get bankName => text().nullable()();

  // SMS Parser - Balance Info
  TextColumn get balanceAvailable => text().nullable()();
  TextColumn get balanceOutstanding => text().nullable()();

  // SMS Parser - Transaction Info
  TextColumn get referenceNo => text().nullable()();
  TextColumn get merchant => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Bank Accounts table to store user's bank account information
class BankAccounts extends Table {
  // Primary key
  TextColumn get id => text()();

  // Account details
  TextColumn get accountName => text()();
  TextColumn get accountNumber => text()();
  TextColumn get bankName => text()();
  TextColumn get accountType => text()(); // 'savings', 'current', 'creditCard', 'wallet'
  RealColumn get balance => real()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  // Timestamps
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  // Optional fields
  TextColumn get ifscCode => text().nullable()();
  TextColumn get branchName => text().nullable()();
  TextColumn get description => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Transactions, BankAccounts])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          // Add the new SMS parser columns
          await m.addColumn(transactions, transactions.accountType);
          await m.addColumn(transactions, transactions.accountNumber);
          await m.addColumn(transactions, transactions.accountName);
          await m.addColumn(transactions, transactions.walletType);
          await m.addColumn(transactions, transactions.cardType);
          await m.addColumn(transactions, transactions.cardScheme);
          await m.addColumn(transactions, transactions.bankName);
          await m.addColumn(transactions, transactions.balanceAvailable);
          await m.addColumn(transactions, transactions.balanceOutstanding);
          await m.addColumn(transactions, transactions.referenceNo);
          await m.addColumn(transactions, transactions.merchant);
        }
        if (from < 3) {
          // Add BankAccounts table and accountId column to transactions
          await m.createTable(bankAccounts);
          await m.addColumn(transactions, transactions.accountId);
        }
      },
    );
  }

  // Transaction operations
  Future<List<Transaction>> getAllTransactions() => select(transactions).get();

  Future<Transaction?> getTransactionById(String id) =>
      (select(transactions)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<List<Transaction>> getTransactionsByType(String type) =>
      (select(transactions)..where((t) => t.type.equals(type))).get();

  Future<List<Transaction>> getTransactionsByCategory(String category) =>
      (select(transactions)..where((t) => t.category.equals(category))).get();

  Future<List<Transaction>> getTransactionsByDateRange(
    DateTime start,
    DateTime end,
  ) =>
      (select(transactions)
            ..where((t) => t.date.isBiggerOrEqualValue(start))
            ..where((t) => t.date.isSmallerOrEqualValue(end))
            ..orderBy([(t) => OrderingTerm.desc(t.date)]))
          .get();

  Future<int> insertTransaction(TransactionsCompanion transaction) =>
      into(transactions).insert(transaction);

  Future<bool> updateTransaction(TransactionsCompanion transaction) =>
      update(transactions).replace(transaction);

  Future<int> deleteTransaction(String id) =>
      (delete(transactions)..where((t) => t.id.equals(id))).go();

  Future<int> deleteAllTransactions() => delete(transactions).go();

  // Statistics
  Future<double> getTotalAmountByType(String type) async {
    final query = selectOnly(transactions)
      ..addColumns([transactions.amount.sum()])
      ..where(transactions.type.equals(type));

    final result = await query.getSingleOrNull();
    return result?.read(transactions.amount.sum()) ?? 0.0;
  }

  Future<Map<String, double>> getCategoryWiseExpenses() async {
    final query = selectOnly(transactions)
      ..addColumns([transactions.category, transactions.amount.sum()])
      ..where(transactions.type.equals('debit'))
      ..groupBy([transactions.category]);

    final results = await query.get();
    final Map<String, double> expenses = {};

    for (final row in results) {
      final category = row.read(transactions.category);
      final total = row.read(transactions.amount.sum()) ?? 0.0;
      if (category != null) {
        expenses[category] = total;
      }
    }

    return expenses;
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'money_app.db'));
    return NativeDatabase(file);
  });
}
