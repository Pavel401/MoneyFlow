import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../core/theme/app_theme.dart';

class TransactionCard extends StatelessWidget {
  final TransactionEntity transaction;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const TransactionCard({
    super.key,
    required this.transaction,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(3.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Transaction type icon
                  Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: transaction.type == TransactionType.credit
                          ? AppTheme.successGreen.withOpacity(0.1)
                          : transaction.type == TransactionType.transfer
                          ? AppTheme.primaryBlue.withOpacity(0.1)
                          : AppTheme.errorRed.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      transaction.type == TransactionType.credit
                          ? Icons.arrow_downward
                          : transaction.type == TransactionType.transfer
                          ? Icons.swap_horiz
                          : Icons.arrow_upward,
                      color: transaction.type == TransactionType.credit
                          ? AppTheme.successGreen
                          : transaction.type == TransactionType.transfer
                          ? AppTheme.primaryBlue
                          : AppTheme.errorRed,
                      size: 5.w,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  // Transaction details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transaction.title,
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          transaction.description,
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  // Amount
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${transaction.type == TransactionType.credit
                            ? '+'
                            : transaction.type == TransactionType.transfer
                            ? ''
                            : '-'}₹${_formatAmount(transaction.amount)}',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: transaction.type == TransactionType.credit
                                  ? AppTheme.successGreen
                                  : transaction.type == TransactionType.transfer
                                  ? AppTheme.primaryBlue
                                  : AppTheme.errorRed,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        DateFormat('MMM dd, yyyy').format(transaction.date),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              // Category and actions row
              Row(
                children: [
                  // Category chip
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                      vertical: 1.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.greyLight,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      _getCategoryDisplayName(transaction.category),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                  if (transaction.location != null) ...[
                    SizedBox(width: 2.w),
                    Icon(
                      Icons.location_on,
                      size: 4.w,
                      color: AppTheme.greyDark,
                    ),
                    SizedBox(width: 1.w),
                    Expanded(
                      child: Text(
                        transaction.location!,
                        style: Theme.of(context).textTheme.labelSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ] else
                    const Spacer(),
                  // Action buttons
                  if (onEdit != null || onDelete != null) ...[
                    IconButton(
                      onPressed: onEdit,
                      icon: Icon(Icons.edit, size: 5.w),
                      padding: EdgeInsets.all(1.w),
                      constraints: const BoxConstraints(),
                    ),
                    IconButton(
                      onPressed: onDelete,
                      icon: Icon(
                        Icons.delete,
                        size: 5.w,
                        color: AppTheme.errorRed,
                      ),
                      padding: EdgeInsets.all(1.w),
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ],
              ),
              // Photos indicator
              if (transaction.photos.isNotEmpty) ...[
                SizedBox(height: 1.h),
                Row(
                  children: [
                    Icon(
                      Icons.photo_library,
                      size: 4.w,
                      color: AppTheme.greyDark,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      '${transaction.photos.length} photo${transaction.photos.length > 1 ? 's' : ''}',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
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
      case TransactionCategory.other:
        return 'Other';
    }
  }
}
