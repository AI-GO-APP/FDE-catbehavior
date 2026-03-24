import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/router/routes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(context),
            const SizedBox(height: 16),
            _buildMenuSection(
              context,
              title: '我的服務',
              items: [
                _MenuItem(icon: Icons.pets, title: '我的貓咪'),
                _MenuItem(icon: Icons.school, title: '我的課程'),
              ],
            ),
            const SizedBox(height: 16),
            _buildMenuSection(
              context,
              title: '優惠與票券',
              items: [
                _MenuItem(icon: Icons.confirmation_number, title: '我的包時數'),
                _MenuItem(icon: Icons.card_giftcard, title: '優惠券'),
              ],
            ),
             const SizedBox(height: 16),
            _buildMenuSection(
              context,
              title: '實用工具',
              items: [
                _MenuItem(icon: Icons.calculate, title: '貓咪熱量計算機'),
                _MenuItem(icon: Icons.article, title: '知識專欄'),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      color: AppTheme.secondaryColor.withOpacity(0.3),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundColor: AppTheme.primaryColor,
            child: Icon(Icons.person, size: 48, color: AppTheme.surfaceColor),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '測試會員 (User)',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'testuser@example.com',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary),
                ),
                const SizedBox(height: 8),
                Container(
                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                   decoration: BoxDecoration(
                     color: AppTheme.secondaryColor,
                     borderRadius: BorderRadius.circular(16),
                     border: Border.all(color: AppTheme.primaryColor),
                   ),
                   child: const Text('一般會員', style: TextStyle(color: AppTheme.primaryDarkColor, fontSize: 12, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppTheme.textSecondary),
        ],
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context, {required String title, required List<_MenuItem> items}) {
    return Container(
      color: AppTheme.surfaceColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textSecondary),
            ),
          ),
          ...items.map((item) => ListTile(
                leading: Icon(item.icon, color: AppTheme.primaryDarkColor),
                title: Text(item.title),
                trailing: const Icon(Icons.chevron_right, size: 20, color: AppTheme.textSecondary),
                onTap: () {
                  if (item.route != null) {
                    context.push(item.route!);
                  }
                },
              )),
          const Divider(height: 1),
        ],
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final String? route;

  _MenuItem({required this.icon, required this.title, this.route});
}
