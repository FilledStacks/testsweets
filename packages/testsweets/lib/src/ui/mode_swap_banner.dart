import 'package:flutter/material.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';

class ModeSwapBanner extends StatelessWidget {
  final Function(bool) onCaptureMode;
  final Function()? onClosePressed;
  final bool captureModeActive;
  final bool showRestartMessage;
  const ModeSwapBanner({
    Key? key,
    required this.onCaptureMode,
    required this.captureModeActive,
    required this.onClosePressed,
    this.showRestartMessage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 15),
            decoration: BoxDecoration(
              color: kcBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: onClosePressed,
                    child: Container(
                      margin: const EdgeInsets.only(right: 10, top: 10),
                      decoration: BoxDecoration(
                        color: kcSubtext,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 4),
                      child:
                          Text('Close', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: _ModeSwapButton(
                        onModeTapped: () => onCaptureMode(true),
                        title: 'Capture',
                        active: captureModeActive,
                      ),
                    ),
                    Expanded(
                      child: _ModeSwapButton(
                        onModeTapped: () => onCaptureMode(false),
                        title: 'Automation',
                        active: !captureModeActive,
                      ),
                    ),
                  ],
                ),
                if (showRestartMessage) ...[
                  Text(
                    'Close the app for the change to take affect',
                    style: tsSmall().copyWith(color: kcSubtext),
                  ),
                  SizedBox(height: 10),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ModeSwapButton extends StatelessWidget {
  final String title;
  final bool active;
  final Function() onModeTapped;

  const _ModeSwapButton({
    required this.onModeTapped,
    required this.title,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onModeTapped(),
      child: Container(
        height: 45,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: active ? kcPrimaryPurple : kcSubtext,
            borderRadius: BorderRadius.circular(6)),
        child: Text(
          title,
          style: tsNormalBold().copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
