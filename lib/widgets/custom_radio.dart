import 'package:flutter/material.dart';

class CustomRadio<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final Color activeColor;
  final MaterialTapTargetSize tapTargetSize;
  final Text label;

  const CustomRadio(
      {Key key,
      this.value,
      this.groupValue,
      this.onChanged,
      this.activeColor,
      this.tapTargetSize,
      this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<T>(
          value: value,
          groupValue: groupValue,
          onChanged: (T newValue){
            onChanged(newValue);
          },
          activeColor: activeColor,
          materialTapTargetSize: tapTargetSize,
        ),
        label,
      ],
    );
  }
}
