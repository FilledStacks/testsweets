import 'package:flutter/material.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';

import 'app_colors.dart';

class RouteBanner extends StatelessWidget {
  final String routeName;
  final bool isCaptured;
  const RouteBanner(
      {Key? key, required this.routeName, this.isCaptured = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.symmetric(vertical: 4),
          decoration: kdRouteNameDecoration,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 4,
              ),
              Text(
                routeName,
                style: tsSmallBold()
                    .copyWith(color: kcPrimaryWhite.withOpacity(0.7)),
              ),
              Container(
                width: 4,
                height: 4,
                decoration: isCaptured
                    ? BoxDecoration(
                        color: kcError.withOpacity(0.7), shape: BoxShape.circle)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
