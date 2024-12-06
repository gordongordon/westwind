
import 'package:flutter/material.dart';
import 'package:westwind_flutter/features/dashboard/const/constant.dart';
import 'package:westwind_flutter/features/dashboard/widgets/pie_chart_widget.dart';
import 'package:westwind_flutter/features/dashboard/widgets/scheduled_widget.dart';
import 'package:westwind_flutter/features/dashboard/widgets/summary_details.dart';

class SummaryWidget extends StatelessWidget {
  const SummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: cardBackgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: const [
            SizedBox(height: 20),
            Chart(),
            Text(
              'Summary',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            SummaryDetails(),
            SizedBox(height: 40),
            Scheduled(),
          ],
        ),
      ),
    );
  }
}
