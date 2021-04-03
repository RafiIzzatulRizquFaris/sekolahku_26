import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  final ValueChanged<bool> onChanged;
  final bool value;
  final Text label;

  const CustomCheckBox({Key key, this.onChanged, this.value, this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: (newValue) {
              onChanged(newValue);
            },
          ),
          label,
        ],
      ),
    );
  }
}
