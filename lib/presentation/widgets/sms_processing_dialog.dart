import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../core/theme/app_theme.dart';

class SmsProcessingDialog extends StatelessWidget {
  final int totalMessages;
  final int processedMessages;
  final bool isComplete;

  const SmsProcessingDialog({
    super.key,
    required this.totalMessages,
    required this.processedMessages,
    this.isComplete = false,
  });

  @override
  Widget build(BuildContext context) {
    final progress = totalMessages > 0 ? processedMessages / totalMessages : 0.0;

    return PopScope(
      canPop: isComplete,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.all(5.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon and Title
              Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlack.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isComplete ? Icons.check_circle : Icons.sms,
                  color: isComplete ? Colors.green : AppTheme.primaryBlack,
                  size: 12.w,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                isComplete ? 'Processing Complete!' : 'Processing SMS',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 1.h),
              Text(
                isComplete
                    ? 'All transactions have been processed'
                    : 'Reading and analyzing your banking messages',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.greyDark,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 3.h),

              // Progress indicator
              if (!isComplete) ...[
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: AppTheme.greyLight,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppTheme.primaryBlack,
                  ),
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
                SizedBox(height: 1.5.h),
                Text(
                  '$processedMessages of $totalMessages messages processed',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.greyDark,
                      ),
                ),
                SizedBox(height: 2.h),
              ],

              // Security assurance
              Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.blue.shade200,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.lock_outline,
                      color: Colors.blue.shade700,
                      size: 20,
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: Text(
                        'All processing happens locally on your device. Your data is completely secure.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.blue.shade900,
                              height: 1.3,
                            ),
                      ),
                    ),
                  ],
                ),
              ),

              if (isComplete) ...[
                SizedBox(height: 2.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryBlack,
                      foregroundColor: AppTheme.primaryWhite,
                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Done'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
