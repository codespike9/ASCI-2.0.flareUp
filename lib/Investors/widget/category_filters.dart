import 'package:flutter/material.dart';
import 'package:flutter_flareup/Investors/models/in_buisness_model.dart';

class CategoryCheckbox extends StatefulWidget {
  const CategoryCheckbox({
    Key? key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final BusinessCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  _CategoryCheckboxState createState() => _CategoryCheckboxState();
}

class _CategoryCheckboxState extends State<CategoryCheckbox> {
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
        widget.onTap();
      },
      child: ListTile(
        title: Text(widget.category.toString().split('.').last),
        leading: Checkbox(
          value: _isSelected,
          onChanged: (_) {
            setState(() {
              _isSelected = !_isSelected;
            });
            widget.onTap();
          },
        ),
      ),
    );
  }
}
