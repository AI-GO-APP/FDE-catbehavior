import 'package:flutter/material.dart';
import '../router/routes.dart';
import 'package:go_router/go_router.dart';

class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = _calculateSelectedIndex(context);

    return Scaffold(
      body: child,
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go(AppRoutes.home),
        backgroundColor: Colors.orange,
        shape: const CircleBorder(),
        elevation: 4,
        child: const Icon(Icons.home, color: Colors.white, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildTabItem(context, 0, selectedIndex, Icons.psychology_outlined, Icons.psychology, '行為諮詢', AppRoutes.booking),
            _buildTabItem(context, 1, selectedIndex, Icons.calendar_month_outlined, Icons.calendar_month, '我的行程', AppRoutes.myBookings),
            const SizedBox(width: 48), // 給 FAB 留空
            _buildTabItem(context, 3, selectedIndex, Icons.school_outlined, Icons.school, '課程學院', AppRoutes.courses),
            _buildTabItem(context, 4, selectedIndex, Icons.person_outline, Icons.person, '個人中心', AppRoutes.profile),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(BuildContext context, int index, int selectedIndex, IconData icon, IconData activeIcon, String label, String route) {
    final isSelected = index == selectedIndex;
    final color = isSelected ? Colors.orange : Colors.grey;
    return InkWell(
      onTap: () => context.go(route),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(isSelected ? activeIcon : icon, color: color),
            const SizedBox(height: 2),
            Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
          ],
        ),
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location == AppRoutes.home) return 2;
    if (location.startsWith(AppRoutes.booking)) return 0;
    if (location.startsWith(AppRoutes.myBookings)) return 1;
    if (location.startsWith(AppRoutes.courses)) return 3;
    if (location.startsWith(AppRoutes.profile)) return 4;
    return 2;
  }
}

