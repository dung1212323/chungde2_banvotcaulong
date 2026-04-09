import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.red),
            child: Text('LI-NING',
                style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Danh mục sản phẩm'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context)
                  .pushReplacementNamed('/', arguments: 'Tất cả');
            },
          ),
          ListTile(
            leading: Icon(Icons.sports_tennis),
            title: Text('Vợt cầu lông'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context)
                  .pushReplacementNamed('/', arguments: 'Vợt cầu lông');
            },
          ),
          ListTile(
            leading: Icon(Icons.local_offer),
            title: Text('Khuyến mại'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/promotions');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.login),
            title: Text('Đăng nhập'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/login');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Đăng xuất'),
            onTap: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Bạn đã đăng xuất.')),
              );
            },
          ),
        ],
      ),
    );
  }
}
