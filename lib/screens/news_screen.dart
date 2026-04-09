import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';

class NewsScreen extends StatelessWidget {
  final List<Map<String, String>> news = [
    {
      'title': 'Li-Ning triển khai BST mới cho mùa hè 2024',
      'date': '15/03/2024',
      'image': 'https://cdn.hstatic.net/products/200000099191/dsc02350_df77664c66a840308c32f0ca91a6f609.jpg',
      'content': 'Công ty Li-Ning vừa công bố bộ sưu tập quần áo thể thao mới với thiết kế hiện đại và chất liệu cao cấp.'
    },
    {
      'title': 'Phong trào cầu lông trẻ em phát triển mạnh',
      'date': '12/03/2024',
      'image': 'https://cdn.hstatic.net/products/200000099191/dsc02336_40b9119030a648888b62927447fffd32.jpg',
      'content': 'Các CLB cầu lông tại Hà Nội và TP HCM tiếp tục tuyển sinh và phát triển đội ngũ cầu thủ trẻ.'
    },
    {
      'title': 'Giảm giá sản phẩm cầu lông lên đến 40% - Hôm nay áp dụng',
      'date': '10/03/2024',
      'image': 'https://cdn.hstatic.net/products/200000099191/dsc02369_339e312d4769448fafc024fb03edb295.jpg',
      'content': 'Li-Ning Shop thông báo chương trình khuyến mãi lớn với giảm giá đặc biệt cho tất cả sản phẩm.'
    },
    {
      'title': 'Hướng dẫn chọn vợt cầu lông phù hợp với trình độ',
      'date': '08/03/2024',
      'image': 'https://cdn.hstatic.net/products/200000099191/dsc02383_fcdc373d80b74283b0b57ff51c4fff6c.jpg',
      'content': 'Bài viết chi tiết giúp bạn lựa chọn vợt cầu lông phù hợp tùy theo trình độ chơi của mình.'
    },
    {
      'title': 'Khóa đào tạo kỹ thuật cầu lông cấp 1,2 mở đăng ký',
      'date': '05/03/2024',
      'image': 'https://cdn.hstatic.net/products/200000099191/dsc02326_f26269fa26cd45fc97bc71434023b7d9.jpg',
      'content': 'Trung tâm đào tạo cầu lông Li-Ning mở khóa đào tạo cấp 1,2 với giảm giá đặc biệt cho thành viên.'
    },
    {
      'title': 'Mẹo bảo quản dụng cụ cầu lông trong mùa mưa',
      'date': '01/03/2024',
      'image': 'https://cdn.hstatic.net/products/200000099191/image_0fbd214b21e848d490a09c2f75e3cd5b.jpeg',
      'content': 'Những mẹo hữu ích để bảo quản vợt, giày, và các dụng cụ cầu lông trong thời ẩm ướt.'
    },
  ];

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
                        'Tin tức',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(
                    'TIN TỨC VÀ SỰ KIỆN',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 40),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: news.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.85,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 24,
                    ),
                    itemBuilder: (ctx, i) {
                      final newsItem = news[i];
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                              child: Container(
                                height: 150,
                                width: double.infinity,
                                color: Colors.grey[200],
                                child: Image.network(
                                  newsItem['image']!,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, progress) {
                                    if (progress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: progress.expectedTotalBytes != null
                                            ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes!
                                            : null,
                                        color: Colors.red,
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey[200],
                                      child: Icon(
                                        Icons.broken_image,
                                        color: Colors.grey[400],
                                        size: 60,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    newsItem['date']!,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    newsItem['title']!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      height: 1.4,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    newsItem['content']!,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[700],
                                      height: 1.4,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    'Đọc thêm →',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
}
