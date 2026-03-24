import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class AdminConsultantEditPage extends StatelessWidget {
  final String? id;

  const AdminConsultantEditPage({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    final isNew = id == null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isNew ? '新增專業人員' : '編輯人員資訊 #$id'),
        leading: const BackButton(),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.save),
            label: const Text('儲存變更'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: AppTheme.primaryDarkColor,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileCard(),
                  const SizedBox(height: 24),
                  _buildTagsCard(),
                ],
              ),
            ),
          ),
          const VerticalDivider(width: 1),
          // Right: Schedule
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: _buildScheduleCard(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: Colors.grey.shade200)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('基本資料', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey.shade200,
                  child: const Icon(Icons.add_a_photo, color: Colors.grey),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    children: [
                      const TextField(decoration: InputDecoration(labelText: '顯示名稱')),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                         decoration: const InputDecoration(labelText: '身分 (功能群組)'),
                         value: 'consultant',
                         items: const [
                           DropdownMenuItem(value: 'consultant', child: Text('行為諮詢師')),
                           DropdownMenuItem(value: 'sitter', child: Text('到府貓保母')),
                         ],
                         onChanged: (v) {},
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(labelText: '顯示抬頭 (Title)', hintText: '貓行為諮詢師 / 講師'),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(labelText: '關於我 (自我介紹)', alignLabelWithHint: true),
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTagsCard() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: Colors.grey.shade200)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('專長與服務標籤', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(label: const Text('多貓衝突'), onDeleted: () {}),
                Chip(label: const Text('環境動線評估'), onDeleted: () {}),
                ActionChip(
                  label: const Text('新增標籤'),
                  avatar: const Icon(Icons.add, size: 16),
                  onPressed: () {},
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleCard() {
     return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: Colors.grey.shade200)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('常規排班設定', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('勾選每週預設開放的時段，若有請假需至「排班月曆」手動關閉。', style: TextStyle(color: Colors.grey, fontSize: 13)),
            const SizedBox(height: 20),
            _buildDaySchedule('週一', true, '10:00 - 18:00'),
            _buildDaySchedule('週二', true, '10:00 - 18:00'),
            _buildDaySchedule('週三', false, '休息'),
            _buildDaySchedule('週四', true, '10:00 - 18:00'),
            _buildDaySchedule('週五', true, '10:00 - 18:00'),
            _buildDaySchedule('週六', true, '13:00 - 21:00'),
            _buildDaySchedule('週日', false, '休息'),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit_calendar),
                label: const Text('開啟排班月曆 (設定特休)'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDaySchedule(String day, bool isOpen, String time) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(value: isOpen, onChanged: (v) {}, activeColor: AppTheme.primaryDarkColor),
              Text(day, style: TextStyle(fontWeight: isOpen ? FontWeight.bold : FontWeight.normal, color: isOpen ? Colors.black : Colors.grey)),
            ],
          ),
          Text(time, style: TextStyle(color: isOpen ? Colors.black : Colors.grey)),
        ],
      ),
    );
  }
}
