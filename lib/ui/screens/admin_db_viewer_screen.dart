import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

import '../../db/app_db.dart';

class AdminDbViewerScreen extends StatefulWidget {
  const AdminDbViewerScreen({super.key});

  @override
  State<AdminDbViewerScreen> createState() => _AdminDbViewerScreenState();
}

class _AdminDbViewerScreenState extends State<AdminDbViewerScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final AppDb _db = Get.find<AppDb>();

  List<Saving> _savings = [];
  List<CatalogItem> _catalogItems = [];
  List<Profile> _profiles = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _loading = true);
    try {
      final savings = await (_db.select(_db.savings).get());
      final catalogItems = await (_db.select(_db.catalogItems).get());
      final profiles = await (_db.select(_db.profiles).get());

      setState(() {
        _savings = savings;
        _catalogItems = catalogItems;
        _profiles = profiles;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      Get.snackbar('Error', 'Failed to load database: $e');
    }
  }

  Future<void> _shareDatabase() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final dbFile = File(p.join(dir.path, 'what_if_invested.db'));

      if (await dbFile.exists()) {
        await Share.shareXFiles(
          [XFile(dbFile.path)],
          text: 'What If Invested Database Export',
          subject: 'Database Export',
        );
      } else {
        Get.snackbar('Error', 'Database file not found');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to share database: $e');
    }
  }

  Widget _buildDataTable<T>({
    required String title,
    required List<T> data,
    required List<String> columns,
    required String Function(T item, String column) getValue,
  }) {
    if (data.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.storage_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
            ),
            SizedBox(height: 2.h),
            Text(
              'No $title data',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      // Enable vertical scrolling first
      padding: EdgeInsets.all(4.w),
      child: SingleChildScrollView(
        // Then enable horizontal scrolling for the table
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 3.w,
          headingRowColor: WidgetStateProperty.all(
            Theme.of(context).colorScheme.primary.withOpacity(0.1),
          ),
          border: TableBorder.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
            width: 1,
          ),
          columns: columns
              .map(
                (column) => DataColumn(
                  label: Text(
                    column,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              )
              .toList(),
          rows: data
              .map(
                (item) => DataRow(
                  cells: columns
                      .map(
                        (column) => DataCell(
                          Container(
                            constraints: BoxConstraints(maxWidth: 40.w),
                            child: Text(
                              getValue(item, column),
                              style: Theme.of(context).textTheme.bodySmall,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  String _getSavingValue(Saving saving, String column) {
    switch (column) {
      case 'ID':
        return saving.id.toString();
      case 'Item Name':
        return saving.itemName;
      case 'Icon Name':
        return saving.itemIconName ?? '-';
      case 'Amount':
        return saving.amount.toStringAsFixed(2);
      case 'Symbol':
        return saving.symbol;
      case 'Investment':
        return saving.investmentName;
      case 'Final Value':
        return saving.finalValue.toStringAsFixed(2);
      case 'Return %':
        return '${saving.returnPct.toStringAsFixed(2)}%';
      case 'Created At':
        return saving.createdAt.toString().split('.')[0];
      default:
        return '-';
    }
  }

  String _getCatalogItemValue(CatalogItem item, String column) {
    switch (column) {
      case 'ID':
        return item.id.toString();
      case 'Name':
        return item.name;
      case 'Category':
        return item.category;
      case 'Emoji':
        return item.emoji ?? '-';
      case 'Icon Name':
        return item.iconName ?? '-';
      case 'Description':
        return item.description ?? '-';
      case 'Kid Specific':
        return item.kidSpecific ? 'Yes' : 'No';
      case 'Default Price':
        return item.defaultPrice?.toStringAsFixed(2) ?? '-';
      case 'Created At':
        return item.createdAt.toString().split('.')[0];
      default:
        return '-';
    }
  }

  String _getProfileValue(Profile profile, String column) {
    switch (column) {
      case 'ID':
        return profile.id.toString();
      case 'Name':
        return profile.name ?? '-';
      case 'Image Path':
        return profile.imagePath ?? '-';
      case 'Date of Birth':
        return profile.dob?.toString().split(' ')[0] ?? '-';
      default:
        return '-';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Debug-only check
    if (kReleaseMode) {
      return Scaffold(
        appBar: AppBar(title: const Text('Admin DB Viewer')),
        body: const Center(
          child: Text('This feature is only available in debug mode.'),
        ),
      );
    }

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('Admin DB Viewer'),
        backgroundColor: colorScheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _shareDatabase,
            icon: const Icon(Icons.share_outlined),
            tooltip: 'Share Database File',
          ),
          IconButton(
            onPressed: _loadData,
            icon: const Icon(Icons.refresh_outlined),
            tooltip: 'Refresh Data',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              text: 'Savings (${_savings.length})',
              icon: const Icon(Icons.savings_outlined),
            ),
            Tab(
              text: 'Catalog (${_catalogItems.length})',
              icon: const Icon(Icons.category_outlined),
            ),
            Tab(
              text: 'Profiles (${_profiles.length})',
              icon: const Icon(Icons.person_outline),
            ),
          ],
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                // Savings Table
                _buildDataTable<Saving>(
                  title: 'savings',
                  data: _savings,
                  columns: [
                    'ID',
                    'Item Name',
                    'Icon Name',
                    'Amount',
                    'Symbol',
                    'Investment',
                    'Final Value',
                    'Return %',
                    'Created At',
                  ],
                  getValue: _getSavingValue,
                ),
                // Catalog Items Table
                _buildDataTable<CatalogItem>(
                  title: 'catalog items',
                  data: _catalogItems,
                  columns: [
                    'ID',
                    'Name',
                    'Category',
                    'Emoji',
                    'Icon Name',
                    'Description',
                    'Kid Specific',
                    'Default Price',
                    'Created At',
                  ],
                  getValue: _getCatalogItemValue,
                ),
                // Profiles Table
                _buildDataTable<Profile>(
                  title: 'profiles',
                  data: _profiles,
                  columns: ['ID', 'Name', 'Image Path', 'Date of Birth'],
                  getValue: _getProfileValue,
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _shareDatabase,
        icon: const Icon(Icons.file_download_outlined),
        label: const Text('Export DB'),
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
      ),
    );
  }
}
