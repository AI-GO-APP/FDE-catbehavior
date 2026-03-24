import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/admin_shell.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: adminRoleNotifier,
      builder: (context, role, child) {
        final isAdmin = role == 'admin';
        final isConsultant = role == 'consultant';
        final name = isAdmin ? '系統' : (isConsultant ? '葛雁' : '小月');

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isAdmin ? '事業儀表板' : '我的專屬儀表板 ($name)',
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              _buildSummaryCards(context, isAdmin),
              const SizedBox(height: 32),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: isAdmin ? 2 : 1,
                    child: _buildRecentBookings(context, role),
                  ),
                  if (isAdmin) const SizedBox(width: 24),
                  if (isAdmin)
                    Expanded(
                      flex: 1,
                      child: _buildSystemAlerts(context),
                    ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummaryCards(BuildContext context, bool isAdmin) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 800 ? 4 : 2;
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 2.5,
          children: [
            _buildStatCard(isAdmin ? '今日全站預約' : '我的今日預約', isAdmin ? '12' : '3', Icons.calendar_today, Colors.blue),
            if (isAdmin) _buildStatCard('待確認保母', '5', Icons.pets, Colors.orange),
            if (isAdmin) _buildStatCard('本月課程營收', 'NT\$ 125,000', Icons.attach_money, Colors.green),
            if (isAdmin) _buildStatCard('活躍會員', '1,208', Icons.people, Colors.purple),
            if (!isAdmin) _buildStatCard('本月服務時數', '32 小時', Icons.timer, Colors.orange),
            if (!isAdmin) _buildStatCard('客戶評價', '4.9', Icons.star, Colors.amber),
          ],
        );
      },
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentBookings(BuildContext context, String role) {
    final isAdmin = role == 'admin';
    final isConsultant = role == 'consultant';
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('即將到來的預約', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                // Mock filtering logic for roles
                final type = (!isAdmin && !isConsultant) ? '到府保母服務' : '貓咪異常行為諮詢';
                final provider = (!isAdmin && !isConsultant) ? '保母小月' : '葛雁';

                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text('客戶姓名 ${index + 1} - $type'),
                  subtitle: Text(isAdmin ? '負責人: $provider | 時間: 2026-03-${25 + index} 14:00' : '時間: 2026-03-${25 + index} 14:00'),
                  trailing: Chip(
                    label: const Text('已確認', style: TextStyle(color: Colors.white, fontSize: 12)),
                    backgroundColor: Colors.green.shade400,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSystemAlerts(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('系統通知', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildAlertItem('需要人工審核：保母小月資格更新', Colors.amber),
            _buildAlertItem('新課程上架成功：貓咪行為學基礎', Colors.green),
            _buildAlertItem('系統備份完成', Colors.blue),
            _buildAlertItem('有 3 筆退款請求待處理', Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertItem(String message, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.circle, size: 12, color: color),
          const SizedBox(width: 8),
          Expanded(child: Text(message)),
        ],
      ),
    );
  }
}
