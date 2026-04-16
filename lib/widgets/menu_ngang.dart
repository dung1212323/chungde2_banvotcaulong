import 'package:flutter/material.dart';

class MenuNgang extends StatelessWidget {
  final Function(String) onMenuSelected;
  final String? selectedMenu;

  MenuNgang({required this.onMenuSelected, this.selectedMenu});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildMenuItem('DANH MỤC SẢN PHẨM', 'danh-muc'),
          _buildMenuItem('VỢT CẦU LÔNG', 'vot-cau-long'),
          _buildMenuItem('KHUYẾN MÃI', 'khuyen-mai'),
          _buildMenuItem('ĐĂNG NHẬP', 'dang-nhap'),
          _buildMenuItem('ĐĂNG XUẤT', 'dang-xuat'),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, String key) {
    bool isSelected = selectedMenu == key;
    return TextButton(
      onPressed: () => onMenuSelected(key),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.yellow : Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
