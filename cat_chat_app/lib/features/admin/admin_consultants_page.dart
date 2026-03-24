import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminConsultantsPage extends StatelessWidget {
  const AdminConsultantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('專業人員名單'), backgroundColor: Colors.white, foregroundColor: Colors.black),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('諮詢師與保母', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ElevatedButton.icon(
                  onPressed: () => context.push('/admin/consultant/new'),
                  icon: const Icon(Icons.person_add),
                  label: const Text('新增人員'),
                )
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
                          const SizedBox(height: 16),
                          Text('人員 $index', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Chip(
                            label: Text(index % 2 == 0 ? '行為諮詢師' : '貓保母'),
                            backgroundColor: index % 2 == 0 ? Colors.orange.shade100 : Colors.blue.shade100,
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(onPressed: () => context.push('/admin/consultant/$index'), child: const Text('排班設定')),
                              TextButton(onPressed: () => context.push('/admin/consultant/$index'), child: const Text('編輯')),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
