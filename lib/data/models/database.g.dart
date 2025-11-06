// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, Transaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photosMeta = const VerificationMeta('photos');
  @override
  late final GeneratedColumn<String> photos = GeneratedColumn<String>(
    'photos',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _smsContentMeta = const VerificationMeta(
    'smsContent',
  );
  @override
  late final GeneratedColumn<String> smsContent = GeneratedColumn<String>(
    'sms_content',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accountTypeMeta = const VerificationMeta(
    'accountType',
  );
  @override
  late final GeneratedColumn<String> accountType = GeneratedColumn<String>(
    'account_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accountNumberMeta = const VerificationMeta(
    'accountNumber',
  );
  @override
  late final GeneratedColumn<String> accountNumber = GeneratedColumn<String>(
    'account_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accountNameMeta = const VerificationMeta(
    'accountName',
  );
  @override
  late final GeneratedColumn<String> accountName = GeneratedColumn<String>(
    'account_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _walletTypeMeta = const VerificationMeta(
    'walletType',
  );
  @override
  late final GeneratedColumn<String> walletType = GeneratedColumn<String>(
    'wallet_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cardTypeMeta = const VerificationMeta(
    'cardType',
  );
  @override
  late final GeneratedColumn<String> cardType = GeneratedColumn<String>(
    'card_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cardSchemeMeta = const VerificationMeta(
    'cardScheme',
  );
  @override
  late final GeneratedColumn<String> cardScheme = GeneratedColumn<String>(
    'card_scheme',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bankNameMeta = const VerificationMeta(
    'bankName',
  );
  @override
  late final GeneratedColumn<String> bankName = GeneratedColumn<String>(
    'bank_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _balanceAvailableMeta = const VerificationMeta(
    'balanceAvailable',
  );
  @override
  late final GeneratedColumn<String> balanceAvailable = GeneratedColumn<String>(
    'balance_available',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _balanceOutstandingMeta =
      const VerificationMeta('balanceOutstanding');
  @override
  late final GeneratedColumn<String> balanceOutstanding =
      GeneratedColumn<String>(
        'balance_outstanding',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _referenceNoMeta = const VerificationMeta(
    'referenceNo',
  );
  @override
  late final GeneratedColumn<String> referenceNo = GeneratedColumn<String>(
    'reference_no',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _merchantMeta = const VerificationMeta(
    'merchant',
  );
  @override
  late final GeneratedColumn<String> merchant = GeneratedColumn<String>(
    'merchant',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    type,
    title,
    description,
    amount,
    category,
    location,
    photos,
    smsContent,
    accountId,
    accountType,
    accountNumber,
    accountName,
    walletType,
    cardType,
    cardScheme,
    bankName,
    balanceAvailable,
    balanceOutstanding,
    referenceNo,
    merchant,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Transaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('photos')) {
      context.handle(
        _photosMeta,
        photos.isAcceptableOrUnknown(data['photos']!, _photosMeta),
      );
    }
    if (data.containsKey('sms_content')) {
      context.handle(
        _smsContentMeta,
        smsContent.isAcceptableOrUnknown(data['sms_content']!, _smsContentMeta),
      );
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    }
    if (data.containsKey('account_type')) {
      context.handle(
        _accountTypeMeta,
        accountType.isAcceptableOrUnknown(
          data['account_type']!,
          _accountTypeMeta,
        ),
      );
    }
    if (data.containsKey('account_number')) {
      context.handle(
        _accountNumberMeta,
        accountNumber.isAcceptableOrUnknown(
          data['account_number']!,
          _accountNumberMeta,
        ),
      );
    }
    if (data.containsKey('account_name')) {
      context.handle(
        _accountNameMeta,
        accountName.isAcceptableOrUnknown(
          data['account_name']!,
          _accountNameMeta,
        ),
      );
    }
    if (data.containsKey('wallet_type')) {
      context.handle(
        _walletTypeMeta,
        walletType.isAcceptableOrUnknown(data['wallet_type']!, _walletTypeMeta),
      );
    }
    if (data.containsKey('card_type')) {
      context.handle(
        _cardTypeMeta,
        cardType.isAcceptableOrUnknown(data['card_type']!, _cardTypeMeta),
      );
    }
    if (data.containsKey('card_scheme')) {
      context.handle(
        _cardSchemeMeta,
        cardScheme.isAcceptableOrUnknown(data['card_scheme']!, _cardSchemeMeta),
      );
    }
    if (data.containsKey('bank_name')) {
      context.handle(
        _bankNameMeta,
        bankName.isAcceptableOrUnknown(data['bank_name']!, _bankNameMeta),
      );
    }
    if (data.containsKey('balance_available')) {
      context.handle(
        _balanceAvailableMeta,
        balanceAvailable.isAcceptableOrUnknown(
          data['balance_available']!,
          _balanceAvailableMeta,
        ),
      );
    }
    if (data.containsKey('balance_outstanding')) {
      context.handle(
        _balanceOutstandingMeta,
        balanceOutstanding.isAcceptableOrUnknown(
          data['balance_outstanding']!,
          _balanceOutstandingMeta,
        ),
      );
    }
    if (data.containsKey('reference_no')) {
      context.handle(
        _referenceNoMeta,
        referenceNo.isAcceptableOrUnknown(
          data['reference_no']!,
          _referenceNoMeta,
        ),
      );
    }
    if (data.containsKey('merchant')) {
      context.handle(
        _merchantMeta,
        merchant.isAcceptableOrUnknown(data['merchant']!, _merchantMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Transaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
      photos: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photos'],
      ),
      smsContent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sms_content'],
      ),
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      ),
      accountType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_type'],
      ),
      accountNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_number'],
      ),
      accountName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_name'],
      ),
      walletType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wallet_type'],
      ),
      cardType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}card_type'],
      ),
      cardScheme: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}card_scheme'],
      ),
      bankName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_name'],
      ),
      balanceAvailable: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}balance_available'],
      ),
      balanceOutstanding: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}balance_outstanding'],
      ),
      referenceNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_no'],
      ),
      merchant: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}merchant'],
      ),
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }
}

