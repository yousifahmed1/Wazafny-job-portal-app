import 'package:flutter/material.dart';
import 'package:wazafny/core/constants/constants.dart';

class AnimatedCustomCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final Color activeColor;
  final double size;

  const AnimatedCustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor = darkerPrimary,
    this.size = 24.0,
  });

  @override
  _AnimatedCustomCheckboxState createState() => _AnimatedCustomCheckboxState();
}

class _AnimatedCustomCheckboxState extends State<AnimatedCustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value); // Toggle the value on tap
      },
      child: AnimatedContainer(
        duration:
            const Duration(milliseconds: 200), // Duration of the animation
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: widget.value
              ? widget.activeColor
              : Colors.transparent, // Background color when checked
          border: Border.all(
            color:
                widget.value ? widget.activeColor : Colors.grey, // Border color
            width: 2.0,
          ),
          borderRadius:
              BorderRadius.circular(widget.size / 4), // Rounded corners
        ),
        child: widget.value
            ? Icon(
                Icons.check,
                size: widget.size *
                    0.6, // Checkmark size relative to the checkbox size
                color: Colors.white, // Checkmark color
              )
            : null, // No checkmark when unchecked
        curve: Curves.easeInOut, // Easing curve for smooth transition
      ),
    );
  }
}
