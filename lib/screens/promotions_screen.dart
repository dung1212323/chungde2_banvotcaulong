import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';
import '../widgets/product_item.dart';
import '../data/dummy_products.dart';
import '../models/product.dart';

class PromotionsScreen extends StatelessWidget {
  List<Product> get promotionalProducts =>
      dummyProducts.where((p) => p.isPromotion).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(
              onCartPressed: () {
                Navigator.of(context).pushNamed('/cart');
              },
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumb
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed('/'),
                        child: Text(
                          'Trang chủ',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      Text(' / '),
                      Text(
                        'Sản phẩm khuyến mãi',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  SizedBox(height: 30),

                  // Title
                  Text(
                    'SẢN PHẨM KHUYẾN MẠI',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 12),

                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.local_offer, color: Colors.red),
                        SizedBox(width: 12),
                        Text(
                          '${promotionalProducts.length} sản phẩm đang được khuyến mãi',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 40),

                  // Products grid
                  if (promotionalProducts.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 60),
                        child: Text(
                          'Hiện chưa có sản phẩm khuyến mãi',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    )
                  else
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: promotionalProducts.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 24,
                      ),
                      itemBuilder: (ctx, i) =>
                          ProductItem(promotionalProducts[i]),
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
