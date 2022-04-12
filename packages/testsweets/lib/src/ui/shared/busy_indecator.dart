import 'package:flutter/material.dart';

import 'app_colors.dart';

class BusyIndicator extends StatelessWidget {
  final bool enable;
  const BusyIndicator({Key? key, required this.enable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return enable
        ? SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(kcPrimaryPurple),
                ),
              ),
            ),
          )
        : const SizedBox();
  }
}
