import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const List<String> reasons = [
  'adult',
  'harm',
  'bully',
  'spam',
  'copyright',
  'hate'
];

class ClaimBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...reasons.map((reason) => Material(
          child: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              child: Center(
                child: Text(reason.toUpperCase()),
              ),
            ),
          ),
        ))
      ],
    );
  }
}
