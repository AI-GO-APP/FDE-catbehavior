import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/admin_shell.dart';

class AdminBookingsPage extends StatelessWidget {
  const AdminBookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: adminRoleNotifier,
      builder: (context, role, child) {
        final isAdmin = role == 'admin';
        final isConsultant = role == 'consultant';
        final pageTitle = isAdmin ? '全站預約管理' : (isConsultant ? '葛雁 - 專屬排班與預約' : '小月 - 專屬排班與預約');

        return Scaffold(
          appBar: AppBar(title: Text(pageTitle), backgroundColor: Colors.white, foregroundColor: Colors.black),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(isAdmin ? '所有預約清單' : '我的近期預約', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    if (isAdmin)
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                        label: const Text('手動新增預約'),
                      )
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: '搜尋客戶姓名 / 手機號碼 / 預約編號',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    if (isAdmin)
                      DropdownButtonHideUnderline(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
                          child: DropdownButton<String>(
                            value: '全部服務',
                            items: ['全部服務', '行為諮詢', '到府保母'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                            onChanged: (v) {},
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: Card(
                    child: ListView.separated(
                      itemCount: isAdmin ? 10 : 4,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        // Mock filter
                        final isConsult = isAdmin ? (index % 2 == 0) : isConsultant;
                        final serviceName = isConsult ? '行為諮詢' : '到府保母';

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: isConsult ? Colors.brown.shade100 : Colors.blue.shade100,
                            child: Icon(isConsult ? Icons.psychology : Icons.pets, color: Colors.black87),
                          ),
                          title: Text('預約 #${1000 + index} - $serviceName'),
                          subtitle: Text('客戶: 王大明 | 時間: 2026-03-${25 + index}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextButton(
                                onPressed: () => context.push('/admin/booking/${1000 + index}'), 
                                child: const Text('查看詳情')
                              ),
                              IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
