import 'package:flutter/material.dart';
import '../widgets/category_menu.dart';
import '../widgets/product_item.dart';
import '../data/dummy_products.dart';
import '../widgets/app_drawer.dart';
import '../models/product.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';
import '../widgets/breadcrumb.dart';

class HomeScreen extends StatefulWidget {
  final String? initialCategory;

  const HomeScreen({this.initialCategory, Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedCategory;
  String sortBy = 'Mặc định';
  String searchQuery = '';
  Set<String> selectedPrices = {};
  Set<String> selectedBrands = {};
  Set<String> selectedColors = {};

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialCategory;
  }

  List<Product> get filteredProducts {
    List<Product> products = dummyProducts;

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      products = products.where((product) {
        final query = searchQuery.toLowerCase();
        return product.name.toLowerCase().contains(query) ||
            product.description.toLowerCase().contains(query) ||
            product.category.toLowerCase().contains(query);
      }).toList();
    }

    if (selectedCategory != null && selectedCategory != 'Tất cả') {
      products = products.where((product) {
        return product.category == selectedCategory;
      }).toList();
    }

    if (selectedBrands.isNotEmpty) {
      products = products.where((product) {
        return selectedBrands.contains(product.brand);
      }).toList();
    }

    if (selectedColors.isNotEmpty) {
      products = products.where((product) {
        final lowerColor = product.color.toLowerCase();
        return selectedColors.any((color) => lowerColor.contains(color.toLowerCase()));
      }).toList();
    }

    if (selectedPrices.isNotEmpty) {
      products = products.where((product) {
        final price = product.isPromotion && product.promotionPrice != null
            ? product.promotionPrice!
            : product.price;
        return selectedPrices.any((range) {
          switch (range) {
            case 'Giá dưới 1.000.000đ':
              return price < 1000000;
            case '1.000.000đ - 2.000.000đ':
              return price >= 1000000 && price <= 2000000;
            case '2.000.000đ - 3.000.000đ':
              return price > 2000000 && price <= 3000000;
            case '3.000.000đ - 5.000.000đ':
              return price > 3000000 && price <= 5000000;
            case '5.000.000đ - 10.000.000đ':
              return price > 5000000 && price <= 10000000;
            default:
              return false;
          }
        });
      }).toList();
    }

    // Sorting
    if (sortBy == 'Giá tăng dần') {
      products.sort((a, b) {
        double priceA = a.isPromotion && a.promotionPrice != null ? a.promotionPrice! : a.price;
        double priceB = b.isPromotion && b.promotionPrice != null ? b.promotionPrice! : b.price;
        return priceA.compareTo(priceB);
      });
    } else if (sortBy == 'Giá giảm dần') {
      products.sort((a, b) {
        double priceA = a.isPromotion && a.promotionPrice != null ? a.promotionPrice! : a.price;
        double priceB = b.isPromotion && b.promotionPrice != null ? b.promotionPrice! : b.price;
        return priceB.compareTo(priceA);
      });
    } else if (sortBy == 'Tên A-Z') {
      products.sort((a, b) => a.name.compareTo(b.name));
    } else if (sortBy == 'Đánh giá cao nhất') {
      products.sort((a, b) => b.rating.compareTo(a.rating));
    } else if (sortBy == 'Bán chạy nhất') {
      products.sort((a, b) => b.reviewCount.compareTo(a.reviewCount));
    }

    return products;
  }

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
      searchQuery = ''; // Clear search when selecting category
    });
  }

  void togglePriceFilter(String priceRange, bool selected) {
    setState(() {
      if (selected) {
        selectedPrices.add(priceRange);
      } else {
        selectedPrices.remove(priceRange);
      }
    });
  }

  void toggleBrandFilter(String brand, bool selected) {
    setState(() {
      if (selected) {
        selectedBrands.add(brand);
      } else {
        selectedBrands.remove(brand);
      }
    });
  }

  void toggleColorFilter(String color, bool selected) {
    setState(() {
      if (selected) {
        selectedColors.add(color);
      } else {
        selectedColors.remove(color);
      }
    });
  }

  void changeSort(String newSort) {
    setState(() {
      sortBy = newSort;
    });
  }

  void handleSearch(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = filteredProducts;
    
    return Scaffold(
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(
              onCartPressed: () {
                Navigator.of(context).pushNamed('/cart');
              },
              onSearchSubmitted: handleSearch,
            ),
            
            Breadcrumb(
              currentPage: selectedCategory ?? 'Trang chủ',
            ),

            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    searchQuery.isNotEmpty
                        ? 'KẾT QUẢ TÌM KIẾM: "$searchQuery"'
                        : (selectedCategory == 'Tất cả' || selectedCategory == null
                            ? 'TẤT CẢ SẢN PHẨM'
                            : selectedCategory!.toUpperCase()),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 20),

                  // Sort bar
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Sắp xếp:'),
                        SizedBox(width: 16),
                        DropdownButton<String>(
                          value: sortBy,
                          underline: SizedBox(),
                          items: [
                            'Mặc định',
                            'Giá tăng dần',
                            'Giá giảm dần',
                            'Tên A-Z',
                            'Đánh giá cao nhất',
                            'Bán chạy nhất',
                          ]
                              .map((sort) => DropdownMenuItem(
                                    value: sort,
                                    child: Text(sort),
                                  ))
                              .toList(),
                          onChanged: (newSort) {
                            if (newSort != null) {
                              changeSort(newSort);
                            }
                          },
                        ),
                        Spacer(),
                        Text('Hiển thị ${filteredList.length} sản phẩm'),
                      ],
                    ),
                  ),

                  SizedBox(height: 30),

                  // Products grid with sidebar
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Sidebar with filters
                      Container(
                        width: 220,
                        height: 1400, // Expanded height to show all categories and filters
                        child: CategoryMenu(
                          onCategorySelected: selectCategory,
                          selectedCategory: selectedCategory,
                          selectedPrices: selectedPrices,
                          selectedBrands: selectedBrands,
                          selectedColors: selectedColors,
                          onPriceChanged: togglePriceFilter,
                          onBrandChanged: toggleBrandFilter,
                          onColorChanged: toggleColorFilter,
                        ),
                      ),

                      SizedBox(width: 30),

                      // Products grid
                      Expanded(
                        child: filteredList.isEmpty
                            ? Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 40),
                                  child: Text(
                                    'Không có sản phẩm nào trong danh mục này',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              )
                            : GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemCount: filteredList.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  childAspectRatio: 0.75,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 24,
                                ),
                                itemBuilder: (ctx, i) =>
                                    ProductItem(filteredList[i]),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Footer(),
          ],
        ),
      ),
    );
  }
}
