import 'account_info.dart';
import 'balance.dart';
import 'transaction.dart';

/// Model class representing complete transaction information
class TransactionInfo {
  /// Account information
  final AccountInfo account;

  /// Balance information
  final Balance? balance;

  /// Transaction details
  final Transaction transaction;

  /// Creates a TransactionInfo instance
  const TransactionInfo({
    required this.account,
    this.balance,
    required this.transaction,
  });

  /// Creates a TransactionInfo from JSON
  factory TransactionInfo.fromJson(Map<String, dynamic> json) {
    return TransactionInfo(
      account: AccountInfo.fromJson(json['account']),
      balance: json['balance'] != null
          ? Balance.fromJson(json['balance'])
          : null,
      transaction: Transaction.fromJson(json['transaction']),
    );
  }

  /// Converts TransactionInfo to JSON
  Map<String, dynamic> toJson() {
    return {
      'account': account.toJson(),
      'balance': balance?.toJson(),
      'transaction': transaction.toJson(),
    };
  }

  @override
  String toString() {
    return 'TransactionInfo(account: $account, balance: $balance, transaction: $transaction)';
  }
}
