class AppConstants {
  // API Keys
  static const String geminiApiKey = 'YOUR_GEMINI_API_KEY_HERE';

  // App Info
  static const String appName = 'Money Tracker';
  static const String appVersion = '1.0.0';

  // Database
  static const String databaseName = 'money_app.db';

  // SMS Processing
  static const int defaultSmsLookbackDays = 30;
  static const double minimumConfidenceScore = 0.7;

  // Currency
  static const String currencySymbol = '₹';
  static const String currencyCode = 'INR';

  // Date Formats
  static const String displayDateFormat = 'MMM dd, yyyy';
  static const String detailDateFormat = 'MMMM dd, yyyy \'at\' hh:mm a';
}

class BankingKeywords {
  static const List<String> transactionKeywords = [
    'debited',
    'credited',
    'withdrawn',
    'deposited',
    'payment',
    'transaction',
    'bank',
    'atm',
    'upi',
    'transfer',
    'balance',
    'account',
    'rupees',
    'rs.',
    'inr',
    'amount',
    'spent',
    'received',
  ];

  static const List<String> creditKeywords = [
    'credited',
    'deposited',
    'received',
    'refund',
    'cashback',
    'salary',
    'income',
  ];

  static const List<String> debitKeywords = [
    'debited',
    'withdrawn',
    'spent',
    'payment',
    'purchase',
    'charged',
    'paid',
  ];
}
