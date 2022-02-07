import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked_services/stacked_services.dart';

import 'enums/toast_type.dart';
import 'locator.dart';
import 'ui/shared/app_colors.dart';

void setupSnackbarUi() {
  final service = locator<SnackbarService>();

  // Failed case
  service.registerCustomSnackbarConfig(
      variant: ToastType.failed,
      config: SnackbarConfig(
        backgroundColor: kcError,
        icon: SvgPicture.asset(
          'packages/testsweets/assets/svgs/fail.svg',
          width: 15,
          color: kcPrimaryWhite,
        ),
        textColor: kcPrimaryWhite,
      ));

  // Success case
  service.registerCustomSnackbarConfig(
      variant: ToastType.success,
      config: SnackbarConfig(
        backgroundColor: kcGreen,
        icon: SvgPicture.asset(
          'packages/testsweets/assets/svgs/pass.svg',
          width: 15,
          color: kcPrimaryWhite,
        ),
        shouldIconPulse: true,
        textColor: kcPrimaryWhite,
      ));
}
