import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('貓談社小舖'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _buildCategoryList(context),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: _buildProductGrid(context),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryList(BuildContext context) {
    final categories = ['全部', '玩具', '零食', '情緒用品', '生活用品', '文創周邊'];
    return SizedBox(
      height: 50,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final isSelected = index == 0;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(categories[index]),
              selected: isSelected,
              onSelected: (bool selected) {},
              selectedColor: AppTheme.primaryColor,
              backgroundColor: AppTheme.secondaryColor.withOpacity(0.5),
              labelStyle: TextStyle(
                color: isSelected ? AppTheme.textPrimary : AppTheme.textSecondary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductGrid(BuildContext context) {
    final products = [
      {'title': '逗貓棒 - 仿真飛鳥', 'price': 'NT\$ 250', 'image': Icons.toys},
      {'title': '費利威經典壁插', 'price': 'NT\$ 1,200', 'image': Icons.electrical_services},
      {'title': '貓咪凍乾零食 (鮭魚)', 'price': 'NT\$ 350', 'image': Icons.restaurant},
      {'title': '紓壓毛毛啃咬包', 'price': 'NT\$ 180', 'image': Icons.catching_pokemon},
      {'title': '貓談社品牌帆布袋', 'price': 'NT\$ 450', 'image': Icons.shopping_bag},
      {'title': '貓用慢食碗', 'price': 'NT\$ 500', 'image': Icons.food_bank},
    ];

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final product = products[index];
          return Card(
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: AppTheme.secondaryColor,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      child: Icon(
                        product['image'] as IconData,
                        size: 48,
                        color: AppTheme.primaryDarkColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['title'] as String,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text(
                               product['price'] as String,
                               style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
                             ),
                             Container(
                               padding: const EdgeInsets.all(4),
                               decoration: BoxDecoration(
                                 color: AppTheme.primaryColor,
                                 shape: BoxShape.circle,
                               ),
                               child: const Icon(Icons.add, size: 16, color: AppTheme.textPrimary),
                             )
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
        childCount: products.length,
      ),
    );
  }
}
