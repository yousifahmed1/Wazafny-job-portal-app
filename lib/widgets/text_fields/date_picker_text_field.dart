import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:wazafny/constants.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

class DatePickerField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final bool isEnabled;
    final String? Function(String?)? validator;


  const DatePickerField({
    super.key,
    required this.controller,
    this.labelText,
    this.isEnabled = true, this.validator,
  });

  void _showMonthYearPicker(BuildContext context) {
    final now = DateTime.now();
    int selectedMonth = now.month;
    int selectedYear = now.year;

    final List<String> months = List.generate(
        12, (index) => DateFormat.MMM().format(DateTime(0, index + 1)));
    final List<int> years =
        List.generate(now.year - 2000 + 1, (index) => 2000 + index);

    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 300,
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
                final date = DateTime(selectedYear, selectedMonth);
                final formatted = DateFormat('MMM yyyy').format(date);
                controller!.text = formatted;
                Navigator.of(context).pop();
              },
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                          initialItem: selectedMonth - 1),
                      itemExtent: 32.0,
                      onSelectedItemChanged: (index) {
                        selectedMonth = index + 1;
                      },
                      children: months
                          .map((month) => Center(child: Text(month)))
                          .toList(),
                    ),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                          initialItem: selectedYear - 2000),
                      itemExtent: 32.0,
                      onSelectedItemChanged: (index) {
                        selectedYear = 2000 + index;
                      },
                      children: years
                          .map((year) => Center(child: Text(year.toString())))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText ?? "",
          style: const TextStyle(
            color: loginTextColor,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        TextFormField(
          validator: validator,
          enabled: isEnabled,
          readOnly: true,
          onTap: () {
            if (isEnabled) _showMonthYearPicker(context);
          },
          controller: controller,
          cursorColor: loginTextColor,
          style: const TextStyle(
            color: loginTextColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            suffixIcon: IconButton(
              padding: EdgeInsets.zero,
              icon: SvgPicture.asset(
                'assets/Icons/down_arrow.svg',
                color: !isEnabled ? linesColor : null,
              ),
              onPressed: () {},
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 12.0,
            ),
            errorStyle: const TextStyle(
              color: Colors.red,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            fillColor: !isEnabled
                ? offwhiteColor
                : WidgetStateColor.transparent, // Change background color here
            filled: true, // Ensure the background color is applied
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: whiteColor),
              borderRadius: BorderRadius.circular(12.0),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: bordersColor),
              borderRadius: BorderRadius.circular(12.0),
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
