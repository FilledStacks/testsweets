import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:testsweets/src/ui/shared/animation_rotation.dart' as ar;

class FormHeader extends StatelessWidget {
  final Stream<bool> openBottomSheet;
  const FormHeader({
    Key? key,
    required this.openBottomSheet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SvgPicture.asset(
          'packages/testsweets/assets/svgs/eclipse.svg',
        ),
        StreamBuilder<bool>(
            stream: openBottomSheet,
            builder: (context, snapshot) {
              return ar.AnimatedRotation(
                duration: const Duration(milliseconds: 350),
                angle: snapshot.data ?? false ? 180 : 0,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SvgPicture.asset(
                    'packages/testsweets/assets/svgs/arrow_up.svg',
                  ),
                ),
              );
            }),
      ],
    );
  }
}
