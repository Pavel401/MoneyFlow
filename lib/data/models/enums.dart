/// Enum representing the type of account
enum AccountType {
  /// Credit or debit card
  card,

  /// Digital wallet (e.g., Paytm, Amazon Pay)
  wallet,

  /// Bank account
  account,

  /// UPI ID
  upi,
}

/// Enum representing wallet provider types
enum WalletType {
  /// PayTM wallet
  paytm,

  /// Freecharge wallet
  freecharge,

  /// Amazon Pay wallet
  amazonPay,

  /// Airtel Money wallet
  airtelMoney,

  /// Oxigen wallet
  oxigen,

  /// Ola Money wallet
  olaMoney,

  /// Jio Money wallet
  jioMoney,

  /// ItzCash wallet
  itzCash,

  /// HDFC PayZapp wallet
  payZapp,

  /// Yes Bank wallet
  yesBank,

  /// MobiKwik wallet
  mobikwik,

  /// PhonePe wallet
  phonePe,

  /// Simpl wallet
  simpl,

  /// LazyPay wallet
  lazyPay,
}

/// Enum representing card types
enum CardType {
  /// Credit card
  credit,

  /// Debit card
  debit,
}

/// Enum representing card scheme/network
enum CardScheme {
  /// Visa card
  visa,

  /// Mastercard
  mastercard,

  /// Maestro card
  maestro,

  /// RuPay card
  rupay,

  /// American Express
  amex,

  /// Diners Club
  diners,

  /// SBI Maestro
  sbiMaestro,
}

/// Enum representing balance keyword types
enum BalanceKeywordType {
  /// Available balance
  available,

  /// Outstanding balance
  outstanding,
}

/// Enum representing transaction type
enum TransactionType {
  /// Money debited from account
  debit,

  /// Money credited to account
  credit,
}
