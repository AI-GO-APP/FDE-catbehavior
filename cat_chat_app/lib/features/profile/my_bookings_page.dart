import 'package:flutter/material.dart';

class MyBookingsPage extends StatelessWidget {
  const MyBookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('我的預約紀錄'),
          bottom: const TabBar(
            labelColor: Colors.orange,
            indicatorColor: Colors.orange,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: '即將到來'),
              Tab(text: '歷史紀錄'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildUpcomingList(),
            _buildHistoryList(),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildBookingCard(
          date: '2026-03-25 (三) 14:00',
          title: '行為諮詢 - 到府服務',
          professional: '諮詢師葛雁',
          catName: '橘子',
          status: '已付款確認',
          isUpcoming: true,
        ),
        const SizedBox(height: 12),
        _buildBookingCard(
          date: '2026-04-10 (五) 09:00',
          title: '到府貓保母 - 單次',
          professional: '保母小月',
          catName: '橘子與黑糖',
          status: '等待鑰匙交付',
          isUpcoming: true,
        ),
      ],
    );
  }

  Widget _buildHistoryList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildBookingCard(
          date: '2025-11-12 (一) 10:00',
          title: '線上行為諮詢',
          professional: '諮詢師林子軒',
          catName: '黑糖',
          status: '已結案',
          isUpcoming: false,
        ),
      ],
    );
  }

  Widget _buildBookingCard({
    required String date,
    required String title,
    required String professional,
    required String catName,
    required String status,
    required bool isUpcoming,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(date, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isUpcoming ? Colors.orange.shade50 : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: isUpcoming ? Colors.orange.shade800 : Colors.grey.shade700,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.person_outline, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(professional, style: const TextStyle(color: Colors.grey)),
                const SizedBox(width: 16),
                const Icon(Icons.pets, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(catName, style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 16),
            if (isUpcoming) ...[
              const Divider(height: 1),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text('取消預約', style: TextStyle(color: Colors.grey)),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white),
                    child: const Text('聯絡人員'),
                  ),
                ],
              )
            ]
          ],
        ),
      ),
    );
  }
}
