import 'package:flutter/material.dart';

class Category {
  final String name;
  final String imageUrl;

  Category({required this.name, required this.imageUrl});
}

class CategoryMenu extends StatefulWidget {
  final Function(String) onCategorySelected;
  final String? selectedCategory;
  final Set<String> selectedPrices;
  final Set<String> selectedBrands;
  final Set<String> selectedColors;
  final Function(String, bool) onPriceChanged;
  final Function(String, bool) onBrandChanged;
  final Function(String, bool) onColorChanged;

  CategoryMenu({
    required this.onCategorySelected,
    this.selectedCategory,
    required this.selectedPrices,
    required this.selectedBrands,
    required this.selectedColors,
    required this.onPriceChanged,
    required this.onBrandChanged,
    required this.onColorChanged,
  });

  @override
  _CategoryMenuState createState() => _CategoryMenuState();
}

class _CategoryMenuState extends State<CategoryMenu> {
  bool _expandPrices = true;
  bool _expandBrands = true;
  bool _expandColors = true;

  List<Category> categories = [
    Category(name: 'Tất cả', imageUrl: 'https://theme.hstatic.net/200000099191/1001041918/14/logo.png?v=407'),
    Category(name: 'Vợt cầu lông', imageUrl: 'https://cdn.hstatic.net/products/200000099191/dsc02350_df77664c66a840308c32f0ca91a6f609.jpg'),
    Category(name: 'Giày cầu lông', imageUrl: 'https://product.hstatic.net/200000099191/product/aytu001-1_1__1__c8b7b6b8-4b8a-4b8a-8b8a-8b8a8b8a8b8a.jpg'),
    Category(name: 'Trang phục cầu lông', imageUrl: 'https://product.hstatic.net/200000099191/product/aplv880-1v_1__1__c8b7b6b8-4b8a-4b8a-8b8a-8b8a8b8a8b8a.jpg'),
    Category(name: 'Túi đựng vợt', imageUrl: 'https://product.hstatic.net/200000099191/product/abag001-1_1__1__c8b7b6b8-4b8a-4b8a-8b8a-8b8a8b8a8b8a.jpg'),
    Category(name: 'Combo', imageUrl: 'https://product.hstatic.net/200000099191/product/aypt281-4_1__1__c8b7b6b8-4b8a-4b8a-8b8a-8b8a8b8a8b8a.jpg'),
    Category(name: 'Quả cầu lông', imageUrl: 'https://product.hstatic.net/200000099191/product/ashu001-1_1__1__c8b7b6b8-4b8a-4b8a-8b8a-8b8a8b8a8b8a.jpg'),
    Category(name: 'Phụ kiện', imageUrl: 'https://product.hstatic.net/200000099191/product/acce001-1_1__1__c8b7b6b8-4b8a-4b8a-8b8a-8b8a8b8a8b8a.jpg'),
  ];

  List<String> brands = [
    'Li-Ning',
    'Halbertec',
    'Zhanji',
  ];

  List<String> colors = [
    'Đen',
    'Trắng',
    'Đỏ',
    'Xanh dương',
    'Xanh lá',
    'Vàng',
    'Tím',
  ];

  List<String> priceRanges = [
    'Giá dưới 1.000.000đ',
    '1.000.000đ - 2.000.000đ',
    '2.000.000đ - 3.000.000đ',
    '3.000.000đ - 5.000.000đ',
    '5.000.000đ - 10.000.000đ',
  ];

  IconData _getCategoryIcon(String categoryName) {
    switch (categoryName) {
      case 'Tất cả':
        return Icons.category;
      case 'Vợt cầu lông':
        return Icons.sports_baseball;
      case 'Giày cầu lông':
        return Icons.directions_run;
      case 'Trang phục cầu lông':
        return Icons.checkroom;
      case 'Túi đựng vợt':
        return Icons.shopping_bag;
      case 'Combo':
        return Icons.inventory_2;
      case 'Quả cầu lông':
        return Icons.sports_soccer;
      case 'Phụ kiện':
        return Icons.extension;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Categories
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.red,
            child: Text(
              'DANH MỤC SẢN PHẨM',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...categories.map((category) {
            bool isSelected = widget.selectedCategory == category.name ||
                (category.name == 'Tất cả' && widget.selectedCategory == null);
            return Container(
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.grey[50],
                border: Border(
                  left: BorderSide(
                    color: isSelected ? Colors.red : Colors.transparent,
                    width: 3,
                  ),
                ),
              ),
              child: ListTile(
                dense: true,
                leading: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      image: NetworkImage(category.imageUrl),
                      fit: BoxFit.cover,
                      onError: (exception, stackTrace) {
                        // Fallback to icon if image fails to load
                      },
                    ),
                  ),
                  child: Image.network(
                    category.imageUrl,
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Icon(
                          _getCategoryIcon(category.name),
                          size: 16,
                          color: Colors.grey[600],
                        ),
                      );
                    },
                  ),
                ),
                title: Text(
                  category.name,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? Colors.red : Colors.black,
                  ),
                ),
                onTap: () => widget.onCategorySelected(category.name),
              ),
            );
          }).toList(),

          SizedBox(height: 16),

          // Price filter
          _buildFilterSection(
            title: 'GIÁ THÀNH',
            isExpanded: _expandPrices,
            onToggle: () => setState(() => _expandPrices = !_expandPrices),
            child: Column(
              children: priceRanges
                  .map((range) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            Checkbox(
                              value: widget.selectedPrices.contains(range),
                              onChanged: (value) => widget.onPriceChanged(range, value ?? false),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                            Expanded(
                              child: Text(
                                range,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),

          // Brands filter
          _buildFilterSection(
            title: 'NHÀ CUNG CẤP',
            isExpanded: _expandBrands,
            onToggle: () => setState(() => _expandBrands = !_expandBrands),
            child: Column(
              children: brands
                  .map((brand) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            Checkbox(
                              value: widget.selectedBrands.contains(brand),
                              onChanged: (value) => widget.onBrandChanged(brand, value ?? false),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                            Expanded(
                              child: Text(
                                brand,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),

          // Colors filter
          _buildFilterSection(
            title: 'MÀU SẮC',
            isExpanded: _expandColors,
            onToggle: () => setState(() => _expandColors = !_expandColors),
            child: Column(
              children: colors
                  .map((color) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            Checkbox(
                              value: widget.selectedColors.contains(color),
                              onChanged: (value) => widget.onColorChanged(color, value ?? false),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                            Expanded(
                              child: Text(
                                color,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildFilterSection({
    required String title,
    required bool isExpanded,
    required VoidCallback onToggle,
    required Widget child,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onToggle,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                Icon(
                  isExpanded ? Icons.expand_less : Icons.expand_more,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: child,
          ),
      ],
    );
  }
}
