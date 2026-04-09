import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../data/dummy_products.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({required this.product, Key? key}) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;

  String _formatPrice(double price) {
    return price.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final relatedProducts = dummyProducts
        .where((p) =>
            p.category == widget.product.category &&
            p.id != widget.product.id)
        .take(4)
        .toList();

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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product image
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Image.network(
                        widget.product.imageUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: Icon(Icons.image_not_supported),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),
                  ),

                  SizedBox(width: 40),

                  // Product details
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Breadcrumb
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Text(
                                'Trang chủ',
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            Text(' / '),
                            Text(widget.product.category),
                            Text(' / '),
                            Text(
                              widget.product.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),

                        // Product name
                        Text(
                          widget.product.name,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 12),

                        // Rating
                        Row(
                          children: [
                            ...List.generate(
                              5,
                              (index) => Icon(
                                index < widget.product.rating.floor()
                                    ? Icons.star_rounded
                                    : Icons.star_border_rounded,
                                size: 18,
                                color: Colors.amber,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              '${widget.product.rating} (${widget.product.reviewCount} đánh giá)',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),

                        // Price section
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.red[50],
                            border: Border.all(color: Colors.red[100]!),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (widget.product.isPromotion &&
                                  widget.product.promotionPrice != null)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Giá khuyến mãi:',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text(
                                      '${_formatPrice(widget.product.promotionPrice!)}₫',
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Giá gốc: ${_formatPrice(widget.product.price)}₫',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
                                )
                              else
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${_formatPrice(widget.product.price)}₫',
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20),

                        // Product info
                        _buildInfoRow('Thương hiệu:', widget.product.brand),
                        _buildInfoRow('Danh mục:', widget.product.category),
                        _buildInfoRow('Màu sắc:', widget.product.color),

                        SizedBox(height: 20),

                        // Quantity selector
                        Row(
                          children: [
                            Text(
                              'Số lượng:',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(width: 16),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove, size: 18),
                                    onPressed: quantity > 1
                                        ? () => setState(() => quantity--)
                                        : null,
                                    constraints: BoxConstraints(
                                      minWidth: 36,
                                      minHeight: 36,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 40,
                                    child: Center(
                                      child: Text(quantity.toString()),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.add, size: 18),
                                    onPressed: () =>
                                        setState(() => quantity++),
                                    constraints: BoxConstraints(
                                      minWidth: 36,
                                      minHeight: 36,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 24),

                        // Add to cart button
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  double priceToAdd = widget.product.isPromotion &&
                                          widget.product.promotionPrice != null
                                      ? widget.product.promotionPrice!
                                      : widget.product.price;

                                  for (int i = 0; i < quantity; i++) {
                                    cart.addItem(
                                      widget.product.id,
                                      widget.product.name,
                                      priceToAdd,
                                      widget.product.imageUrl,
                                    );
                                  }

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Đã thêm $quantity sản phẩm vào giỏ hàng'),
                                      duration: Duration(seconds: 2),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  setState(() => quantity = 1);
                                },
                                icon: Icon(Icons.shopping_cart),
                                label: Text(
                                  'THÊM VÀO GIỎ HÀNG',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('/cart');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[200],
                                foregroundColor: Colors.black,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: Text(
                                'XEM GIỎ HÀNG',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 24),

                        // Description
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Mô tả sản phẩm',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                widget.product.description,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Related products
            if (relatedProducts.isNotEmpty)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                color: Colors.grey[50],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SẢN PHẨM LIÊN QUAN',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: relatedProducts.length,
                      itemBuilder: (ctx, i) {
                        final product = relatedProducts[i];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed(
                              '/product-detail',
                              arguments: product,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: 120,
                                  color: Colors.grey[100],
                                  child: Image.network(
                                    product.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '${_formatPrice(product.price)}₫',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey),
          ),
          SizedBox(width: 12),
          Text(value),
        ],
      ),
    );
  }
}
