import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../controllers/transaction_controller.dart';
import '../widgets/balance_card.dart';
import '../widgets/transaction_card.dart';
import '../widgets/custom_widgets.dart';
import '../widgets/swipe_instructions_dialog.dart';
import '../widgets/search_bottom_sheet.dart';
import '../widgets/sms_scan_bottom_sheet.dart';
import '../widgets/sms_privacy_dialog.dart';
import '../../core/theme/app_theme.dart';
import 'add_transaction_screen.dart';
import 'transaction_detail_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TransactionController controller = Get.find<TransactionController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Money Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search & Filter',
            onPressed: () => _showSearchDialog(context, controller),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () => Get.to(() => const SettingsScreen()),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppTheme.primaryBlack),
          );
        }

        return RefreshIndicator(
          onRefresh: () => controller.loadTransactions(),
          color: AppTheme.primaryBlack,
          child: CustomScrollView(
            slivers: [
              // Balance Card
              SliverToBoxAdapter(
                child: BalanceCard(
                  totalCredit: controller.totalCredit,
                  totalDebit: controller.totalDebit,
                  totalTransfer: controller.totalTransfer,
                  balance: controller.balance,
                ),
              ),

              // Quick Actions
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'Scan SMS',
                          icon: Icons.sms,
                          onPressed: controller.isProcessingSms
                              ? null
                              : () => _showSmsScanBottomSheet(
                                  context,
                                  controller,
                                ),
                          isLoading: controller.isProcessingSms,
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: CustomButton(
                          text: 'Add Manual',
                          icon: Icons.add,
                          isOutlined: true,
                          onPressed: () =>
                              Get.to(() => const AddTransactionScreen()),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 2.h).toSliver(),

              // Transactions Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Recent Transactions',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          SizedBox(width: 2.w),
                          IconButton(
                            onPressed: () => _showSwipeInstructions(context),
                            icon: Icon(
                              Icons.help_outline_rounded,
                              size: 5.w,
                              color: AppTheme.primaryBlue,
                            ),
                            tooltip: 'Swipe instructions',
                          ),
                        ],
                      ),
                      // TextButton(
                      //   onPressed: () {
                      //     // Navigate to all transactions
                      //   },
                      //   child: const Text('View All'),
                      // ),
                    ],
                  ),
                ),
              ),

              // Transactions List
              if (controller.filteredTransactions.isEmpty)
                SliverFillRemaining(
                  child: EmptyState(
                    title: 'No transactions yet',
                    subtitle:
                        'Start by adding a transaction manually or scanning your SMS messages',
                    icon: Icons.receipt_long,
                    actionText: 'Add Transaction',
                    onAction: () => Get.to(() => const AddTransactionScreen()),
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final transaction = controller.filteredTransactions[index];
                    return TransactionCard(
                      transaction: transaction,
                      onTap: () => Get.to(
                        () => TransactionDetailScreen(transaction: transaction),
                      ),
                      onEdit: () => Get.to(
                        () => AddTransactionScreen(transaction: transaction),
                      ),
                      // TransactionCard already shows a confirmation dialog
                      // when swiping to delete. So perform deletion directly
                      // here to avoid double confirmation.
                      onDelete: () =>
                          controller.deleteTransaction(transaction.id, context),
                    );
                  }, childCount: controller.filteredTransactions.length),
                ),

              // Bottom padding
              SizedBox(height: 10.h).toSliver(),
            ],
          ),
        );
      }),
    );
  }

  void _showSearchDialog(
    BuildContext context,
    TransactionController controller,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SearchBottomSheet(),
    );
  }

  void _showSwipeInstructions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const SwipeInstructionsDialog(),
    );
  }

  void _showSmsScanBottomSheet(
    BuildContext context,
    TransactionController controller,
  ) {
    // Show privacy dialog first, then SMS scan bottom sheet
    showDialog(
      context: context,
      builder: (context) => SmsPrivacyDialog(
        onAccept: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const SmsScanBottomSheet(),
          );
        },
      ),
    );
  }
}

extension SizedBoxSliver on SizedBox {
  Widget toSliver() => SliverToBoxAdapter(child: this);
}
