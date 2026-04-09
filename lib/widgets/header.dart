import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class Header extends StatefulWidget {
  final VoidCallback onCartPressed;
  final Function(String)? onSearchSubmitted;
  const Header({
    required this.onCartPressed,
    this.onSearchSubmitted,
    Key? key,
  }) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          // Top info bar
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Image.network(
                    'https://theme.hstatic.net/200000099191/1001041918/14/logo.png?v=407',
                    height: 40,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Text(
                        'LI-NING',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          letterSpacing: 2,
                        ),
                      );
                    },
                  ),
                ),
                
                // Search bar
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Tìm kiếm sản phẩm...',
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                      onSubmitted: (value) {
                        if (value.isNotEmpty && widget.onSearchSubmitted != null) {
                          widget.onSearchSubmitted!(value);
                        }
                      },
                    ),
                  ),
                ),

                // Contact info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Hotline',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      '0817883038',
                        
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 20),

                // Cart icon with badge
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: IconButton(
                        icon: Icon(
                          Icons.shopping_bag_outlined,
                          size: 28,
                          color: Colors.red,
                        ),
                        onPressed: widget.onCartPressed,
                      ),
                    ),
                    if (cartProvider.itemCount > 0)
                      Positioned(
                        right: 6,
                        top: 2,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                          ),
                          child: Text(
                            cartProvider.itemCount.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          // Navigation menu
          Container(
            color: Colors.red,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildNavItem('DANH MỤC SẢN PHẨM', onTap: () {
                    Navigator.of(context).pushNamed('/', arguments: 'Tất cả');
                  }),
                  _buildNavItem('VỢT CẦU LÔNG', onTap: () {
                    Navigator.of(context).pushNamed('/', arguments: 'Vợt cầu lông');
                  }),
                  _buildNavItem('GIÀY CẦU LÔNG', onTap: () {
                    Navigator.of(context).pushNamed('/', arguments: 'Giày cầu lông');
                  }),
                  _buildNavItem('SẢN PHẨM KHUYẾN MẠI', onTap: () {
                    Navigator.of(context).pushNamed('/promotions');
                  }),
                  _buildNavItem('TIN TỨC', onTap: () {
                    Navigator.of(context).pushNamed('/news');
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String text, {required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
