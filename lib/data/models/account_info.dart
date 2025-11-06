import 'enums.dart';

/// Model class representing account information
class AccountInfo {
  /// Type of account (card, wallet, or account)
  final AccountType? type;

  /// Last 4 digits of account/card number
  final String? number;

  /// Name of the account/wallet (e.g., "paytm", "amazon_pay")
  final String? name;

  /// Wallet provider type (only applicable when type is wallet)
  final WalletType? walletType;

  /// Card type (credit or debit, only applicable when type is card)
  final CardType? cardType;

  /// Card scheme/network (Visa, Mastercard, etc., only applicable when type is card)
  final CardScheme? cardScheme;

  /// Bank name or code (only applicable when type is card or account)
  final String? bankName;

  /// Creates an AccountInfo instance
  const AccountInfo({
    this.type,
    this.number,
    this.name,
    this.walletType,
    this.cardType,
    this.cardScheme,
    this.bankName,
  });

  /// Creates an AccountInfo from JSON
  factory AccountInfo.fromJson(Map<String, dynamic> json) {
    return AccountInfo(
      type: json['type'] != null
          ? AccountType.values.firstWhere(
              (e) => e.name == json['type'],
              orElse: () => AccountType.account,
            )
          : null,
      number: json['number'],
      name: json['name'],
      walletType: json['walletType'] != null
          ? WalletType.values.firstWhere(
              (e) => e.name == json['walletType'],
              orElse: () => WalletType.paytm,
            )
          : null,
      cardType: json['cardType'] != null
          ? CardType.values.firstWhere(
              (e) => e.name == json['cardType'],
              orElse: () => CardType.credit,
            )
          : null,
      cardScheme: json['cardScheme'] != null
          ? CardScheme.values.firstWhere(
              (e) => e.name == json['cardScheme'],
              orElse: () => CardScheme.visa,
            )
          : null,
      bankName: json['bankName'],
    );
  }

  /// Converts AccountInfo to JSON
  Map<String, dynamic> toJson() {
    return {
      'type': type?.name,
      'number': number,
      'name': name,
      'walletType': walletType?.name,
      'cardType': cardType?.name,
      'cardScheme': cardScheme?.name,
      'bankName': bankName,
    };
  }

  @override
  String toString() {
    return 'AccountInfo(type: $type, number: $number, name: $name, walletType: $walletType, cardType: $cardType, cardScheme: $cardScheme, bankName: $bankName)';
  }
}