class Transaction extends DataClass implements Insertable<Transaction> {
  final String id;
  final DateTime date;
  final String type;
  final String title;
  final String description;
  final double amount;
  final String category;
  final String? location;
  final String? photos;
  final String? smsContent;
  final String? accountId;
  final String? accountType;
  final String? accountNumber;
  final String? accountName;
  final String? walletType;
  final String? cardType;
  final String? cardScheme;
  final String? bankName;
  final String? balanceAvailable;
  final String? balanceOutstanding;
  final String? referenceNo;
  final String? merchant;
  const Transaction({
    required this.id,
    required this.date,
    required this.type,
    required this.title,
    required this.description,
    required this.amount,
    required this.category,
    this.location,
    this.photos,
    this.smsContent,
    this.accountId,
    this.accountType,
    this.accountNumber,
    this.accountName,
    this.walletType,
    this.cardType,
    this.cardScheme,
    this.bankName,
    this.balanceAvailable,
    this.balanceOutstanding,
    this.referenceNo,
    this.merchant,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    map['type'] = Variable<String>(type);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['amount'] = Variable<double>(amount);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    if (!nullToAbsent || photos != null) {
      map['photos'] = Variable<String>(photos);
    }
    if (!nullToAbsent || smsContent != null) {
      map['sms_content'] = Variable<String>(smsContent);
    }
    if (!nullToAbsent || accountId != null) {
      map['account_id'] = Variable<String>(accountId);
    }
    if (!nullToAbsent || accountType != null) {
      map['account_type'] = Variable<String>(accountType);
    }
    if (!nullToAbsent || accountNumber != null) {
      map['account_number'] = Variable<String>(accountNumber);
    }
    if (!nullToAbsent || accountName != null) {
      map['account_name'] = Variable<String>(accountName);
    }
    if (!nullToAbsent || walletType != null) {
      map['wallet_type'] = Variable<String>(walletType);
    }
    if (!nullToAbsent || cardType != null) {
      map['card_type'] = Variable<String>(cardType);
    }
    if (!nullToAbsent || cardScheme != null) {
      map['card_scheme'] = Variable<String>(cardScheme);
    }
    if (!nullToAbsent || bankName != null) {
      map['bank_name'] = Variable<String>(bankName);
    }
    if (!nullToAbsent || balanceAvailable != null) {
      map['balance_available'] = Variable<String>(balanceAvailable);
    }
    if (!nullToAbsent || balanceOutstanding != null) {
      map['balance_outstanding'] = Variable<String>(balanceOutstanding);
    }
    if (!nullToAbsent || referenceNo != null) {
      map['reference_no'] = Variable<String>(referenceNo);
    }
    if (!nullToAbsent || merchant != null) {
      map['merchant'] = Variable<String>(merchant);
    }
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      date: Value(date),
      type: Value(type),
      title: Value(title),
      description: Value(description),
      amount: Value(amount),
      category: Value(category),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      photos: photos == null && nullToAbsent
          ? const Value.absent()
          : Value(photos),
      smsContent: smsContent == null && nullToAbsent
          ? const Value.absent()
          : Value(smsContent),
      accountId: accountId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountId),
      accountType: accountType == null && nullToAbsent
          ? const Value.absent()
          : Value(accountType),
      accountNumber: accountNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(accountNumber),
      accountName: accountName == null && nullToAbsent
          ? const Value.absent()
          : Value(accountName),
      walletType: walletType == null && nullToAbsent
          ? const Value.absent()
          : Value(walletType),
      cardType: cardType == null && nullToAbsent
          ? const Value.absent()
          : Value(cardType),
      cardScheme: cardScheme == null && nullToAbsent
          ? const Value.absent()
          : Value(cardScheme),
      bankName: bankName == null && nullToAbsent
          ? const Value.absent()
          : Value(bankName),
      balanceAvailable: balanceAvailable == null && nullToAbsent
          ? const Value.absent()
          : Value(balanceAvailable),
      balanceOutstanding: balanceOutstanding == null && nullToAbsent
          ? const Value.absent()
          : Value(balanceOutstanding),
      referenceNo: referenceNo == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceNo),
      merchant: merchant == null && nullToAbsent
          ? const Value.absent()
          : Value(merchant),
    );
  }

  factory Transaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transaction(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      type: serializer.fromJson<String>(json['type']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      amount: serializer.fromJson<double>(json['amount']),
      category: serializer.fromJson<String>(json['category']),
      location: serializer.fromJson<String?>(json['location']),
      photos: serializer.fromJson<String?>(json['photos']),
      smsContent: serializer.fromJson<String?>(json['smsContent']),
      accountId: serializer.fromJson<String?>(json['accountId']),
      accountType: serializer.fromJson<String?>(json['accountType']),
      accountNumber: serializer.fromJson<String?>(json['accountNumber']),
      accountName: serializer.fromJson<String?>(json['accountName']),
      walletType: serializer.fromJson<String?>(json['walletType']),
      cardType: serializer.fromJson<String?>(json['cardType']),
      cardScheme: serializer.fromJson<String?>(json['cardScheme']),
      bankName: serializer.fromJson<String?>(json['bankName']),
      balanceAvailable: serializer.fromJson<String?>(json['balanceAvailable']),
      balanceOutstanding: serializer.fromJson<String?>(
        json['balanceOutstanding'],
      ),
      referenceNo: serializer.fromJson<String?>(json['referenceNo']),
      merchant: serializer.fromJson<String?>(json['merchant']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'type': serializer.toJson<String>(type),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'amount': serializer.toJson<double>(amount),
      'category': serializer.toJson<String>(category),
      'location': serializer.toJson<String?>(location),
      'photos': serializer.toJson<String?>(photos),
      'smsContent': serializer.toJson<String?>(smsContent),
      'accountId': serializer.toJson<String?>(accountId),
      'accountType': serializer.toJson<String?>(accountType),
      'accountNumber': serializer.toJson<String?>(accountNumber),
      'accountName': serializer.toJson<String?>(accountName),
      'walletType': serializer.toJson<String?>(walletType),
      'cardType': serializer.toJson<String?>(cardType),
      'cardScheme': serializer.toJson<String?>(cardScheme),
      'bankName': serializer.toJson<String?>(bankName),
      'balanceAvailable': serializer.toJson<String?>(balanceAvailable),
      'balanceOutstanding': serializer.toJson<String?>(balanceOutstanding),
      'referenceNo': serializer.toJson<String?>(referenceNo),
      'merchant': serializer.toJson<String?>(merchant),
    };
  }

  Transaction copyWith({
    String? id,
    DateTime? date,
    String? type,
    String? title,
    String? description,
    double? amount,
    String? category,
    Value<String?> location = const Value.absent(),
    Value<String?> photos = const Value.absent(),
    Value<String?> smsContent = const Value.absent(),
    Value<String?> accountId = const Value.absent(),
    Value<String?> accountType = const Value.absent(),
    Value<String?> accountNumber = const Value.absent(),
    Value<String?> accountName = const Value.absent(),
    Value<String?> walletType = const Value.absent(),
    Value<String?> cardType = const Value.absent(),
    Value<String?> cardScheme = const Value.absent(),
    Value<String?> bankName = const Value.absent(),
    Value<String?> balanceAvailable = const Value.absent(),
    Value<String?> balanceOutstanding = const Value.absent(),
    Value<String?> referenceNo = const Value.absent(),
    Value<String?> merchant = const Value.absent(),
  }) => Transaction(
    id: id ?? this.id,
    date: date ?? this.date,
    type: type ?? this.type,
    title: title ?? this.title,
    description: description ?? this.description,
    amount: amount ?? this.amount,
    category: category ?? this.category,
    location: location.present ? location.value : this.location,
    photos: photos.present ? photos.value : this.photos,
    smsContent: smsContent.present ? smsContent.value : this.smsContent,
    accountId: accountId.present ? accountId.value : this.accountId,
    accountType: accountType.present ? accountType.value : this.accountType,
    accountNumber: accountNumber.present
        ? accountNumber.value
        : this.accountNumber,
    accountName: accountName.present ? accountName.value : this.accountName,
    walletType: walletType.present ? walletType.value : this.walletType,
    cardType: cardType.present ? cardType.value : this.cardType,
    cardScheme: cardScheme.present ? cardScheme.value : this.cardScheme,
    bankName: bankName.present ? bankName.value : this.bankName,
    balanceAvailable: balanceAvailable.present
        ? balanceAvailable.value
        : this.balanceAvailable,
    balanceOutstanding: balanceOutstanding.present
        ? balanceOutstanding.value
        : this.balanceOutstanding,
    referenceNo: referenceNo.present ? referenceNo.value : this.referenceNo,
    merchant: merchant.present ? merchant.value : this.merchant,
  );
  Transaction copyWithCompanion(TransactionsCompanion data) {
    return Transaction(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      type: data.type.present ? data.type.value : this.type,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      amount: data.amount.present ? data.amount.value : this.amount,
      category: data.category.present ? data.category.value : this.category,
      location: data.location.present ? data.location.value : this.location,
      photos: data.photos.present ? data.photos.value : this.photos,
      smsContent: data.smsContent.present
          ? data.smsContent.value
          : this.smsContent,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      accountType: data.accountType.present
          ? data.accountType.value
          : this.accountType,
      accountNumber: data.accountNumber.present
          ? data.accountNumber.value
          : this.accountNumber,
      accountName: data.accountName.present
          ? data.accountName.value
          : this.accountName,
      walletType: data.walletType.present
          ? data.walletType.value
          : this.walletType,
      cardType: data.cardType.present ? data.cardType.value : this.cardType,
      cardScheme: data.cardScheme.present
          ? data.cardScheme.value
          : this.cardScheme,
      bankName: data.bankName.present ? data.bankName.value : this.bankName,
      balanceAvailable: data.balanceAvailable.present
          ? data.balanceAvailable.value
          : this.balanceAvailable,
      balanceOutstanding: data.balanceOutstanding.present
          ? data.balanceOutstanding.value
          : this.balanceOutstanding,
      referenceNo: data.referenceNo.present
          ? data.referenceNo.value
          : this.referenceNo,
      merchant: data.merchant.present ? data.merchant.value : this.merchant,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Transaction(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('amount: $amount, ')
          ..write('category: $category, ')
          ..write('location: $location, ')
          ..write('photos: $photos, ')
          ..write('smsContent: $smsContent, ')
          ..write('accountId: $accountId, ')
          ..write('accountType: $accountType, ')
          ..write('accountNumber: $accountNumber, ')
          ..write('accountName: $accountName, ')
          ..write('walletType: $walletType, ')
          ..write('cardType: $cardType, ')
          ..write('cardScheme: $cardScheme, ')
          ..write('bankName: $bankName, ')
          ..write('balanceAvailable: $balanceAvailable, ')
          ..write('balanceOutstanding: $balanceOutstanding, ')
          ..write('referenceNo: $referenceNo, ')
          ..write('merchant: $merchant')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    date,
    type,
    title,
    description,
    amount,
    category,
    location,
    photos,
    smsContent,
    accountId,
    accountType,
    accountNumber,
    accountName,
    walletType,
    cardType,
    cardScheme,
    bankName,
    balanceAvailable,
    balanceOutstanding,
    referenceNo,
    merchant,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaction &&
          other.id == this.id &&
          other.date == this.date &&
          other.type == this.type &&
          other.title == this.title &&
          other.description == this.description &&
          other.amount == this.amount &&
          other.category == this.category &&
          other.location == this.location &&
          other.photos == this.photos &&
          other.smsContent == this.smsContent &&
          other.accountId == this.accountId &&
          other.accountType == this.accountType &&
          other.accountNumber == this.accountNumber &&
          other.accountName == this.accountName &&
          other.walletType == this.walletType &&
          other.cardType == this.cardType &&
          other.cardScheme == this.cardScheme &&
          other.bankName == this.bankName &&
          other.balanceAvailable == this.balanceAvailable &&
          other.balanceOutstanding == this.balanceOutstanding &&
          other.referenceNo == this.referenceNo &&
          other.merchant == this.merchant);
}

class TransactionsCompanion extends UpdateCompanion<Transaction> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<String> type;
  final Value<String> title;
  final Value<String> description;
  final Value<double> amount;
  final Value<String> category;
  final Value<String?> location;
  final Value<String?> photos;
  final Value<String?> smsContent;
  final Value<String?> accountId;
  final Value<String?> accountType;
  final Value<String?> accountNumber;
  final Value<String?> accountName;
  final Value<String?> walletType;
  final Value<String?> cardType;
  final Value<String?> cardScheme;
  final Value<String?> bankName;
  final Value<String?> balanceAvailable;
  final Value<String?> balanceOutstanding;
  final Value<String?> referenceNo;
  final Value<String?> merchant;
  final Value<int> rowid;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.type = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.amount = const Value.absent(),
    this.category = const Value.absent(),
    this.location = const Value.absent(),
    this.photos = const Value.absent(),
    this.smsContent = const Value.absent(),
    this.accountId = const Value.absent(),
    this.accountType = const Value.absent(),
    this.accountNumber = const Value.absent(),
    this.accountName = const Value.absent(),
    this.walletType = const Value.absent(),
    this.cardType = const Value.absent(),
    this.cardScheme = const Value.absent(),
    this.bankName = const Value.absent(),
    this.balanceAvailable = const Value.absent(),
    this.balanceOutstanding = const Value.absent(),
    this.referenceNo = const Value.absent(),
    this.merchant = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransactionsCompanion.insert({
    required String id,
    required DateTime date,
    required String type,
    required String title,
    required String description,
    required double amount,
    required String category,
    this.location = const Value.absent(),
    this.photos = const Value.absent(),
    this.smsContent = const Value.absent(),
    this.accountId = const Value.absent(),
    this.accountType = const Value.absent(),
    this.accountNumber = const Value.absent(),
    this.accountName = const Value.absent(),
    this.walletType = const Value.absent(),
    this.cardType = const Value.absent(),
    this.cardScheme = const Value.absent(),
    this.bankName = const Value.absent(),
    this.balanceAvailable = const Value.absent(),
    this.balanceOutstanding = const Value.absent(),
    this.referenceNo = const Value.absent(),
    this.merchant = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       date = Value(date),
       type = Value(type),
       title = Value(title),
       description = Value(description),
       amount = Value(amount),
       category = Value(category);
  static Insertable<Transaction> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<String>? type,
    Expression<String>? title,
    Expression<String>? description,
    Expression<double>? amount,
    Expression<String>? category,
    Expression<String>? location,
    Expression<String>? photos,
    Expression<String>? smsContent,
    Expression<String>? accountId,
    Expression<String>? accountType,
    Expression<String>? accountNumber,
    Expression<String>? accountName,
    Expression<String>? walletType,
    Expression<String>? cardType,
    Expression<String>? cardScheme,
    Expression<String>? bankName,
    Expression<String>? balanceAvailable,
    Expression<String>? balanceOutstanding,
    Expression<String>? referenceNo,
    Expression<String>? merchant,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (type != null) 'type': type,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (amount != null) 'amount': amount,
      if (category != null) 'category': category,
      if (location != null) 'location': location,
      if (photos != null) 'photos': photos,
      if (smsContent != null) 'sms_content': smsContent,
      if (accountId != null) 'account_id': accountId,
      if (accountType != null) 'account_type': accountType,
      if (accountNumber != null) 'account_number': accountNumber,
      if (accountName != null) 'account_name': accountName,
      if (walletType != null) 'wallet_type': walletType,
      if (cardType != null) 'card_type': cardType,
      if (cardScheme != null) 'card_scheme': cardScheme,
      if (bankName != null) 'bank_name': bankName,
      if (balanceAvailable != null) 'balance_available': balanceAvailable,
      if (balanceOutstanding != null) 'balance_outstanding': balanceOutstanding,
      if (referenceNo != null) 'reference_no': referenceNo,
      if (merchant != null) 'merchant': merchant,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransactionsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? date,
    Value<String>? type,
    Value<String>? title,
    Value<String>? description,
    Value<double>? amount,
    Value<String>? category,
    Value<String?>? location,
    Value<String?>? photos,
    Value<String?>? smsContent,
    Value<String?>? accountId,
    Value<String?>? accountType,
    Value<String?>? accountNumber,
    Value<String?>? accountName,
    Value<String?>? walletType,
    Value<String?>? cardType,
    Value<String?>? cardScheme,
    Value<String?>? bankName,
    Value<String?>? balanceAvailable,
    Value<String?>? balanceOutstanding,
    Value<String?>? referenceNo,
    Value<String?>? merchant,
    Value<int>? rowid,
  }) {
    return TransactionsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      location: location ?? this.location,
      photos: photos ?? this.photos,
      smsContent: smsContent ?? this.smsContent,
      accountId: accountId ?? this.accountId,
      accountType: accountType ?? this.accountType,
      accountNumber: accountNumber ?? this.accountNumber,
      accountName: accountName ?? this.accountName,
      walletType: walletType ?? this.walletType,
      cardType: cardType ?? this.cardType,
      cardScheme: cardScheme ?? this.cardScheme,
      bankName: bankName ?? this.bankName,
      balanceAvailable: balanceAvailable ?? this.balanceAvailable,
      balanceOutstanding: balanceOutstanding ?? this.balanceOutstanding,
      referenceNo: referenceNo ?? this.referenceNo,
      merchant: merchant ?? this.merchant,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (photos.present) {
      map['photos'] = Variable<String>(photos.value);
    }
    if (smsContent.present) {
      map['sms_content'] = Variable<String>(smsContent.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (accountType.present) {
      map['account_type'] = Variable<String>(accountType.value);
    }
    if (accountNumber.present) {
      map['account_number'] = Variable<String>(accountNumber.value);
    }
    if (accountName.present) {
      map['account_name'] = Variable<String>(accountName.value);
    }
    if (walletType.present) {
      map['wallet_type'] = Variable<String>(walletType.value);
    }
    if (cardType.present) {
      map['card_type'] = Variable<String>(cardType.value);
    }
    if (cardScheme.present) {
      map['card_scheme'] = Variable<String>(cardScheme.value);
    }
    if (bankName.present) {
      map['bank_name'] = Variable<String>(bankName.value);
    }
    if (balanceAvailable.present) {
      map['balance_available'] = Variable<String>(balanceAvailable.value);
    }
    if (balanceOutstanding.present) {
      map['balance_outstanding'] = Variable<String>(balanceOutstanding.value);
    }
    if (referenceNo.present) {
      map['reference_no'] = Variable<String>(referenceNo.value);
    }
    if (merchant.present) {
      map['merchant'] = Variable<String>(merchant.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('amount: $amount, ')
          ..write('category: $category, ')
          ..write('location: $location, ')
          ..write('photos: $photos, ')
          ..write('smsContent: $smsContent, ')
          ..write('accountId: $accountId, ')
          ..write('accountType: $accountType, ')
          ..write('accountNumber: $accountNumber, ')
          ..write('accountName: $accountName, ')
          ..write('walletType: $walletType, ')
          ..write('cardType: $cardType, ')
          ..write('cardScheme: $cardScheme, ')
          ..write('bankName: $bankName, ')
          ..write('balanceAvailable: $balanceAvailable, ')
          ..write('balanceOutstanding: $balanceOutstanding, ')
          ..write('referenceNo: $referenceNo, ')
          ..write('merchant: $merchant, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BankAccountsTable extends BankAccounts
    with TableInfo<$BankAccountsTable, BankAccount> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BankAccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountNumberMeta = const VerificationMeta(
    'accountNumber',
  );
  @override
  late final GeneratedColumn<String> accountNumber = GeneratedColumn<String>(
    'account_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bankNameMeta = const VerificationMeta(
    'bankName',
  );
  @override
  late final GeneratedColumn<String> bankName = GeneratedColumn<String>(
    'bank_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _balanceMeta = const VerificationMeta(
    'balance',
  );
  @override
  late final GeneratedColumn<double> balance = GeneratedColumn<double>(
    'balance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    accountNumber,
    bankName,
    balance,
    isDefault,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bank_accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<BankAccount> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('account_number')) {
      context.handle(
        _accountNumberMeta,
        accountNumber.isAcceptableOrUnknown(
          data['account_number']!,
          _accountNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_accountNumberMeta);
    }
    if (data.containsKey('bank_name')) {
      context.handle(
        _bankNameMeta,
        bankName.isAcceptableOrUnknown(data['bank_name']!, _bankNameMeta),
      );
    } else if (isInserting) {
      context.missing(_bankNameMeta);
    }
    if (data.containsKey('balance')) {
      context.handle(
        _balanceMeta,
        balance.isAcceptableOrUnknown(data['balance']!, _balanceMeta),
      );
    } else if (isInserting) {
      context.missing(_balanceMeta);
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BankAccount map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BankAccount(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      accountNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_number'],
      )!,
      bankName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_name'],
      )!,
      balance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}balance'],
      )!,
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default'],
      )!,
    );
  }

  @override
  $BankAccountsTable createAlias(String alias) {
    return $BankAccountsTable(attachedDatabase, alias);
  }
}

class BankAccount extends DataClass implements Insertable<BankAccount> {
  final String id;
  final String name;
  final String accountNumber;
  final String bankName;
  final double balance;
  final bool isDefault;
  const BankAccount({
    required this.id,
    required this.name,
    required this.accountNumber,
    required this.bankName,
    required this.balance,
    required this.isDefault,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['account_number'] = Variable<String>(accountNumber);
    map['bank_name'] = Variable<String>(bankName);
    map['balance'] = Variable<double>(balance);
    map['is_default'] = Variable<bool>(isDefault);
    return map;
  }

  BankAccountsCompanion toCompanion(bool nullToAbsent) {
    return BankAccountsCompanion(
      id: Value(id),
      name: Value(name),
      accountNumber: Value(accountNumber),
      bankName: Value(bankName),
      balance: Value(balance),
      isDefault: Value(isDefault),
    );
  }

  factory BankAccount.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BankAccount(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      accountNumber: serializer.fromJson<String>(json['accountNumber']),
      bankName: serializer.fromJson<String>(json['bankName']),
      balance: serializer.fromJson<double>(json['balance']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'accountNumber': serializer.toJson<String>(accountNumber),
      'bankName': serializer.toJson<String>(bankName),
      'balance': serializer.toJson<double>(balance),
      'isDefault': serializer.toJson<bool>(isDefault),
    };
  }

  BankAccount copyWith({
    String? id,
    String? name,
    String? accountNumber,
    String? bankName,
    double? balance,
    bool? isDefault,
  }) => BankAccount(
    id: id ?? this.id,
    name: name ?? this.name,
    accountNumber: accountNumber ?? this.accountNumber,
    bankName: bankName ?? this.bankName,
    balance: balance ?? this.balance,
    isDefault: isDefault ?? this.isDefault,
  );
  BankAccount copyWithCompanion(BankAccountsCompanion data) {
    return BankAccount(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      accountNumber: data.accountNumber.present
          ? data.accountNumber.value
          : this.accountNumber,
      bankName: data.bankName.present ? data.bankName.value : this.bankName,
      balance: data.balance.present ? data.balance.value : this.balance,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BankAccount(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('accountNumber: $accountNumber, ')
          ..write('bankName: $bankName, ')
          ..write('balance: $balance, ')
          ..write('isDefault: $isDefault')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, accountNumber, bankName, balance, isDefault);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BankAccount &&
          other.id == this.id &&
          other.name == this.name &&
          other.accountNumber == this.accountNumber &&
          other.bankName == this.bankName &&
          other.balance == this.balance &&
          other.isDefault == this.isDefault);
}

class BankAccountsCompanion extends UpdateCompanion<BankAccount> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> accountNumber;
  final Value<String> bankName;
  final Value<double> balance;
  final Value<bool> isDefault;
  final Value<int> rowid;
  const BankAccountsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.accountNumber = const Value.absent(),
    this.bankName = const Value.absent(),
    this.balance = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BankAccountsCompanion.insert({
    required String id,
    required String name,
    required String accountNumber,
    required String bankName,
    required double balance,
    this.isDefault = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       accountNumber = Value(accountNumber),
       bankName = Value(bankName),
       balance = Value(balance);
  static Insertable<BankAccount> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? accountNumber,
    Expression<String>? bankName,
    Expression<double>? balance,
    Expression<bool>? isDefault,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (accountNumber != null) 'account_number': accountNumber,
      if (bankName != null) 'bank_name': bankName,
      if (balance != null) 'balance': balance,
      if (isDefault != null) 'is_default': isDefault,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BankAccountsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? accountNumber,
    Value<String>? bankName,
    Value<double>? balance,
    Value<bool>? isDefault,
    Value<int>? rowid,
  }) {
    return BankAccountsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      accountNumber: accountNumber ?? this.accountNumber,
      bankName: bankName ?? this.bankName,
      balance: balance ?? this.balance,
      isDefault: isDefault ?? this.isDefault,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (accountNumber.present) {
      map['account_number'] = Variable<String>(accountNumber.value);
    }
    if (bankName.present) {
      map['bank_name'] = Variable<String>(bankName.value);
    }
    if (balance.present) {
      map['balance'] = Variable<double>(balance.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BankAccountsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('accountNumber: $accountNumber, ')
          ..write('bankName: $bankName, ')
          ..write('balance: $balance, ')
          ..write('isDefault: $isDefault, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final $BankAccountsTable bankAccounts = $BankAccountsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    transactions,
    bankAccounts,
  ];
}

typedef $$TransactionsTableCreateCompanionBuilder =
    TransactionsCompanion Function({
      required String id,
      required DateTime date,
      required String type,
      required String title,
      required String description,
      required double amount,
      required String category,
      Value<String?> location,
      Value<String?> photos,
      Value<String?> smsContent,
      Value<String?> accountId,
      Value<String?> accountType,
      Value<String?> accountNumber,
      Value<String?> accountName,
      Value<String?> walletType,
      Value<String?> cardType,
      Value<String?> cardScheme,
      Value<String?> bankName,
      Value<String?> balanceAvailable,
      Value<String?> balanceOutstanding,
      Value<String?> referenceNo,
      Value<String?> merchant,
      Value<int> rowid,
    });
typedef $$TransactionsTableUpdateCompanionBuilder =
    TransactionsCompanion Function({
      Value<String> id,
      Value<DateTime> date,
      Value<String> type,
      Value<String> title,
      Value<String> description,
      Value<double> amount,
      Value<String> category,
      Value<String?> location,
      Value<String?> photos,
      Value<String?> smsContent,
      Value<String?> accountId,
      Value<String?> accountType,
      Value<String?> accountNumber,
      Value<String?> accountName,
      Value<String?> walletType,
      Value<String?> cardType,
      Value<String?> cardScheme,
      Value<String?> bankName,
      Value<String?> balanceAvailable,
      Value<String?> balanceOutstanding,
      Value<String?> referenceNo,
      Value<String?> merchant,
      Value<int> rowid,
    });

class $$TransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photos => $composableBuilder(
    column: $table.photos,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get smsContent => $composableBuilder(
    column: $table.smsContent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountType => $composableBuilder(
    column: $table.accountType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountNumber => $composableBuilder(
    column: $table.accountNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountName => $composableBuilder(
    column: $table.accountName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get walletType => $composableBuilder(
    column: $table.walletType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cardType => $composableBuilder(
    column: $table.cardType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cardScheme => $composableBuilder(
    column: $table.cardScheme,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bankName => $composableBuilder(
    column: $table.bankName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get balanceAvailable => $composableBuilder(
    column: $table.balanceAvailable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get balanceOutstanding => $composableBuilder(
    column: $table.balanceOutstanding,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceNo => $composableBuilder(
    column: $table.referenceNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get merchant => $composableBuilder(
    column: $table.merchant,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photos => $composableBuilder(
    column: $table.photos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get smsContent => $composableBuilder(
    column: $table.smsContent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountType => $composableBuilder(
    column: $table.accountType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountNumber => $composableBuilder(
    column: $table.accountNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountName => $composableBuilder(
    column: $table.accountName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get walletType => $composableBuilder(
    column: $table.walletType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cardType => $composableBuilder(
    column: $table.cardType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cardScheme => $composableBuilder(
    column: $table.cardScheme,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bankName => $composableBuilder(
    column: $table.bankName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get balanceAvailable => $composableBuilder(
    column: $table.balanceAvailable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get balanceOutstanding => $composableBuilder(
    column: $table.balanceOutstanding,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceNo => $composableBuilder(
    column: $table.referenceNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get merchant => $composableBuilder(
    column: $table.merchant,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get photos =>
      $composableBuilder(column: $table.photos, builder: (column) => column);

  GeneratedColumn<String> get smsContent => $composableBuilder(
    column: $table.smsContent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<String> get accountType => $composableBuilder(
    column: $table.accountType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get accountNumber => $composableBuilder(
    column: $table.accountNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get accountName => $composableBuilder(
    column: $table.accountName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get walletType => $composableBuilder(
    column: $table.walletType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cardType =>
      $composableBuilder(column: $table.cardType, builder: (column) => column);

  GeneratedColumn<String> get cardScheme => $composableBuilder(
    column: $table.cardScheme,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bankName =>
      $composableBuilder(column: $table.bankName, builder: (column) => column);

  GeneratedColumn<String> get balanceAvailable => $composableBuilder(
    column: $table.balanceAvailable,
    builder: (column) => column,
  );

  GeneratedColumn<String> get balanceOutstanding => $composableBuilder(
    column: $table.balanceOutstanding,
    builder: (column) => column,
  );

  GeneratedColumn<String> get referenceNo => $composableBuilder(
    column: $table.referenceNo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get merchant =>
      $composableBuilder(column: $table.merchant, builder: (column) => column);
}

class $$TransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransactionsTable,
          Transaction,
          $$TransactionsTableFilterComposer,
          $$TransactionsTableOrderingComposer,
          $$TransactionsTableAnnotationComposer,
          $$TransactionsTableCreateCompanionBuilder,
          $$TransactionsTableUpdateCompanionBuilder,
          (
            Transaction,
            BaseReferences<_$AppDatabase, $TransactionsTable, Transaction>,
          ),
          Transaction,
          PrefetchHooks Function()
        > {
  $$TransactionsTableTableManager(_$AppDatabase db, $TransactionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<String?> photos = const Value.absent(),
                Value<String?> smsContent = const Value.absent(),
                Value<String?> accountId = const Value.absent(),
                Value<String?> accountType = const Value.absent(),
                Value<String?> accountNumber = const Value.absent(),
                Value<String?> accountName = const Value.absent(),
                Value<String?> walletType = const Value.absent(),
                Value<String?> cardType = const Value.absent(),
                Value<String?> cardScheme = const Value.absent(),
                Value<String?> bankName = const Value.absent(),
                Value<String?> balanceAvailable = const Value.absent(),
                Value<String?> balanceOutstanding = const Value.absent(),
                Value<String?> referenceNo = const Value.absent(),
                Value<String?> merchant = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionsCompanion(
                id: id,
                date: date,
                type: type,
                title: title,
                description: description,
                amount: amount,
                category: category,
                location: location,
                photos: photos,
                smsContent: smsContent,
                accountId: accountId,
                accountType: accountType,
                accountNumber: accountNumber,
                accountName: accountName,
                walletType: walletType,
                cardType: cardType,
                cardScheme: cardScheme,
                bankName: bankName,
                balanceAvailable: balanceAvailable,
                balanceOutstanding: balanceOutstanding,
                referenceNo: referenceNo,
                merchant: merchant,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime date,
                required String type,
                required String title,
                required String description,
                required double amount,
                required String category,
                Value<String?> location = const Value.absent(),
                Value<String?> photos = const Value.absent(),
                Value<String?> smsContent = const Value.absent(),
                Value<String?> accountId = const Value.absent(),
                Value<String?> accountType = const Value.absent(),
                Value<String?> accountNumber = const Value.absent(),
                Value<String?> accountName = const Value.absent(),
                Value<String?> walletType = const Value.absent(),
                Value<String?> cardType = const Value.absent(),
                Value<String?> cardScheme = const Value.absent(),
                Value<String?> bankName = const Value.absent(),
                Value<String?> balanceAvailable = const Value.absent(),
                Value<String?> balanceOutstanding = const Value.absent(),
                Value<String?> referenceNo = const Value.absent(),
                Value<String?> merchant = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionsCompanion.insert(
                id: id,
                date: date,
                type: type,
                title: title,
                description: description,
                amount: amount,
                category: category,
                location: location,
                photos: photos,
                smsContent: smsContent,
                accountId: accountId,
                accountType: accountType,
                accountNumber: accountNumber,
                accountName: accountName,
                walletType: walletType,
                cardType: cardType,
                cardScheme: cardScheme,
                bankName: bankName,
                balanceAvailable: balanceAvailable,
                balanceOutstanding: balanceOutstanding,
                referenceNo: referenceNo,
                merchant: merchant,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransactionsTable,
      Transaction,
      $$TransactionsTableFilterComposer,
      $$TransactionsTableOrderingComposer,
      $$TransactionsTableAnnotationComposer,
      $$TransactionsTableCreateCompanionBuilder,
      $$TransactionsTableUpdateCompanionBuilder,
      (
        Transaction,
        BaseReferences<_$AppDatabase, $TransactionsTable, Transaction>,
      ),
      Transaction,
      PrefetchHooks Function()
    >;
typedef $$BankAccountsTableCreateCompanionBuilder =
    BankAccountsCompanion Function({
      required String id,
      required String name,
      required String accountNumber,
      required String bankName,
      required double balance,
      Value<bool> isDefault,
      Value<int> rowid,
    });
typedef $$BankAccountsTableUpdateCompanionBuilder =
    BankAccountsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> accountNumber,
      Value<String> bankName,
      Value<double> balance,
      Value<bool> isDefault,
      Value<int> rowid,
    });

class $$BankAccountsTableFilterComposer
    extends Composer<_$AppDatabase, $BankAccountsTable> {
  $$BankAccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountNumber => $composableBuilder(
    column: $table.accountNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bankName => $composableBuilder(
    column: $table.bankName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BankAccountsTableOrderingComposer
    extends Composer<_$AppDatabase, $BankAccountsTable> {
  $$BankAccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountNumber => $composableBuilder(
    column: $table.accountNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bankName => $composableBuilder(
    column: $table.bankName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BankAccountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BankAccountsTable> {
  $$BankAccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get accountNumber => $composableBuilder(
    column: $table.accountNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bankName =>
      $composableBuilder(column: $table.bankName, builder: (column) => column);

  GeneratedColumn<double> get balance =>
      $composableBuilder(column: $table.balance, builder: (column) => column);

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);
}

class $$BankAccountsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BankAccountsTable,
          BankAccount,
          $$BankAccountsTableFilterComposer,
          $$BankAccountsTableOrderingComposer,
          $$BankAccountsTableAnnotationComposer,
          $$BankAccountsTableCreateCompanionBuilder,
          $$BankAccountsTableUpdateCompanionBuilder,
          (
            BankAccount,
            BaseReferences<_$AppDatabase, $BankAccountsTable, BankAccount>,
          ),
          BankAccount,
          PrefetchHooks Function()
        > {
  $$BankAccountsTableTableManager(_$AppDatabase db, $BankAccountsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BankAccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BankAccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BankAccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> accountNumber = const Value.absent(),
                Value<String> bankName = const Value.absent(),
                Value<double> balance = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BankAccountsCompanion(
                id: id,
                name: name,
                accountNumber: accountNumber,
                bankName: bankName,
                balance: balance,
                isDefault: isDefault,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String accountNumber,
                required String bankName,
                required double balance,
                Value<bool> isDefault = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BankAccountsCompanion.insert(
                id: id,
                name: name,
                accountNumber: accountNumber,
                bankName: bankName,
                balance: balance,
                isDefault: isDefault,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BankAccountsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BankAccountsTable,
      BankAccount,
      $$BankAccountsTableFilterComposer,
      $$BankAccountsTableOrderingComposer,
      $$BankAccountsTableAnnotationComposer,
      $$BankAccountsTableCreateCompanionBuilder,
      $$BankAccountsTableUpdateCompanionBuilder,
      (
        BankAccount,
        BaseReferences<_$AppDatabase, $BankAccountsTable, BankAccount>,
      ),
      BankAccount,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
  $$BankAccountsTableTableManager get bankAccounts =>
      $$BankAccountsTableTableManager(_db, _db.bankAccounts);
}
