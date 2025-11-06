import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_theme.dart';

class BalanceCard extends StatelessWidget {
  final double totalCredit;
  final double totalDebit;
  final double totalTransfer;
  final double balance;

  const BalanceCard({
    super.key,
    required this.totalCredit,
    required this.totalDebit,
    required this.totalTransfer,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryBlack,
            AppTheme.primaryBlack.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryBlack.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Balance',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppTheme.primaryWhite.withOpacity(0.8),
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            '₹${_formatAmount(balance)}',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: AppTheme.primaryWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 3.h),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  context,
                  'Income',
                  totalCredit,
                  Icons.arrow_downward,
                  AppTheme.successGreen,
                ),
              ),
              Container(
                width: 1,
                height: 8.h,
                color: AppTheme.primaryWhite.withOpacity(0.2),
                margin: EdgeInsets.symmetric(horizontal: 2.w),
              ),
              Expanded(
                child: _buildStatItem(
                  context,
                  'Expense',
                  totalDebit,
                  Icons.arrow_upward,
                  AppTheme.errorRed,
                ),
              ),
              Container(
                width: 1,
                height: 8.h,
                color: AppTheme.primaryWhite.withOpacity(0.2),
                margin: EdgeInsets.symmetric(horizontal: 2.w),
              ),
              Expanded(
                child: _buildStatItem(
                  context,
                  'Transfer',
                  totalTransfer,
                  Icons.swap_horiz,
                  AppTheme.primaryBlue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String label,
    double amount,
    IconData icon,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(1.5.w),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 4.w),
            ),
            SizedBox(width: 2.w),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.primaryWhite.withOpacity(0.8),
              ),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        Text(
          '₹${_formatAmount(amount)}',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppTheme.primaryWhite,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  String _formatAmount(double amount) {
    final formatter = NumberFormat('#,##,###.##');
    return formatter.format(amount);
  }
}
