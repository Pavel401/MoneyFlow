import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../controllers/transaction_controller.dart';
import '../controllers/account_controller.dart';
import '../widgets/custom_widgets.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/entities/bank_account_entity.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/photo_service.dart';
import 'dart:io';

class AddTransactionScreen extends StatefulWidget {
  final TransactionEntity? transaction;

  const AddTransactionScreen({super.key, this.transaction});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  final _locationController = TextEditingController();

  TransactionType _selectedType = TransactionType.debit;
  TransactionCategory _selectedCategory = TransactionCategory.other;
  List<String> _selectedPhotos = [];
  BankAccountEntity? _selectedAccount;
  BankAccountEntity? _selectedToAccount; // For transfers

  bool get isEditing => widget.transaction != null;

  @override
  void initState() {
    super.initState();
    // Load accounts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final accountController = Get.find<AccountController>();
      accountController.loadAccounts();
    });

    if (isEditing) {
      _populateFields();
    } else {
      // Set default account for new transactions
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final accountController = Get.find<AccountController>();
        final defaultAccount = await accountController.getDefaultAccount();
        if (defaultAccount != null && mounted) {
          setState(() {
            _selectedAccount = defaultAccount;
          });
        }
      });
    }
  }

  void _populateFields() {
    final transaction = widget.transaction!;
    _titleController.text = transaction.title;
    _descriptionController.text = transaction.description;
    _amountController.text = transaction.amount.toString();
    _locationController.text = transaction.location ?? '';
    _selectedType = transaction.type;
    _selectedCategory = transaction.category;
    _selectedPhotos = List.from(transaction.photos);

    // Set selected account if accountId is available
    if (transaction.accountId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final accountController = Get.find<AccountController>();
        final accounts = accountController.accounts;
        final account = accounts.firstWhereOrNull(
          (acc) => acc.id == transaction.accountId,
        );
        if (account != null && mounted) {
          setState(() {
            _selectedAccount = account;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Transaction' : 'Add Transaction'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(4.w),
          children: [
            // Transaction Type Selector
            Text(
              'Transaction Type',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Expanded(
                  child: CategoryChip(
                    label: 'Credit',
                    isSelected: _selectedType == TransactionType.credit,
                    selectedColor: AppTheme.successGreen,
                    onTap: () =>
                        setState(() => _selectedType = TransactionType.credit),
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: CategoryChip(
                    label: 'Debit',
                    isSelected: _selectedType == TransactionType.debit,
                    selectedColor: AppTheme.errorRed,
                    onTap: () =>
                        setState(() => _selectedType = TransactionType.debit),
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: CategoryChip(
                    label: 'Transfer',
                    isSelected: _selectedType == TransactionType.transfer,
                    selectedColor: AppTheme.primaryBlue,
                    onTap: () => setState(() {
                      _selectedType = TransactionType.transfer;
                      _selectedCategory = TransactionCategory.transfer;
                      _selectedToAccount = null; // Reset destination account
                    }),
                  ),
                ),
              ],
            ),

            SizedBox(height: 3.h),

            // Bank Account Selector
            Text(
              'Bank Account',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 2.h),
            GetBuilder<AccountController>(
              builder: (accountController) {
                if (accountController.accounts.isEmpty) {
                  return Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppTheme.greyMedium),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.account_balance,
                          color: AppTheme.greyDark,
                          size: 6.w,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'No bank accounts found',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppTheme.greyDark),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          'Add a bank account first',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppTheme.greyDark),
                        ),
                      ],
                    ),
                  );
                }

                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.greyMedium),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonFormField<String>(
                    initialValue: _selectedAccount?.id,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        vertical: 3.h,
                      ),
                      border: InputBorder.none,
                      hintText: 'Select a bank account',
                    ),
                    isDense: false,
                    isExpanded: true,
                    itemHeight: 8.h,
                    items: accountController.accounts.map((account) {
                      return DropdownMenuItem<String>(
                        value: account.id,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                account.displayName,
                                style: Theme.of(context).textTheme.bodyMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 0.5.h),
                              Text(
                                '${account.bankName} • ₹${account.balance.toStringAsFixed(2)}',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: AppTheme.greyDark),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (accountId) {
                      final account = accountController.accounts
                          .firstWhereOrNull((acc) => acc.id == accountId);
                      setState(() {
                        _selectedAccount = account;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a bank account';
                      }
                      return null;
                    },
                  ),
                );
              },
            ),

            // Transfer destination account (only show for transfers)
            if (_selectedType == TransactionType.transfer) ...[
              SizedBox(height: 3.h),
              Text(
                'Transfer To Account',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 2.h),
              GetBuilder<AccountController>(
                builder: (accountController) {
                  final availableAccounts = accountController.accounts
                      .where((acc) => acc.id != _selectedAccount?.id)
                      .toList();

                  if (availableAccounts.isEmpty) {
                    return Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppTheme.greyMedium),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'No other accounts available for transfer',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.greyDark,
                        ),
                      ),
                    );
                  }

                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppTheme.greyMedium),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonFormField<String>(
                      initialValue: _selectedToAccount?.id,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 3.w,
                          vertical: 3.h,
                        ),
                        border: InputBorder.none,
                        hintText: 'Select destination account',
                      ),
                      isDense: false,
                      isExpanded: true,
                      itemHeight: 8.h,
                      items: availableAccounts.map((account) {
                        return DropdownMenuItem<String>(
                          value: account.id,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 1.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  account.displayName,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 0.5.h),
                                Text(
                                  '${account.bankName} • ₹${account.balance.toStringAsFixed(2)}',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: AppTheme.greyDark),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (accountId) {
                        final account = availableAccounts.firstWhereOrNull(
                          (acc) => acc.id == accountId,
                        );
                        setState(() {
                          _selectedToAccount = account;
                        });
                      },
                      validator: (value) {
                        if (_selectedType == TransactionType.transfer &&
                            value == null) {
                          return 'Please select destination account';
                        }
                        return null;
                      },
                    ),
                  );
                },
              ),
            ],

            SizedBox(height: 3.h),

            // Title Field
            CustomTextField(
              label: 'Title',
              hint: 'Enter transaction title',
              controller: _titleController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),

            SizedBox(height: 3.h),

            // Amount Field
            CustomTextField(
              label: 'Amount',
              hint: 'Enter amount',
              controller: _amountController,
              keyboardType: TextInputType.number,
              prefixIcon: const Icon(Icons.currency_rupee),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an amount';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid amount';
                }
                return null;
              },
            ),

            SizedBox(height: 3.h),

            // Description Field
            CustomTextField(
              label: 'Description',
              hint: 'Enter transaction description',
              controller: _descriptionController,
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),

            SizedBox(height: 3.h),

            // Category Selector (hide for transfers)
            if (_selectedType != TransactionType.transfer) ...[
              Text('Category', style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: 2.h),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 2.w,
                mainAxisSpacing: 1.h,
                childAspectRatio: 2.5,
                children: TransactionCategory.values
                    .where(
                      (category) => category != TransactionCategory.transfer,
                    ) // Hide transfer category from manual selection
                    .map(
                      (category) => CategoryChip(
                        label: _getCategoryDisplayName(category),
                        isSelected: _selectedCategory == category,
                        onTap: () =>
                            setState(() => _selectedCategory = category),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: 3.h),
            ],

            // Location Field
            CustomTextField(
              label: 'Location (Optional)',
              hint: 'Enter location',
              controller: _locationController,
              prefixIcon: const Icon(Icons.location_on),
            ),

            SizedBox(height: 3.h),

            // Photos Section
            Text(
              'Photos (Optional)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 2.h),
            Container(
              width: double.infinity,
              constraints: BoxConstraints(minHeight: 15.h),
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.greyMedium),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  if (_selectedPhotos.isEmpty)
                    Column(
                      children: [
                        Icon(
                          Icons.photo_camera,
                          size: 8.w,
                          color: AppTheme.greyDark,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'Add photos to your transaction',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppTheme.greyDark),
                        ),
                      ],
                    )
                  else
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2.w,
                        mainAxisSpacing: 2.w,
                      ),
                      itemCount: _selectedPhotos.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(_selectedPhotos[index]),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      color: AppTheme.greyLight,
                                      child: Icon(
                                        Icons.image_not_supported,
                                        color: AppTheme.greyDark,
                                      ),
                                    ),
                              ),
                            ),
                            Positioned(
                              top: 1.w,
                              right: 1.w,
                              child: GestureDetector(
                                onTap: () => _removePhoto(index),
                                child: Container(
                                  padding: EdgeInsets.all(1.w),
                                  decoration: const BoxDecoration(
                                    color: AppTheme.errorRed,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    color: AppTheme.primaryWhite,
                                    size: 4.w,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'Camera',
                          icon: Icons.camera_alt,
                          isOutlined: true,
                          onPressed: _pickFromCamera,
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: CustomButton(
                          text: 'Gallery',
                          icon: Icons.photo_library,
                          isOutlined: true,
                          onPressed: _pickFromGallery,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 5.h),

            // Submit Button
            GetBuilder<TransactionController>(
              builder: (controller) => CustomButton(
                text: isEditing ? 'Update Transaction' : 'Add Transaction',
                isLoading: controller.isLoading,
                onPressed: () => _submitTransaction(controller),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitTransaction(TransactionController controller) {
    if (_formKey.currentState!.validate()) {
      final amount = double.parse(_amountController.text);
      final location = _locationController.text.isEmpty
          ? null
          : _locationController.text;

      if (isEditing) {
        final updatedTransaction = widget.transaction!.copyWith(
          title: _titleController.text,
          description: _descriptionController.text,
          amount: amount,
          type: _selectedType,
          category: _selectedCategory,
          location: location,
          photos: _selectedPhotos,
          accountId: _selectedAccount?.id,
        );
        controller.updateTransaction(updatedTransaction, context);
      } else {
        // Handle transfer transactions differently
        if (_selectedType == TransactionType.transfer &&
            _selectedAccount != null &&
            _selectedToAccount != null) {
          controller.addTransferTransaction(
            title: _titleController.text,
            description: _descriptionController.text,
            amount: amount,
            fromAccountId: _selectedAccount!.id,
            toAccountId: _selectedToAccount!.id,
            location: location,
            photos: _selectedPhotos,
            context: context,
          );
        } else {
          // Regular transaction
          controller.addManualTransaction(
            title: _titleController.text,
            description: _descriptionController.text,
            amount: amount,
            type: _selectedType,
            category: _selectedCategory,
            location: location,
            photos: _selectedPhotos,
            accountId: _selectedAccount?.id,
          );
        }
      }

      Get.back();
    }
  }

  String _getCategoryDisplayName(TransactionCategory category) {
    switch (category) {
      case TransactionCategory.food:
        return 'Food';
      case TransactionCategory.grocery:
        return 'Grocery';
      case TransactionCategory.transport:
        return 'Transport';
      case TransactionCategory.entertainment:
        return 'Entertainment';
      case TransactionCategory.shopping:
        return 'Shopping';
      case TransactionCategory.healthcare:
        return 'Healthcare';
      case TransactionCategory.education:
        return 'Education';
      case TransactionCategory.utilities:
        return 'Utilities';
      case TransactionCategory.fuel:
        return 'Fuel';
      case TransactionCategory.transfer:
        return 'Transfer';
      case TransactionCategory.other:
        return 'Other';
    }
  }

  void _removePhoto(int index) {
    setState(() {
      _selectedPhotos.removeAt(index);
    });
  }

  Future<void> _pickFromCamera() async {
    final imagePath = await PhotoService.pickImageFromCamera();
    if (imagePath != null) {
      setState(() {
        _selectedPhotos.add(imagePath);
      });
    }
  }

  Future<void> _pickFromGallery() async {
    final imagePaths = await PhotoService.pickImages(
      maxImages: 5 - _selectedPhotos.length,
    );
    if (imagePaths.isNotEmpty) {
      setState(() {
        _selectedPhotos.addAll(imagePaths);
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    _locationController.dispose();
    super.dispose();
  }
}
