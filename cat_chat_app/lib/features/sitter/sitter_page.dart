import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';

class SitterPage extends StatelessWidget {
  const SitterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('貓保母預約'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPromotionBanner(context),
            const SizedBox(height: 24),
            _buildSectionTitle(context, '選擇服務區域'),
            _buildAreaGrid(context),
            const SizedBox(height: 32),
            _buildSectionTitle(context, '精選貓保母'),
            _buildSitterList(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildPromotionBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.secondaryColor.withOpacity(0.5),
        border: const Border(bottom: BorderSide(color: AppTheme.primaryColor, width: 0.5)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '到府照顧・安心出門',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryDarkColor,
                  ),
                ),
                const SizedBox(height: 8),
                const Text('由專業保母提供到府餵食、清砂、陪玩服務。'),
              ],
            ),
          ),
          const Icon(Icons.house_siding, size: 64, color: AppTheme.primaryDarkColor),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildAreaGrid(BuildContext context) {
    final areas = ['台北市', '新北市', '桃園市', '台中市', '台南市', '高雄市'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: areas.map((area) => InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(area),
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildSitterList(BuildContext context) {
    final sitters = [
      {'name': '小月', 'exp': '3年經驗', 'rating': 4.9, 'tags': ['耐心', '擅長幼貓']},
      {'name': '阿強', 'exp': '5年經驗', 'rating': 5.0, 'tags': ['基礎醫護', '多貓家庭']},
      {'name': 'Cindy', 'exp': '2年經驗', 'rating': 4.8, 'tags': ['陪玩高手']},
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sitters.length,
      itemBuilder: (context, index) {
        final sitter = sitters[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: const CircleAvatar(
              radius: 30,
              backgroundColor: AppTheme.secondaryColor,
              child: Icon(Icons.person, color: AppTheme.primaryDarkColor, size: 32),
            ),
            title: Text(sitter['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 16),
                    Text(' ${sitter['rating']} | ${sitter['exp']}'),
                  ],
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 4,
                  children: (sitter['tags'] as List<String>).map((t) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(t, style: const TextStyle(fontSize: 10)),
                  )).toList(),
                )
              ],
            ),
            trailing: ElevatedButton(
              onPressed: () {
                context.push('/sitter/$index');
              },
              child: const Text('預約'),
            ),
          ),
        );
      },
    );
  }
}
