import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF2C2C2C),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Company info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CÔNG TY TNHH QUỐC TẾ LINING',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        height: 1.8,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Là kênh phân phối và bán lẻ chính hãng dùng cụ, phụ kiện và trang phục, giày dép môn thể thao câu lông thương hiệu Li-Ning tại Việt Nam',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12,
                        height: 1.6,
                      ),
                      maxLines: 5,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Địa chỉ: CÔNG TY TNHH QUỐC TẾ LINING, Khối DVTM, Tòa Handireseo, 31 Lê Văn Lương, Phương Nhân Chính, Quận Thanh Xuân, Thành phố Hà Nội, Việt Nam',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 11,
                        height: 1.6,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'MST/ĐKKD/QDTL:01061297772',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 11,
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          'Điện thoại: ',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '0338070161',
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Email: ',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          'nguyenducdung10072004@gmail.com',
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFooterTitle('THÔNG TIN HỖ TRỢ'),
                    _buildFooterLink('GIỚI THIỆU'),
                    _buildFooterLink('CHÍNH SÁCH ĐẶT HÀNG'),
                    _buildFooterLink('CHÍNH SÁCH BẢO MẬT'),
                    _buildFooterLink('CHÍNH SÁCH NHẬN HÀNG - KIÊM HÀNG - ĐỔI TRẢ HÀNG'),
                    _buildFooterLink('ĐIỀU KHOẢN DỊCH VỤ'),
                    _buildFooterLink('CHÍNH SÁCH VẬN CHUYỂN'),
                    _buildFooterLink('CHÍNH SÁCH THANH TOÁN'),
                  ],
                ),
              ),

              // Products info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFooterTitle('DANH MỤC SẢN PHẨM'),
                    _buildFooterLink('Vợt cầu lông'),
                    _buildFooterLink('Trang phục cầu lông'),
                    _buildFooterLink('Giày'),
                    _buildFooterLink('Túi dùng vợt'),
                    _buildFooterLink('Máy căng cước'),
                    _buildFooterLink('Quả cầu lông'),
                    _buildFooterLink('Phụ kiện'),
                  ],
                ),
              ),

              // News & Tips
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFooterTitle('TIN TỨC'),
                    _buildFooterLink('TIN KHUYẾN MẠI'),
                    _buildFooterLink('TIN TỨC SỰ KIỆN'),
                    _buildFooterLink('TIN TUYÊN DỤNG'),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 30),
          Divider(color: Colors.grey[700]),
          SizedBox(height: 20),

          // Bottom footer
          Center(
            child: Text(
              'Copyright © 2024 Li-Ning. Tất cả các quyền được bảo lưu.',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildFooterLink(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 12,
            height: 1.8,
          ),
        ),
      ),
    );
  }
}
