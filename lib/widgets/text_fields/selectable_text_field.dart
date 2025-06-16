import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

class SelectableTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final List<String> optionsToSelect;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const SelectableTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.optionsToSelect,
    this.validator,
    this.onChanged,
  });

  @override
  State<SelectableTextField> createState() => _SelectableTextFieldState();
}

class _SelectableTextFieldState extends State<SelectableTextField> {
  @override
  void initState() {
    widget.controller.text = widget.optionsToSelect[0];
    super.initState();
  }

  void _showEmploymentTypePicker(BuildContext context) async {
    final List<String> options = widget.optionsToSelect;
    int selectedIndex =
        options.indexOf(widget.controller.text); // Default to the current value

    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 200,
        color: Colors.white,
        child: Column(
          children: [
            CupertinoButton(
              child: const SubHeadingText(
                fontSize: 20,
                title: "Done",
                titleColor: primaryColor,
              ),
              onPressed: () {
                widget.controller.text = options[selectedIndex];
                widget.onChanged?.call(options[selectedIndex]);
                Navigator.of(context).pop();
              },
            ),
            Expanded(
              child: CupertinoPicker(
                scrollController:
                    FixedExtentScrollController(initialItem: selectedIndex),
                itemExtent: 32.0,
                onSelectedItemChanged: (index) {
                  selectedIndex = index;
                },
                children: options
                    .map((option) => Center(
                            child: SubHeadingText1(
                          title: option,
                          titleColor: darkerPrimary,
                          fontSize: 26,
                        )))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    ).then((_) {
      // After selection, update the controller text
      widget.controller.text = options[selectedIndex];
      widget.onChanged?.call(options[selectedIndex]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: const TextStyle(
            color: darkPrimary,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        TextFormField(
          onTap: () =>
              _showEmploymentTypePicker(context), // Trigger picker on tap

          controller: widget.controller,
          readOnly:
              true, // Make the text field read-only to prevent manual input
          validator: widget.validator,
          cursorColor: darkPrimary,
          style: const TextStyle(
            color: darkPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            suffixIcon: IconButton(
              padding: EdgeInsets.zero,
              icon: SvgPicture.asset(
                'assets/Icons/down_arrow.svg',
              ),
              onPressed: () {},
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10.0, // Reduced vertical padding
              horizontal: 12.0, // Horizontal padding for aesthetics
            ),
            errorStyle: const TextStyle(
              color: Colors.red,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: bordersColor),
              borderRadius: BorderRadius.circular(
                  12.0), // Adjust radius for rounded corners
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: bordersColor),
              borderRadius: BorderRadius.circular(12.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: bordersColor, width: 2.0),
              borderRadius: BorderRadius.circular(12.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(12.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 2.0),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
      ],
    );
  }
}
