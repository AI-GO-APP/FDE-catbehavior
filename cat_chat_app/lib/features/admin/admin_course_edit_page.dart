import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class AdminCourseEditPage extends StatelessWidget {
  final String? id;

  const AdminCourseEditPage({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    final isNew = id == null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isNew ? '新增課程' : '編輯課程 #$id'),
        leading: const BackButton(),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.remove_red_eye, color: AppTheme.primaryDarkColor),
            label: const Text('預覽', style: TextStyle(color: AppTheme.primaryDarkColor)),
          ),
          const SizedBox(width: 8),
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
          // Left: Main Form
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionCard('基本資訊', [
                    const TextField(decoration: InputDecoration(labelText: '課程標題', hintText: '貓咪行為學基礎')),
                    const SizedBox(height: 16),
                    const TextField(
                      decoration: InputDecoration(labelText: '課程簡介', hintText: '適合所有新手貓奴的入門課...'),
                      maxLines: 4,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: '授課講師'),
                      value: 'sylvia',
                      items: const [
                        DropdownMenuItem(value: 'sylvia', child: Text('葛雁 Sylvia')),
                        DropdownMenuItem(value: 'lin', child: Text('林子軒醫生')),
                      ],
                      onChanged: (val) {},
                    ),
                  ]),
                  const SizedBox(height: 24),
                  _buildSectionCard('課程大綱', [
                    _buildOutlineItem('單元 1：認識貓咪的天性與需求'),
                    _buildOutlineItem('單元 2：環境建構與生活豐容'),
                    _buildOutlineItem('單元 3：常見行為迷思破解'),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      label: const Text('新增單元'),
                    )
                  ]),
                ],
              ),
            ),
          ),
          const VerticalDivider(width: 1),
          // Right: Settings & Pricing
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionCard('發佈設定', [
                    SwitchListTile(
                      title: const Text('目前狀態'),
                      subtitle: const Text('上架中'),
                      value: true,
                      onChanged: (val) {},
                      activeColor: Colors.green,
                      contentPadding: EdgeInsets.zero,
                    ),
                    const SizedBox(height: 16),
                    const TextField(decoration: InputDecoration(labelText: '封面重點圖 URL', hintText: 'https://...')),
                  ]),
                  const SizedBox(height: 24),
                  _buildSectionCard('定價方案', [
                    const TextField(decoration: InputDecoration(labelText: '原價 (NTD)', prefixText: 'NT\$ '), keyboardType: TextInputType.number),
                    const SizedBox(height: 16),
                    const TextField(decoration: InputDecoration(labelText: '特價 (NTD)', prefixText: 'NT\$ '), keyboardType: TextInputType.number),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: const Text('開放雙人同行優惠'),
                      value: false,
                      onChanged: (val) {},
                      contentPadding: EdgeInsets.zero,
                    ),
                  ]),
                  const SizedBox(height: 24),
                  if (!isNew)
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.delete, color: Colors.red),
                      label: const Text('刪除此課程', style: TextStyle(color: Colors.red)),
                    )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSectionCard(String title, List<Widget> children) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildOutlineItem(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.drag_indicator, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
          IconButton(icon: const Icon(Icons.edit, size: 20), onPressed: () {}, padding: EdgeInsets.zero, constraints: const BoxConstraints()),
          const SizedBox(width: 8),
          IconButton(icon: const Icon(Icons.delete, size: 20, color: Colors.red), onPressed: () {}, padding: EdgeInsets.zero, constraints: const BoxConstraints()),
        ],
      ),
    );
  }
}
