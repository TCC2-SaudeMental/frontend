import 'package:flutter/material.dart';
import 'package:flash/flash.dart';

void showErrorFlash(
  String message,
  BuildContext context, {
  bool persistent = true,
  EdgeInsets margin = EdgeInsets.zero,
}) {
  showFlash(
    context: context,
    persistent: persistent,
    builder: (_, controller) {
      return Flash(
        controller: controller,
        margin: margin,
        behavior: FlashBehavior.fixed,
        position: FlashPosition.bottom,
        borderRadius: BorderRadius.circular(8.0),
        borderColor: Colors.black,
        boxShadows: kElevationToShadow[8],
        onTap: () => controller.dismiss(),
        forwardAnimationCurve: Curves.easeInCirc,
        reverseAnimationCurve: Curves.bounceIn,
        child: DefaultTextStyle(
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          child: FlashBar(
            content: Text(message),
            indicatorColor: Colors.red,
            icon: Icon(Icons.info_outline),
            primaryAction: TextButton(
              onPressed: () => controller.dismiss(),
              child: Text('DISMISS'),
            ),
          ),
        ),
      );
    },
  );
}

void showSuccessFlash(
  String message,
  BuildContext context, {
  bool persistent = true,
  EdgeInsets margin = EdgeInsets.zero,
}) {
  showFlash(
    context: context,
    persistent: persistent,
    builder: (_, controller) {
      return Flash(
        controller: controller,
        margin: margin,
        behavior: FlashBehavior.fixed,
        position: FlashPosition.bottom,
        borderRadius: BorderRadius.circular(8.0),
        borderColor: Colors.black,
        boxShadows: kElevationToShadow[8],
        onTap: () => controller.dismiss(),
        forwardAnimationCurve: Curves.easeInCirc,
        reverseAnimationCurve: Curves.bounceIn,
        child: DefaultTextStyle(
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          child: FlashBar(
            content: Text(message),
            indicatorColor: Colors.green,
            icon: Icon(Icons.info_outline),
            primaryAction: TextButton(
              onPressed: () => controller.dismiss(),
              child: Text('DISMISS'),
            ),
          ),
        ),
      );
    },
  );
}
