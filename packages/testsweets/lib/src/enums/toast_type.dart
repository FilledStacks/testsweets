import 'dart:ui';

import 'package:testsweets/src/ui/shared/app_colors.dart';

enum SnackbarType {
  success(
    snackColor: kcGreen,
    snackIcon: 'packages/testsweets/assets/svgs/pass.svg',
  ),
  failed(
    snackColor: kcError,
    snackIcon: 'packages/testsweets/assets/svgs/fail.svg',
  ),
  info(
    snackColor: kcCard,
    snackIcon: 'packages/testsweets/assets/svgs/info.svg',
  );

  const SnackbarType({
    required this.snackColor,
    required this.snackIcon,
  });

  final Color snackColor;
  final String snackIcon;
}
