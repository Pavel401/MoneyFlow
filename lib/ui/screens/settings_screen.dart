import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../data/investments.dart';
import '../../services/market_service.dart';
import '../../db/app_db.dart';
import 'package:drift/drift.dart' as d;

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _service = MarketService();
  bool _syncing = false;
  double _progress = 0;
  final _nameCtrl = TextEditingController();
  final _imageCtrl = TextEditingController();
  DateTime? _dob;
  bool _loadingProfile = true;

  Future<void> _sync() async {
    setState(() {
      _syncing = true;
      _progress = 0;
    });
    final syms = investments.map((e) => e.symbol).toList();
    for (var i = 0; i < syms.length; i++) {
      await _service.fetchOneYearPrices(syms[i], forceRefresh: true);
      setState(() => _progress = (i + 1) / syms.length);
    }
    if (mounted) {
      setState(() => _syncing = false);
      Get.snackbar('Sync complete', 'Market data updated');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final db = Get.isRegistered<AppDb>()
        ? Get.find<AppDb>()
        : Get.put(AppDb(), permanent: true);
    final p = await db.getProfile();
    if (p != null) {
      _nameCtrl.text = p.name ?? '';
      _imageCtrl.text = p.imagePath ?? '';
      _dob = p.dob;
    }
    setState(() => _loadingProfile = false);
  }

  Future<void> _saveProfile() async {
    final db = Get.find<AppDb>();
    final name = _nameCtrl.text.trim();
    final img = _imageCtrl.text.trim();
    await db.upsertProfile(
      ProfilesCompanion(
        id: d.Value(1),
        name: d.Value<String?>(name.isEmpty ? null : name),
        imagePath: d.Value<String?>(img.isEmpty ? null : img),
        dob: d.Value<DateTime?>(_dob),
      ),
    );
    Get.snackbar('Saved', 'Profile updated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Let the Scaffold adjust for the keyboard to avoid overflow
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text('Settings')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bottomInset = MediaQuery.of(context).viewInsets.bottom;
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.fromLTRB(6.w, 6.w, 6.w, 6.w + bottomInset),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  if (_loadingProfile)
                    const LinearProgressIndicator()
                  else ...[
                    TextField(
                      controller: _nameCtrl,
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _dob == null
                                ? 'DOB: Not set'
                                : 'DOB: ${_dob!.toLocal().toString().split(' ').first}',
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            final init = _dob ?? DateTime(2008, 1, 1);
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: init,
                              firstDate: DateTime(1990),
                              lastDate: DateTime.now(),
                            );
                            if (picked != null) setState(() => _dob = picked);
                          },
                          child: const Text('Pick DOB'),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    TextField(
                      controller: _imageCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Image path or URL',
                      ),
                    ),
                    SizedBox(height: 1.h),
                    ElevatedButton(
                      onPressed: _saveProfile,
                      child: const Text('Save Profile'),
                    ),
                    SizedBox(height: 3.h),
                  ],
                  Text(
                    'Market Data',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    'Manually pull and cache 1-year prices for all investments.',
                  ),
                  SizedBox(height: 2.h),
                  ElevatedButton.icon(
                    onPressed: _syncing ? null : _sync,
                    icon: const Icon(Icons.sync),
                    label: const Text('Sync Market Data'),
                  ),
                  if (_syncing) ...[
                    SizedBox(height: 2.h),
                    LinearProgressIndicator(value: _progress),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
