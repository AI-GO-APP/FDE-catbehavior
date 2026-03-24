import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class AdminBookingDetailPage extends StatelessWidget {
  final String id;

  const AdminBookingDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('預約單詳情 #$id'),
        leading: const BackButton(),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.print, color: AppTheme.primaryDarkColor),
            label: const Text('列印工單', style: TextStyle(color: AppTheme.primaryDarkColor)),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column: Client & Cat Info
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader('預約基本資訊'),
                  _buildInfoCard([
                    _InfoRow('服務類型', '到府貓保母'),
                    _InfoRow('負責保母', '保母小月'),
                    _InfoRow('預約日期', '2026-03-26 (四)'),
                    _InfoRow('服務時段', '14:00 - 15:00'),
                    _InfoRow('狀態', '已確認 (已付款)'),
                  ]),
                  const SizedBox(height: 24),
                  _buildSectionHeader('客戶聯絡資訊'),
                   _buildInfoCard([
                    _InfoRow('客戶姓名', '王大明'),
                    _InfoRow('聯絡電話', '0912-345-678'),
                    _InfoRow('聯絡信箱', 'wang@example.com'),
                    _InfoRow('服務地址', '台北市信義區測試路 100 號 2 樓 (需鑰匙交接)'),
                  ]),
                  const SizedBox(height: 24),
                  _buildSectionHeader('貓咪與行為資訊'),
                  _buildInfoCard([
                    _InfoRow('貓咪名稱', '橘子 (公, 3歲, 已結紮)'),
                    _InfoRow('晶片號碼', '90012345678'),
                    _InfoRow('病史', '無特殊病史，需留意泌尿道健康。'),
                    _InfoRow('近期環境變動', '無 (日常代班)'),
                    _InfoRow('特殊需求/備註', '橘子比較怕生，進門時請先不要馬上靠近他，可以先坐在沙發上等他自己過來聞味道。飼料放在廚房櫃子第二層，一次給半杯。'),
                  ]),
                ],
              ),
            ),
            const SizedBox(width: 24),
            // Right Column: Actions
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader('操作'),
                  Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.check_circle),
                            label: const Text('標記服務完成'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 12),
                          OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.edit_calendar),
                            label: const Text('修改時段'),
                          ),
                           const SizedBox(height: 12),
                          OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.person_add),
                            label: const Text('重新指派員單'),
                          ),
                          const SizedBox(height: 12),
                          TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.cancel, color: Colors.red),
                            label: const Text('取消預約 (退款)', style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildInfoCard(List<_InfoRow> rows) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: rows.map((r) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 120,
                  child: Text(r.label, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  child: Text(r.value, style: const TextStyle(fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          )).toList(),
        ),
      ),
    );
  }
}

class _InfoRow {
  final String label;
  final String value;
  _InfoRow(this.label, this.value);
}
