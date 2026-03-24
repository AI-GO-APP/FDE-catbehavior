import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('課程學院'),
          bottom: const TabBar(
            tabs: [
              Tab(text: '所有課程'),
              Tab(text: '我的課程'),
            ],
            indicatorColor: AppTheme.primaryColor,
            labelColor: AppTheme.primaryDarkColor,
            unselectedLabelColor: AppTheme.textSecondary,
          ),
        ),
        body: const TabBarView(
          children: [
            _CourseListTab(),
            _MyCoursesTab(),
          ],
        ),
      ),
    );
  }
}

class _CourseListTab extends StatelessWidget {
  const _CourseListTab();

  @override
  Widget build(BuildContext context) {
    final courses = [
      {
        'title': '專業金牌貓保母・基礎認證班',
        'subtitle': '打造無壓力的貓咪照護體驗',
        'price': 'NT\$ 13,900',
        'tags': ['認證班', '熱門'],
      },
      {
        'title': '貓奴全科工作坊',
        'subtitle': '從飲食到行為，全方位掌握養貓秘訣',
        'price': 'NT\$ 26,500',
        'tags': ['工作坊'],
      },
      {
        'title': '新手貓奴必修課：第一次養貓就上手',
        'subtitle': '給新手爸媽的終極指南',
        'price': 'NT\$ 2,990',
        'tags': ['線上課'],
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: InkWell(
            onTap: () {
              // TODO: Navigate to course details
            },
            borderRadius: BorderRadius.circular(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 140,
                  decoration: const BoxDecoration(
                    color: AppTheme.secondaryColor,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: const Center(
                    child: Icon(Icons.play_circle_fill, size: 48, color: AppTheme.primaryDarkColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: (course['tags'] as List<String>).map((t) => Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            t,
                            style: TextStyle(
                              fontSize: 10,
                              color: AppTheme.primaryDarkColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )).toList(),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        course['title'] as String,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        course['subtitle'] as String,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.textSecondary),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            course['price'] as String,
                            style: const TextStyle(color: Colors.redAccent, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                            child: const Text('查看詳情'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _MyCoursesTab extends StatelessWidget {
  const _MyCoursesTab();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.video_library, size: 64, color: AppTheme.textSecondary.withOpacity(0.5)),
          const SizedBox(height: 16),
          Text(
            '您尚未購買任何課程',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppTheme.textSecondary),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () {
              DefaultTabController.of(context).animateTo(0);
            },
            child: const Text('探索課程'),
          )
        ],
      ),
    );
  }
}
