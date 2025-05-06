import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wazafny/core/constants/constants.dart';
import 'package:wazafny/widgets/texts/sub_heading_text.dart';

class SearchableTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final List<String> optionsToSelect;
  final void Function(String) onSkillSelected; // NEW
  final String? Function(String?)? validator;

  const SearchableTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.optionsToSelect,
    required this.onSkillSelected, // NEW
    this.validator,
  });

  @override
  State<SearchableTextField> createState() => _SearchableTextFieldState();
}

class _SearchableTextFieldState extends State<SearchableTextField> {
  // ignore: unused_field
  List<String> _filteredOptions = [];

  @override
  void initState() {
    _filteredOptions = widget.optionsToSelect;
    super.initState();
  }

  void _showModalBottomSheet(BuildContext context) {
    _filteredOptions = []; // Start empty

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.8,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return StatefulBuilder(
              builder: (context, setStateModal) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(20),
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Container(
                              height: 3,
                              width: 100,
                              color: linesColor,
                            ),
                            const SizedBox(height: 15),
                            const SubHeadingText(
                              title: "Search for Your Skills",
                              fontSize: 18,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70),
                          border: Border.all(
                            color: linesColor,
                            width: 2.0,
                          ),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: widget.controller,
                            cursorColor: darkPrimary,
                            style: const TextStyle(
                              color: darkPrimary,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                            onChanged: (value) {
                              setStateModal(() {
                                if (value.isEmpty) {
                                  _filteredOptions = [];
                                } else {
                                  _filteredOptions = widget.optionsToSelect
                                      .where((option) => option
                                          .toLowerCase()
                                          .contains(value.toLowerCase()))
                                      .toList();
                                }
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: SvgPicture.asset(
                                  "assets/Icons/search_icon.svg",
                                  width: 24.0,
                                  height: 24.0,
                                ),
                              ),
                              hintText: "Search",
                              hintStyle: const TextStyle(
                                color: bordersColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (_filteredOptions.isNotEmpty)
                        ..._filteredOptions.map((skill) => ListTile(
                              title: Text(skill,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: darkerPrimary,
                                      fontWeight: FontWeight.w700)),
                              onTap: () {
                                widget.onSkillSelected(skill);

                                Navigator.pop(context);
                                widget.controller.clear();
                              },
                            )),
                      widget.controller.text.isEmpty
                          ? const SizedBox()
                          : ListTile(
                              title: const Text(
                                "Add custom skill",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: darkerPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              onTap: () {
                                String customSkill =
                                    widget.controller.text.trim();
                                if (customSkill.isNotEmpty) {
                                  widget.onSkillSelected(customSkill);
                                }
                                Navigator.pop(context);
                                widget.controller.clear();
                              },
                            ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

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
        InkWell(
          onTap: () => _showModalBottomSheet(context),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: bordersColor, width: 2),
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: SubHeadingText(title: "Enter Your Skills"),
            ),
          ),
        )
      ],
    );
  }
}
