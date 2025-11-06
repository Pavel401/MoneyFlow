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
  TextColumn get accountId =>
      text().nullable()(); // Foreign key to BankAccounts

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

  // Bank account info
  TextColumn get name => text()(); // User-defined name for the account
  TextColumn get accountNumber => text()(); // Account number
  TextColumn get bankName => text()(); // Bank name
  RealColumn get balance => real()(); // Current balance
  BoolColumn get isDefault =>
      boolean().withDefault(const Constant(false))(); // Default account flag

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Transactions, BankAccounts])
@DriftDatabase(tables: [Transactions, BankAccounts])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 4;

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
        if (from < 4) {
          // Ensure all columns are present - this is a safety migration
          try {
            await m.addColumn(transactions, transactions.accountId);
          } catch (e) {
            // Column might already exist, ignore the error
          }
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
      ..where(transactions.category.isNotValue('transfer'))
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

  // Bank Account operations
  Future<List<BankAccount>> getAllBankAccounts() => select(bankAccounts).get();

  Future<BankAccount?> getBankAccountById(String id) =>
      (select(bankAccounts)..where((b) => b.id.equals(id))).getSingleOrNull();

  Future<BankAccount?> getDefaultBankAccount() => (select(
    bankAccounts,
  )..where((b) => b.isDefault.equals(true))).getSingleOrNull();

  Future<int> insertBankAccount(BankAccountsCompanion account) =>
      into(bankAccounts).insert(account);

  Future<bool> updateBankAccount(BankAccountsCompanion account) =>
      update(bankAccounts).replace(account);

  Future<int> deleteBankAccount(String id) =>
      (delete(bankAccounts)..where((b) => b.id.equals(id))).go();

  Future<bool> setDefaultBankAccount(String id) async {
    await transaction(() async {
      // Remove default flag from all accounts
      await update(
        bankAccounts,
      ).write(const BankAccountsCompanion(isDefault: Value(false)));
      // Set the selected account as default
      await (update(bankAccounts)..where((b) => b.id.equals(id))).write(
        const BankAccountsCompanion(isDefault: Value(true)),
      );
    });
    return true;
  }

  // Debug helper method to reset database
  Future<void> resetDatabase() async {
    await close();
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'money_app.db'));
    if (await file.exists()) {
      await file.delete();
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'money_app.db'));
    return NativeDatabase(file);
  });
}
