import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'shared_styles.dart';

class BusyIndicator extends StatelessWidget {
  final bool center;
  final bool side;
  const BusyIndicator({
    Key? key,
    required this.center,
    this.side = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return side
        ? SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 24,
                height: 24,
                margin: const EdgeInsets.all(8),
                child: CircularProgressIndicator(
                  backgroundColor: kcCard.withOpacity(0.3),
                  valueColor: AlwaysStoppedAnimation(kcPrimaryPurple),
                ),
              ),
            ),
          )
        : center
            ? Container(
                color: kcCard.withOpacity(0.3),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: blackBoxDecoration,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(kcPrimaryPurple),
                    ),
                  ),
                ),
              )
            : const SizedBox();
  }
}
