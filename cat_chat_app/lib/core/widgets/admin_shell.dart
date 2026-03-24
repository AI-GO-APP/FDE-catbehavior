import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../router/routes.dart';

// 全域模擬狀態：目前管理後台的身分
final ValueNotifier<String> adminRoleNotifier = ValueNotifier<String>('admin');

class AdminShell extends StatelessWidget {
  final Widget child;
  const AdminShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // 判斷是否為寬螢幕 (大於 800px 顯示側邊欄)
    final isWideScreen = MediaQuery.of(context).size.width > 800;
    
    return Scaffold(
      appBar: isWideScreen ? null : AppBar(
        title: const Text('CatChat 管理後台'),
        actions: [
          _buildRoleSwitcher(isMobile: true),
          const SizedBox(width: 16),
        ],
      ),
      drawer: isWideScreen ? null : _buildDrawer(context),
      body: Row(
        children: [
          if (isWideScreen) _buildSidebar(context),
          Expanded(
            child: Container(
              color: Colors.grey[50],
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: _buildMenuContent(context),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 64,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'CatChat Admin',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                _buildRoleSwitcher(isMobile: false),
              ],
            ),
          ),
          Expanded(child: _buildMenuContent(context)),
        ],
      ),
    );
  }

  Widget _buildMenuContent(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;

    return ValueListenableBuilder<String>(
      valueListenable: adminRoleNotifier,
      builder: (context, role, child) {
        final isAdmin = role == 'admin';

        return ListView(
          padding: EdgeInsets.zero,
          children: [
            if (MediaQuery.of(context).size.width <= 800)
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.orange),
                child: Text('CatChat 管理後台', style: TextStyle(color: Colors.white, fontSize: 24)),
              ),
            _buildListTile(
              context,
              icon: Icons.dashboard,
              title: isAdmin ? '總網儀表板' : '我的專屬儀表板',
              route: AppRoutes.adminDashboard,
              isSelected: location == AppRoutes.adminDashboard,
            ),
            _buildListTile(
              context,
              icon: Icons.calendar_month,
              title: isAdmin ? '全站預約管理' : '我的排班與預約',
              route: AppRoutes.adminBookings,
              isSelected: location == AppRoutes.adminBookings || location.startsWith('/admin/booking/'),
            ),
            if (isAdmin)
              _buildListTile(
                context,
                icon: Icons.people,
                title: '專業人員名單',
                route: AppRoutes.adminConsultants,
                isSelected: location == AppRoutes.adminConsultants || location.startsWith('/admin/consultant/'),
              ),
            if (isAdmin)
              _buildListTile(
                context,
                icon: Icons.school,
                title: '課程管理',
                route: AppRoutes.adminCourses,
                isSelected: location == AppRoutes.adminCourses || location.startsWith('/admin/course/'),
              ),
            const Divider(),
            _buildListTile(
              context,
              icon: Icons.exit_to_app,
              title: '返回使用者版',
              route: AppRoutes.home,
              isSelected: false,
            ),
          ],
        );
      },
    );
  }

  Widget _buildRoleSwitcher({required bool isMobile}) {
    return ValueListenableBuilder<String>(
      valueListenable: adminRoleNotifier,
      builder: (context, role, child) {
        return DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: role,
            icon: Icon(Icons.arrow_drop_down, color: isMobile ? Colors.black87 : Colors.grey.shade700),
            style: TextStyle(color: isMobile ? Colors.black87 : Colors.black87, fontWeight: FontWeight.bold, fontSize: 13),
            items: const [
              DropdownMenuItem(value: 'admin', child: Text('系統管理員', style: TextStyle(color: Colors.red))),
              DropdownMenuItem(value: 'consultant', child: Text('諮詢師 葛雁', style: TextStyle(color: Colors.orange))),
              DropdownMenuItem(value: 'sitter', child: Text('保母 小月', style: TextStyle(color: Colors.blue))),
            ],
            onChanged: (newRole) {
              if (newRole != null) {
                adminRoleNotifier.value = newRole;
                // 強制導回儀表板，避免非 Admin 角色卡在課程管理頁
                context.go(AppRoutes.adminDashboard);
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
    required bool isSelected,
  }) {
    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.orange : Colors.grey[600]),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.orange : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedTileColor: Colors.orange.withOpacity(0.1),
      onTap: () {
        context.go(route);
        // 如果在小螢幕的 Drawer 中，點擊後關閉 Drawer
        if (Scaffold.of(context).hasDrawer && Scaffold.of(context).isDrawerOpen) {
          Navigator.of(context).pop();
        }
      },
    );
  }
}
