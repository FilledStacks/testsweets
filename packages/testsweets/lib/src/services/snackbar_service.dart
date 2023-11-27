import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:testsweets/src/enums/toast_type.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';

class SnackbarService {
  late BuildContext _context;

  // TODO (Refactor): Remove this setup, we're only doing this to move
  // fast and get a fix out for the snackbar failure
  void setBuildContext(BuildContext context) {
    _context = context;
  }

  void showCustomSnackBar({
    required String message,
    required SnackbarType variant,
  }) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          SvgPicture.asset(
            variant.snackIcon,
            width: 15,
            theme: SvgTheme(currentColor: kcPrimaryWhite),
          ),
          Text(message, style: TextStyle(color: kcPrimaryWhite)),
        ],
      ),
      backgroundColor: variant.snackColor,
    );

    ScaffoldMessenger.of(_context).showSnackBar(snackBar);
  }
}
