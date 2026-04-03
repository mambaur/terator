import 'package:flutter/material.dart';

enum SnackbarType { success, warning, failure }

class CustomSnackbar {
  static void show(BuildContext context,
      {String? title,
      String? message,
      SnackbarType? type,
      Duration? duration}) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.fixed,
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: Offset(0, 2),
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: title == null || message == null
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            Icon(
                type == SnackbarType.success
                    ? Icons.check_circle
                    : type == SnackbarType.warning
                        ? Icons.info
                        : Icons.error_outline,
                color: _color(type)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                // spacing: 4,
                children: [
                  if (title != null)
                    Text(title,
                        style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                  if (message != null)
                    Text(message,
                        style: const TextStyle(
                            color: Colors.black87, fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
      duration: duration ?? const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}

Color _color(SnackbarType? type) {
  return type == SnackbarType.success
      ? Colors.green.shade700
      : type == SnackbarType.warning
          ? Colors.orange
          : Colors.red.shade700;
}

// class CustomSnackbar {
//   static flushbar(BuildContext context,
//       {String? message,
//       SnackbarType? type,
//       FlushbarPosition? position,
//       Widget? mainButton}) {
//     return Flushbar(
//       backgroundColor: Colors.white,
//       // boxShadows: [],
//       boxShadows: [
//         BoxShadow(
//           color: Colors.black.withValues(alpha: 0.2),
//           blurRadius: 7,
//           offset: const Offset(1, 3),
//         )
//       ],
//       margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//       flushbarPosition: position ?? FlushbarPosition.TOP,
//       borderRadius: BorderRadius.circular(10),
//       flushbarStyle: FlushbarStyle.FLOATING,
//       messageColor: Theme.of(context).textTheme.titleLarge?.color,
//       titleColor: Colors.black,
//       mainButton: mainButton,
//       // title: type == SnackbarType.success
//       //     ? 'Berhasil!'
//       //     : type == SnackbarType.warning
//       //         ? 'Peringatan!'
//       //         : 'Oops!',
//       message: message ?? '',
//       icon: Icon(
//         type == SnackbarType.success
//             ? Icons.check_circle_outline
//             : type == SnackbarType.warning
//                 ? Icons.info_outline
//                 : Icons.error_outline,
//         size: 28.0,
//         color: type == SnackbarType.success
//             ? Colors.green.shade700
//             : Colors.red.shade700,
//       ),
//       duration: const Duration(seconds: 3),
//       // leftBarIndicatorColor: type == SnackbarType.success
//       //     ? Colors.green.shade700
//       //     : Colors.red.shade700,
//     )..show(context);
//   }
// }
