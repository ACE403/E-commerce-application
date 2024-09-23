import 'package:ecomm/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:ecomm/utils/constants/colors.dart';
import 'package:ecomm/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TChoiceChip extends StatelessWidget {
  const TChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });
  final String text;
  final bool selected;
  final void Function(bool)? onSelected;
  @override
  Widget build(BuildContext context) {
    final isColor = THelperFunctions.getColor(text);
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: isColor != null ? SizedBox() : Text(text),
        selected: selected,
        onSelected: onSelected,
        labelStyle: TextStyle(color: selected ? TColors.white : null),
        avatar: isColor != null
            ? TCircularContainer(
                width: 50,
                height: 50,
                backgroundcolor: THelperFunctions.getColor(text)!,
              )
            : null,
        shape: isColor != null ? CircleBorder() : null,
        labelPadding: isColor != null ? EdgeInsets.zero : null,
        padding: isColor != null ? EdgeInsets.zero : null,
        backgroundColor:
            isColor != null ? THelperFunctions.getColor(text)! : null,
      ),
    );
  }
}
