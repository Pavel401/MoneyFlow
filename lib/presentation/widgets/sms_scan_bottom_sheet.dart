import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_theme.dart';
import '../controllers/transaction_controller.dart';
import 'custom_widgets.dart';

class SmsScanBottomSheet extends StatefulWidget {
  const SmsScanBottomSheet({super.key});

  @override
  State<SmsScanBottomSheet> createState() => _SmsScanBottomSheetState();
}

class _SmsScanBottomSheetState extends State<SmsScanBottomSheet> {
  final TransactionController controller = Get.find<TransactionController>();
  late DateTime _startDate;
  late DateTime _endDate;
  final DateFormat _dateFormat = DateFormat('MMM dd, yyyy');
  bool _fetchOnlyNew = true;

  @override
  void initState() {
    super.initState();
    // Default to today's messages
    final now = DateTime.now();
    _startDate = DateTime(now.year, now.month, now.day);
    _endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);
  }

  Future<void> _selectStartDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2020),
      lastDate: _endDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppTheme.primaryBlack,
              onPrimary: AppTheme.primaryWhite,
              surface: AppTheme.primaryWhite,
              onSurface: AppTheme.primaryBlack,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = DateTime(picked.year, picked.month, picked.day);
        // Ensure end date is not before start date
        if (_endDate.isBefore(_startDate)) {
          _endDate = DateTime(
            _startDate.year,
            _startDate.month,
            _startDate.day,
            23,
            59,
            59,
          );
        }
      });
    }
  }

  Future<void> _selectEndDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: _startDate,
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppTheme.primaryBlack,
              onPrimary: AppTheme.primaryWhite,
              surface: AppTheme.primaryWhite,
              onSurface: AppTheme.primaryBlack,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = DateTime(picked.year, picked.month, picked.day, 23, 59, 59);
      });
    }
  }

  void _setPresetRange(String preset) {
    final now = DateTime.now();
    setState(() {
      switch (preset) {
        case 'today':
          _startDate = DateTime(now.year, now.month, now.day);
          _endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);
          break;
        case 'yesterday':
          final yesterday = now.subtract(const Duration(days: 1));
          _startDate = DateTime(yesterday.year, yesterday.month, yesterday.day);
          _endDate = DateTime(
            yesterday.year,
            yesterday.month,
            yesterday.day,
            23,
            59,
            59,
          );
          break;
        case 'last7':
          _endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);
          _startDate = DateTime(
            now.subtract(const Duration(days: 6)).year,
            now.subtract(const Duration(days: 6)).month,
            now.subtract(const Duration(days: 6)).day,
          );
          break;
        case 'last30':
          _endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);
          _startDate = DateTime(
            now.subtract(const Duration(days: 29)).year,
            now.subtract(const Duration(days: 29)).month,
            now.subtract(const Duration(days: 29)).day,
          );
          break;
      }
    });
  }

  bool _isPresetSelected(String preset) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final todayEnd = DateTime(now.year, now.month, now.day, 23, 59, 59);

    switch (preset) {
      case 'today':
        return _startDate.isAtSameMomentAs(today) &&
            _endDate.day == todayEnd.day &&
            _endDate.month == todayEnd.month &&
            _endDate.year == todayEnd.year;
      case 'yesterday':
        final yesterday = now.subtract(const Duration(days: 1));
        final yesterdayStart = DateTime(
          yesterday.year,
          yesterday.month,
          yesterday.day,
        );
        return _startDate.isAtSameMomentAs(yesterdayStart) &&
            _endDate.day == yesterday.day &&
            _endDate.month == yesterday.month &&
            _endDate.year == yesterday.year;
      case 'last7':
        final sevenDaysAgo = DateTime(
          now.subtract(const Duration(days: 6)).year,
          now.subtract(const Duration(days: 6)).month,
          now.subtract(const Duration(days: 6)).day,
        );
        return _startDate.isAtSameMomentAs(sevenDaysAgo) &&
            _endDate.day == todayEnd.day &&
            _endDate.month == todayEnd.month &&
            _endDate.year == todayEnd.year;
      case 'last30':
        final thirtyDaysAgo = DateTime(
          now.subtract(const Duration(days: 29)).year,
          now.subtract(const Duration(days: 29)).month,
          now.subtract(const Duration(days: 29)).day,
        );
        return _startDate.isAtSameMomentAs(thirtyDaysAgo) &&
            _endDate.day == todayEnd.day &&
            _endDate.month == todayEnd.month &&
            _endDate.year == todayEnd.year;
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final daysDifference = _endDate.difference(_startDate).inDays + 1;
    final isToday =
        _startDate.day == DateTime.now().day &&
        _startDate.month == DateTime.now().month &&
        _startDate.year == DateTime.now().year &&
        daysDifference == 1;

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppTheme.primaryWhite,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: EdgeInsets.only(top: 1.h),
                width: 10.w,
                height: 0.5.h,
                decoration: BoxDecoration(
                  color: AppTheme.greyLight,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          children: [
                            Icon(
                              Icons.sms,
                              size: 5.w,
                              color: AppTheme.primaryBlack,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              'Scan SMS Messages',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          'Extract transactions from banking SMS',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppTheme.greyDark),
                        ),
                        SizedBox(height: 1.h),
                        // Security badge
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                            vertical: 0.8.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: Colors.green.shade200,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.shield_outlined,
                                size: 14,
                                color: Colors.green.shade700,
                              ),
                              SizedBox(width: 1.w),
                              Expanded(
                                child: Text(
                                  'Processed locally on your device • No cloud uploads',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: Colors.green.shade900,
                                        fontSize: 8.5.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 2.h),

                        // Fetch only new toggle
                        Container(
                          padding: EdgeInsets.all(2.5.w),
                          decoration: BoxDecoration(
                            color: _fetchOnlyNew
                                ? AppTheme.primaryBlack.withOpacity(0.05)
                                : AppTheme.greyLight.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: _fetchOnlyNew
                                  ? AppTheme.primaryBlack.withOpacity(0.2)
                                  : AppTheme.greyLight,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                _fetchOnlyNew ? Icons.sync : Icons.refresh,
                                color: AppTheme.primaryBlack,
                                size: 4.w,
                              ),
                              SizedBox(width: 2.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Smart Sync',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Text(
                                      _fetchOnlyNew
                                          ? 'Only new messages'
                                          : 'All messages (duplicates possible)',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(color: AppTheme.greyDark),
                                    ),
                                  ],
                                ),
                              ),
                              Switch.adaptive(
                                value: _fetchOnlyNew,
                                onChanged: (value) =>
                                    setState(() => _fetchOnlyNew = value),
                                activeColor: AppTheme.primaryBlack,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 2.h),

                        // Quick Select
                        Text(
                          'Quick Select:',
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 1.h),
                        Wrap(
                          spacing: 1.5.w,
                          runSpacing: 0.5.h,
                          children: [
                            _buildPresetChip('Today', 'today'),
                            _buildPresetChip('Yesterday', 'yesterday'),
                            _buildPresetChip('Last 7 days', 'last7'),
                            _buildPresetChip('Last 30 days', 'last30'),
                          ],
                        ),

                        SizedBox(height: 2.h),

                        // Custom date selection
                        Text(
                          'Custom Range:',
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 1.h),

                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: _selectStartDate,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 2.w,
                                    vertical: 1.h,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppTheme.greyLight,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                    color: AppTheme.primaryWhite,
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_today,
                                        size: 16,
                                      ),
                                      SizedBox(width: 1.w),
                                      Expanded(
                                        child: Text(
                                          _dateFormat.format(_startDate),
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodySmall,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: GestureDetector(
                                onTap: _selectEndDate,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 2.w,
                                    vertical: 1.h,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppTheme.greyLight,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                    color: AppTheme.primaryWhite,
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_today,
                                        size: 16,
                                      ),
                                      SizedBox(width: 1.w),
                                      Expanded(
                                        child: Text(
                                          _dateFormat.format(_endDate),
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodySmall,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 2.h),

                        // Summary
                        Container(
                          padding: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryBlack.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                size: 16,
                                color: AppTheme.primaryBlack,
                              ),
                              SizedBox(width: 1.w),
                              Expanded(
                                child: Text(
                                  isToday
                                      ? 'Scanning today\'s messages ${_fetchOnlyNew ? "(new only)" : "(all)"}'
                                      : 'Scanning $daysDifference days ${_fetchOnlyNew ? "(new only)" : "(all)"}',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: AppTheme.primaryBlack,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 3.h),

                        // Action buttons
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => Get.back(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[100],
                                  foregroundColor: Colors.grey[700],
                                  elevation: 0,
                                  side: BorderSide(color: Colors.grey[300]!),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 1.2.h,
                                  ),
                                ),
                                child: const Text('Cancel'),
                              ),
                            ),
                            SizedBox(width: 3.w),
                            Expanded(
                              flex: 2,
                              child: Obx(
                                () => CustomButton(
                                  text: controller.isProcessingSms
                                      ? 'Scanning...'
                                      : 'Start Scan',
                                  icon: controller.isProcessingSms
                                      ? null
                                      : Icons.sms,
                                  isLoading: controller.isProcessingSms,
                                  onPressed: controller.isProcessingSms
                                      ? null
                                      : () {
                                          controller.processSmsMessages(
                                            startDate: _startDate,
                                            endDate: _endDate,
                                            context: context,
                                            fetchOnlyNew: _fetchOnlyNew,
                                          );
                                          Get.back();
                                        },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPresetChip(String label, String preset) {
    final isSelected = _isPresetSelected(preset);

    return GestureDetector(
      onTap: () => _setPresetRange(preset),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 0.8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryBlack : AppTheme.primaryWhite,
          border: Border.all(
            color: isSelected ? AppTheme.primaryBlack : AppTheme.greyLight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppTheme.primaryWhite : AppTheme.primaryBlack,
            fontSize: 9.sp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
