import 'package:flutter/material.dart';

class ProductSection extends StatefulWidget {
  final String title;
  final Widget child;
  final Function(String) onSortChanged;

  ProductSection({required this.title, required this.child, required this.onSortChanged});

  @override
  _ProductSectionState createState() => _ProductSectionState();
}

class _ProductSectionState extends State<ProductSection> {
  String sortBy = 'Mặc định';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
              ),
              Row(
                children: [
                  Text('Sắp xếp: ', style: TextStyle(fontSize: 16)),
                  DropdownButton<String>(
                    value: sortBy,
                    items: ['Mặc định', 'Giá tăng dần', 'Giá giảm dần', 'Tên A-Z'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        sortBy = newValue!;
                      });
                      widget.onSortChanged(newValue!);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(child: widget.child),
      ],
    );
  }
}