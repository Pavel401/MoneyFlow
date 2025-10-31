import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/selection_controller.dart';
import '../../controllers/items_controller.dart';
import '../../routes/app_pages.dart';
import '../icon_utils.dart';

class SelectItemScreen extends StatelessWidget {
  const SelectItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selection = Get.put(SelectionController());
    final itemsCtrl = Get.put(ItemsController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick an item'),
        actions: [
          IconButton(
            tooltip: 'Add custom item',
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () => Get.toNamed(Routes.addItem),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search items...'),
                    onChanged: (v) => itemsCtrl.query.value = v,
                  ),
                ),
                SizedBox(width: 3.w),
                Obx(() {
                  final cats = ['All', ...itemsCtrl.categories];
                  final sel = itemsCtrl.selectedCategory.value;
                  return DropdownButton<String>(
                    value: sel.isEmpty ? 'All' : sel,
                    items: cats
                        .map((c) => DropdownMenuItem<String>(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (v) {
                      if (v == null || v == 'All') {
                        itemsCtrl.selectedCategory.value = '';
                      } else {
                        itemsCtrl.selectedCategory.value = v;
                      }
                    },
                  );
                })
              ],
            ),
            SizedBox(height: 2.h),
            Expanded(
              child: Obx(() {
                final data = itemsCtrl.filteredItems;
                if (data.isEmpty) {
                  return const Center(child: Text('No items. Add your own with the + button.'));
                }
                return ListView.separated(
                  itemCount: data.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final it = data[index];
                    final hasIcon = (it.iconName ?? '').isNotEmpty;
                    return Dismissible(
                      key: ValueKey('catalog_${it.id}'),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Theme.of(context).colorScheme.error,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Icon(Icons.delete, color: Theme.of(context).colorScheme.onError),
                      ),
                      confirmDismiss: (_) async {
                        return await showDialog<bool>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text('Remove item?'),
                                content: Text('Delete "${it.name}" from your catalog?'),
                                actions: [
                                  TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                                  TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete')),
                                ],
                              ),
                            ) ??
                            false;
                      },
                      onDismissed: (_) async {
                        await itemsCtrl.deleteItem(it.id);
                        Get.snackbar('Deleted', 'Removed ${it.name}');
                      },
                      child: ListTile(
                        leading: hasIcon
                            ? Icon(iconFromName(it.iconName), size: 20.sp)
                            : Icon(Icons.category, size: 20.sp),
                        title: Text(it.name),
                        subtitle: Text((it.description ?? '').isEmpty ? it.category : '${it.category} • ${it.description}'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          selection.pickItemFull(it.name, iconName: it.iconName);
                          Get.toNamed(Routes.enterPrice, arguments: it.defaultPrice ?? 0);
                        },
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.addItem),
        child: const Icon(Icons.add),
      ),
    );
  }
}
