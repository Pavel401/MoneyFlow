import 'enums.dart';

/// Model class representing a transaction
class Transaction {
  /// Type of transaction (debit or credit)
  final TransactionType? type;

  /// Transaction amount
  final String? amount;

  /// Transaction reference number
  final String? referenceNo;

  /// Merchant name or UPI ID
  final String? merchant;

  /// Creates a Transaction instance
  const Transaction({this.type, this.amount, this.referenceNo, this.merchant});

  /// Creates a Transaction from JSON
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      type: json['type'] != null
          ? TransactionType.values.firstWhere(
              (e) => e.name == json['type'],
              orElse: () => TransactionType.debit,
            )
          : null,
      amount: json['amount'],
      referenceNo: json['referenceNo'],
      merchant: json['merchant'],
    );
  }

  /// Converts Transaction to JSON
  Map<String, dynamic> toJson() {
    return {
      'type': type?.name,
      'amount': amount,
      'referenceNo': referenceNo,
      'merchant': merchant,
    };
  }

  @override
  String toString() {
    return 'Transaction(type: $type, amount: $amount, referenceNo: $referenceNo, merchant: $merchant)';
  }
}
