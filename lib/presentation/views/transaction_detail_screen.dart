import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/transaction_entity.dart';
import '../widgets/custom_widgets.dart';
import '../../core/theme/app_theme.dart';
import 'add_transaction_screen.dart';
import '../controllers/transaction_controller.dart';

class TransactionDetailScreen extends StatelessWidget {
  final TransactionEntity transaction;

  const TransactionDetailScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    AddTransactionScreen(transaction: transaction),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Transaction Type and Amount Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: transaction.type == TransactionType.credit
                      ? [
                          AppTheme.successGreen,
                          AppTheme.successGreen.withOpacity(0.8),
                        ]
                      : transaction.type == TransactionType.transfer
                      ? [
                          AppTheme.primaryBlue,
                          AppTheme.primaryBlue.withOpacity(0.8),
                        ]
                      : [AppTheme.errorRed, AppTheme.errorRed.withOpacity(0.8)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        transaction.type == TransactionType.credit
                            ? Icons.arrow_downward
                            : transaction.type == TransactionType.transfer
                            ? Icons.swap_horiz
                            : Icons.arrow_upward,
                        color: AppTheme.primaryWhite,
                        size: 6.w,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        transaction.type == TransactionType.credit
                            ? 'Credit'
                            : transaction.type == TransactionType.transfer
                            ? 'Transfer'
                            : 'Debit',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppTheme.primaryWhite,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${transaction.type == TransactionType.credit
                        ? '+'
                        : transaction.type == TransactionType.transfer
                        ? ''
                        : '-'}₹${_formatAmount(transaction.amount)}',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: AppTheme.primaryWhite,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 3.h),

            // Transaction Details
            _buildDetailSection(context, 'Transaction Information', [
              _buildDetailRow(context, 'Title', transaction.title),
              _buildDetailRow(context, 'Description', transaction.description),
              _buildDetailRow(
                context,
                'Date',
                DateFormat(
                  'MMMM dd, yyyy \'at\' hh:mm a',
                ).format(transaction.date),
              ),
              _buildDetailRow(
                context,
                'Category',
                _getCategoryDisplayName(transaction.category),
              ),
              if (transaction.location != null)
                _buildDetailRow(context, 'Location', transaction.location!),
            ]),

            SizedBox(height: 3.h),

            // SMS Information
            if (transaction.smsContent != null) ...[
              _buildDetailSection(context, 'SMS Information', [
                _buildDetailRow(
                  context,
                  'Original SMS',
                  transaction.smsContent!,
                ),
              ]),
              SizedBox(height: 3.h),
            ],

            // Photos Section
            if (transaction.photos.isNotEmpty) ...[
              _buildDetailSection(context, 'Attachments', [
                SizedBox(
                  height: 20.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: transaction.photos.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 30.w,
                        margin: EdgeInsets.only(right: 2.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppTheme.greyLight,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            transaction.photos[index],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.image_not_supported,
                              size: 10.w,
                              color: AppTheme.greyDark,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ]),
              SizedBox(height: 3.h),
            ],

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Edit',
                    icon: Icons.edit,
                    isOutlined: true,
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            AddTransactionScreen(transaction: transaction),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: CustomButton(
                    text: 'Delete',
                    icon: Icons.delete,
                    backgroundColor: AppTheme.errorRed,
                    onPressed: () => _showDeleteDialog(context),
                  ),
                ),
              ],
            ),

            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.primaryWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.greyMedium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 2.h),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 25.w,
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(color: AppTheme.greyDark),
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Text(value, style: Theme.of(context).textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: AppTheme.errorRed,
              size: 6.w,
            ),
            SizedBox(width: 2.w),
            const Text('Delete Transaction'),
          ],
        ),
        content: Text(
          'Are you sure you want to delete "${transaction.title}"?\n\nThis action cannot be undone.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(
                dialogContext,
              ).pop(); // Close dialog using Material navigation
            },
            child: Text('Cancel', style: TextStyle(color: AppTheme.greyDark)),
          ),
          StatefulBuilder(
            builder: (context, setState) {
              return GetBuilder<TransactionController>(
                builder: (controller) => ElevatedButton(
                  onPressed: controller.isLoading
                      ? null
                      : () async {
                          try {
                            // Delete transaction
                            await controller.deleteTransaction(
                              transaction.id,
                              context,
                            );

                            // Close dialog using Material navigation
                            if (Navigator.of(dialogContext).canPop()) {
                              Navigator.of(dialogContext).pop();
                            }

                            // Go back to previous screen using Material navigation
                            if (Navigator.of(context).canPop()) {
                              Navigator.of(context).pop();
                            }
                          } catch (e) {
                            // Handle any errors (controller already shows snackbar)
                            if (Navigator.of(dialogContext).canPop()) {
                              Navigator.of(dialogContext).pop();
                            }
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.errorRed,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: controller.isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Delete'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String _formatAmount(double amount) {
    final formatter = NumberFormat('#,##,###.##');
    return formatter.format(amount);
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
}
