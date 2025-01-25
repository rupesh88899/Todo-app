import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo/utils/extensions.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    super.key,
    required this.title,
    required this.hintText,
    this.controller,
    this.maxLines,
    this.surfixIcon,
    this.readOnly = false,
  });

  final String title;
  final String hintText;
  final int? maxLines;
  final Widget? surfixIcon;
  final bool readOnly;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.titleLarge,
        ),
        Gap(10),
        TextField(
          readOnly: readOnly,
          controller: controller,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          maxLines: maxLines,
          decoration: InputDecoration(
              hintText: hintText,
              suffixIcon: surfixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
              )),
        ),
      ],
    );
  }
}
