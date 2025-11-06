import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../controllers/transaction_controller.dart';
import '../widgets/custom_widgets.dart';
import '../../core/theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TransactionController controller = Get.find<TransactionController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: AppTheme.primaryBlack,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data Management',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryBlack,
              ),
            ),
            SizedBox(height: 3.h),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(4.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.orange,
                          size: 24.sp,
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Reset All Data',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                'This will permanently delete all transactions, categories, and other data. This action cannot be undone.',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    SizedBox(
                      width: double.infinity,
                      child: Obx(
                        () => CustomButton(
                          text: 'Reset All Data',
                          icon: Icons.delete_forever,
                          onPressed: controller.isLoading
                              ? null
                              : () => _showResetConfirmationDialog(
                                  context,
                                  controller,
                                ),
                          isLoading: controller.isLoading,
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'About',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryBlack,
              ),
            ),
            SizedBox(height: 2.h),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Money Tracker',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      'Version 1.0.0',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      'A simple and efficient app to track your financial transactions.',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showResetConfirmationDialog(
    BuildContext context,
    TransactionController controller,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.red, size: 24.sp),
              SizedBox(width: 2.w),
              const Text('Confirm Reset'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Are you sure you want to reset all data?',
                style: TextStyle(fontSize: 14.sp),
              ),
              SizedBox(height: 2.h),
              Text(
                'This will permanently delete:',
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 1.h),
              Text(
                '• All transactions\n• All categories\n• All SMS data\n• All settings',
                style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
              ),
              SizedBox(height: 2.h),
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red[200]!),
                ),
                child: Text(
                  'This action cannot be undone!',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.red[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _performReset(context, controller);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Reset All Data', style: TextStyle(fontSize: 14.sp)),
            ),
          ],
        );
      },
    );
  }

  void _performReset(
    BuildContext context,
    TransactionController controller,
  ) async {
    try {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text('Resetting data...'),
              ],
            ),
          );
        },
      );

      // Perform the reset
      await controller.resetAllData();

      // Close loading dialog
      Navigator.of(context).pop();

      // Show success message
      Get.snackbar(
        'Success',
        'All data has been reset successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );

      // Navigate back to home
      Get.back();
    } catch (e) {
      // Close loading dialog
      Navigator.of(context).pop();

      // Show error message
      Get.snackbar(
        'Error',
        'Failed to reset data: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
    }
  }
}
