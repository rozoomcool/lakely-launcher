import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ClockWidget extends StatelessWidget {
  const ClockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: (context, snapshot) {
        var time = DateTime.now();
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8,
          children: [
            Text(
              DateFormat('HH:mm').format(time),
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(fontFamily: GoogleFonts.sixtyfour().fontFamily),
            ),
            Text(DateFormat('EEE, dd MMM yyyy').format(time),
                style: Theme.of(context).textTheme.headlineSmall),
          ],
        );
      },
    );
  }
}
