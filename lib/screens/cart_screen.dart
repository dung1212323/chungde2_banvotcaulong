import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  String _formatPrice(double price) {
    return price.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final cartItems = cart.items.values.toList();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(
              onCartPressed: () {},
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Row(
                children: [
                  Text('Trang chủ', style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                  Text(' / '),
                  Text('Giỏ hàng', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: cartItems.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 80),
                        child: Column(
                          children: [
                            Icon(Icons.shopping_cart_outlined,
                                size: 80, color: Colors.grey[300]),
                            SizedBox(height: 20),
                            Text(
                              'Giỏ hàng của bạn trống',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('/');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: Text('Tiếp tục mua sắm'),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'GIỎ HÀNG CỦA BẠN',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Products list
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  // Header
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      border:
                                          Border.all(color: Colors.grey[300]!),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(flex: 3, child: Text('Sản phẩm')),
                                        Expanded(
                                            flex: 1,
                                            child: Center(child: Text('Giá'))),
                                        Expanded(
                                            flex: 1,
                                            child: Center(
                                                child: Text('Số lượng'))),
                                        Expanded(
                                            flex: 1,
                                            child: Center(
                                                child: Text('Thành tiền'))),
                                        SizedBox(width: 40),
                                      ],
                                    ),
                                  ),
                                  // Items
                                  ...cartItems.asMap().entries.map((entry) {
                                    final item = entry.value;
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 16),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.grey[200]!,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          // Product image & name
                                          Expanded(
                                            flex: 3,
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 80,
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[100],
                                                    borderRadius:
                                                        BorderRadius.circular(4),
                                                  ),
                                                  child: Image.network(
                                                    item.imageUrl,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Icon(
                                                        Icons
                                                            .image_not_supported,
                                                      );
                                                    },
                                                  ),
                                                ),
                                                SizedBox(width: 16),
                                                Expanded(
                                                  child: Text(
                                                    item.name,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Price
                                          Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: Text(
                                                '${_formatPrice(item.price)}₫',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Quantity
                                          Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.grey[300]!,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    InkWell(
                                                      onTap: item.quantity > 1
                                                          ? () {
                                                              Provider.of<CartProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .updateQuantity(
                                                                    item
                                                                        .productId,
                                                                    item.quantity -
                                                                        1,
                                                                  );
                                                            }
                                                          : null,
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          horizontal: 6,
                                                          vertical: 4,
                                                        ),
                                                        child: Icon(Icons.remove,
                                                            size: 16),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 30,
                                                      child: Center(
                                                        child: Text(
                                                          '${item.quantity}',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        Provider.of<CartProvider>(
                                                                context,
                                                                listen: false)
                                                            .updateQuantity(
                                                              item.productId,
                                                              item.quantity + 1,
                                                            );
                                                      },
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          horizontal: 6,
                                                          vertical: 4,
                                                        ),
                                                        child: Icon(Icons.add,
                                                            size: 16),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Total
                                          Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: Text(
                                                '${_formatPrice(item.totalPrice)}₫',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Delete button
                                          IconButton(
                                            icon: Icon(Icons.close,
                                                size: 20,
                                                color: Colors.grey[400]),
                                            onPressed: () {
                                              Provider.of<CartProvider>(
                                                      context,
                                                      listen: false)
                                                  .removeItem(item.productId);
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ],
                              ),
                            ),
                            SizedBox(width: 40),
                            // Summary
                            Container(
                              width: 300,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                border:
                                    Border.all(color: Colors.grey[300]!),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'ĐƠN HÀNG',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  _buildSummaryRow(
                                    'Tạm tính:',
                                    '${_formatPrice(cart.totalAmount)}₫',
                                  ),
                                  SizedBox(height: 12),
                                  _buildSummaryRow(
                                    'Phí vận chuyển:',
                                    'Miễn phí',
                                    color: Colors.green,
                                  ),
                                  SizedBox(height: 12),
                                  Divider(),
                                  SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'TỔNG CỘNG:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        '${_formatPrice(cart.totalAmount)}₫',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Chuyển đến trang thanh toán'),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                      child: Text(
                                        'THANH TOÁN',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  SizedBox(
                                    width: double.infinity,
                                    child: OutlinedButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed('/');
                                      },
                                      style: OutlinedButton.styleFrom(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                      child: Text('TIẾP TỤC MUA SẮM'),
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title:
                                              Text('Xóa tất cả sản phẩm?'),
                                          content: Text(
                                              'Bạn có chắc chắn muốn xóa tất cả sản phẩm trong giỏ hàng?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text('Hủy'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Provider.of<CartProvider>(
                                                        context,
                                                        listen: false)
                                                    .clear();
                                                Navigator.pop(context);
                                              },
                                              child: Text('Xác nhận'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.delete_outline,
                                        size: 16),
                                    label: Text('Xóa giỏ hàng'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red[100],
                                      foregroundColor: Colors.red,
                                    ),
                                  ),
                                ],
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

  Widget _buildSummaryRow(String label, String value, {Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 13)),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}
