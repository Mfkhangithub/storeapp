import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final String title;
  final List<String> dropdownItems;
  final List<VoidCallback> dropdownActions;

  CustomDropdown({
    required this.title,
    required this.dropdownItems,
    required this.dropdownActions,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  bool _isDropdownVisible = false;

  void _toggleDropdown() {
    setState(() {
      _isDropdownVisible = !_isDropdownVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _toggleDropdown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Icon(
                _isDropdownVisible ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              ),
            ],
          ),
        ),
        Visibility(
          visible: _isDropdownVisible,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(widget.dropdownItems.length, (index) {
              return GestureDetector(
                onTap: widget.dropdownActions[index],
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(widget.dropdownItems[index]),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
