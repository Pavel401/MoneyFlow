import 'package:equatable/equatable.dart';

enum BankAccountType {
  savings,
  current,
  creditCard,
  wallet,
}

class BankAccountEntity extends Equatable {
  final String id;
  final String accountName;
  final String accountNumber;
  final String bankName;
  final BankAccountType accountType;
  final double balance;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? ifscCode;
  final String? branchName;
  final String? description;

  const BankAccountEntity({
    required this.id,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
    required this.accountType,
    required this.balance,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
    this.ifscCode,
    this.branchName,
    this.description,
  });

  @override
  List<Object?> get props => [
        id,
        accountName,
        accountNumber,
        bankName,
        accountType,
        balance,
        isActive,
        createdAt,
        updatedAt,
        ifscCode,
        branchName,
        description,
      ];

  BankAccountEntity copyWith({
    String? id,
    String? accountName,
    String? accountNumber,
    String? bankName,
    BankAccountType? accountType,
    double? balance,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? ifscCode,
    String? branchName,
    String? description,
  }) {
    return BankAccountEntity(
      id: id ?? this.id,
      accountName: accountName ?? this.accountName,
      accountNumber: accountNumber ?? this.accountNumber,
      bankName: bankName ?? this.bankName,
      accountType: accountType ?? this.accountType,
      balance: balance ?? this.balance,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      ifscCode: ifscCode ?? this.ifscCode,
      branchName: branchName ?? this.branchName,
      description: description ?? this.description,
    );
  }

  /// Get display name for the account (combines name and masked number)
  String get displayName => '$accountName (*${accountNumber.length > 4 ? accountNumber.substring(accountNumber.length - 4) : accountNumber})';

  /// Get masked account number for security
  String get maskedAccountNumber {
    if (accountNumber.length <= 4) return accountNumber;
    return '${'*' * (accountNumber.length - 4)}${accountNumber.substring(accountNumber.length - 4)}';
  }

  /// Get account type display name
  String get accountTypeDisplayName {
    switch (accountType) {
      case BankAccountType.savings:
        return 'Savings Account';
      case BankAccountType.current:
        return 'Current Account';
      case BankAccountType.creditCard:
        return 'Credit Card';
      case BankAccountType.wallet:
        return 'Digital Wallet';
    }
  }
}