import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('預約諮詢'),
          bottom: const TabBar(
            tabs: [
              Tab(text: '預約諮詢師'),
              Tab(text: '包時數方案'),
            ],
            indicatorColor: AppTheme.primaryColor,
            labelColor: AppTheme.primaryDarkColor,
            unselectedLabelColor: AppTheme.textSecondary,
          ),
        ),
        body: const TabBarView(
          children: [
            _ConsultantListTab(),
            _PackageHoursTab(),
          ],
        ),
      ),
    );
  }
}

class _ConsultantListTab extends StatelessWidget {
  const _ConsultantListTab();

  @override
  Widget build(BuildContext context) {
    final consultants = [
      {'name': '葛雁 Sylvia', 'title': '貓行為諮詢師 / 講師', 'desc': '專長：多貓相處、膽小貓親訓、大小便問題', 'tags': ['到府', '線上']},
      {'name': '林子軒', 'title': '貓咪專科醫師 / 諮詢師', 'desc': '專長：高齡貓照護、咬人問題排除', 'tags': ['線上']},
    ];
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: consultants.length,
      itemBuilder: (context, index) {
        final c = consultants[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: InkWell(
            onTap: () {
              context.push('/consultant/$index');
            },
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: AppTheme.secondaryColor,
                    child: Icon(Icons.person, size: 40, color: AppTheme.primaryDarkColor),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          c['name'] as String,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          c['title'] as String,
                          style: TextStyle(color: AppTheme.primaryDarkColor, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          c['desc'] as String,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: (c['tags'] as List<String>).map((t) => Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppTheme.primaryColor),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(t, style: const TextStyle(fontSize: 10)),
                          )).toList(),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PackageHoursTab extends StatelessWidget {
  const _PackageHoursTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Container(
             padding: const EdgeInsets.all(16),
             decoration: BoxDecoration(
               color: AppTheme.secondaryColor,
               borderRadius: BorderRadius.circular(16),
             ),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Row(
                   children: [
                     const Icon(Icons.info_outline, color: AppTheme.primaryDarkColor),
                     const SizedBox(width: 8),
                     Text('什麼是包時數方案？', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                   ],
                 ),
                 const SizedBox(height: 8),
                 const Text('適合需要長期行為追蹤或多貓家庭。購買的時數可彈性用於各諮詢師的到府或線上諮詢，且享有折扣優惠。'),
               ],
             ),
           ),
           const SizedBox(height: 24),
           Text('選擇方案', style: Theme.of(context).textTheme.titleLarge),
           const SizedBox(height: 16),
           _buildPackageCard(context, '3 小時方案', '9折優惠', '適合單一明確問題'),
           _buildPackageCard(context, '6 小時方案', '85折優惠', '適合複雜問題追蹤'),
           _buildPackageCard(context, '9 小時方案', '8折優惠', '適合多貓家庭或長期陪伴'),
        ],
      ),
    );
  }
  
  Widget _buildPackageCard(BuildContext context, String title, String discount, String desc) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(discount, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(desc, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary)),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('立即購買'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
