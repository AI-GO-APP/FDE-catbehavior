import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/router/routes.dart';

class ProfessionalDetailPage extends StatelessWidget {
  final String id;
  final bool isSitter;

  const ProfessionalDetailPage({super.key, required this.id, this.isSitter = false});

  @override
  Widget build(BuildContext context) {
    final name = isSitter ? '保母小月' : '諮詢師葛雁';
    final role = isSitter ? '到府貓保母' : '貓咪行為諮詢師';

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(name, role),
            const Divider(height: 1),
            _buildAboutSection(),
            const Divider(height: 1),
            _buildCalendarSection(context),
            const SizedBox(height: 100), // padding for FAB
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push(AppRoutes.bookingForm);
        },
        backgroundColor: Colors.orange,
        icon: const Icon(Icons.event_available, color: Colors.white),
        label: const Text('立即預約', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildProfileHeader(String name, String role) {
    return Container(
      padding: const EdgeInsets.all(24),
      color: Colors.orange.shade50,
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Icon(isSitter ? Icons.pets : Icons.psychology, size: 40, color: Colors.orange),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(role, style: TextStyle(fontSize: 16, color: Colors.grey.shade700)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    const Text(' 4.9 (120則評價)'),
                    const Spacer(),
                    Chip(
                      label: const Text('可預約', style: TextStyle(color: Colors.white, fontSize: 12)),
                      backgroundColor: Colors.green.shade400,
                      padding: EdgeInsets.zero,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return const Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('關於我', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Text(
            '擁有五年以上的貓咪行為學基礎與實務經驗，擅長處理多貓家庭衝突、貓咪上廁所問題以及亂咬人的糾正。我相信每一隻貓咪都有自己的獨特個性，從環境與行為下手，幫您建立人貓共好的生活體驗。',
            style: TextStyle(height: 1.5),
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: [
              Chip(label: Text('多貓衝突')),
              Chip(label: Text('亂尿尿排錯')),
              Chip(label: Text('親訓/減敏')),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCalendarSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('選擇可用時段', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          // Mock Calendar UI
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(primary: Colors.orange),
              ),
              child: CalendarDatePicker(
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 90)),
                onDateChanged: (date) {},
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('2026-03-25 可用時段:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildTimeSlot('10:00', true),
              _buildTimeSlot('13:30', true),
              _buildTimeSlot('15:00', false),
              _buildTimeSlot('19:00', true),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTimeSlot(String time, bool available) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: available ? Colors.white : Colors.grey.shade200,
        border: Border.all(color: available ? Colors.orange : Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        time,
        style: TextStyle(
          color: available ? Colors.orange : Colors.grey,
          fontWeight: available ? FontWeight.bold : FontWeight.normal,
          decoration: available ? TextDecoration.none : TextDecoration.lineThrough,
        ),
      ),
    );
  }
}
