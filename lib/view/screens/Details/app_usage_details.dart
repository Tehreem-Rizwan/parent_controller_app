import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';
import 'package:parental_control_app/constants/app_colors.dart';
import 'package:parental_control_app/view/widget/Custom_text_widget.dart';
import 'package:usage_stats/usage_stats.dart';

class AppUsageDetails extends StatefulWidget {
  final AppInfo application;

  const AppUsageDetails({super.key, required this.application});

  @override
  State<AppUsageDetails> createState() => _AppUsageDetailsState();
}

class _AppUsageDetailsState extends State<AppUsageDetails> {
  UsageInfo? appUsageInfo;
  bool isLoading = true;
  String errorMessage = '';

  Future<void> getUsage() async {
    try {
      DateTime endDate = DateTime.now();
      DateTime startDate =
          DateTime(endDate.year, endDate.month, endDate.day, 0, 0, 0);

      // Request permission
      await UsageStats.grantUsagePermission();

      // Check if permission is granted
      bool isPermissionGranted =
          await UsageStats.checkUsagePermission() ?? false;

      if (!isPermissionGranted) {
        setState(() {
          errorMessage = "Usage permission not granted.";
          isLoading = false;
        });
        return;
      }

      // Fetch usage stats
      List<UsageInfo> usageStats =
          await UsageStats.queryUsageStats(startDate, endDate);

      // Find the specific app's usage
      UsageInfo? usageInfo = usageStats.firstWhere(
        (info) => info.packageName == widget.application.packageName,
        orElse: () => UsageInfo(totalTimeInForeground: "0"),
      );

      // Simulate loading for 3 seconds
      await Future.delayed(const Duration(seconds: 3));

      setState(() {
        appUsageInfo = usageInfo;
        isLoading = false;
      });
    } catch (e) {
      await Future.delayed(const Duration(seconds: 3));
      setState(() {
        errorMessage = "Error fetching usage data: $e";
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUsage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kTealColor,
        title: CustomText(
          text: widget.application.name,
          color: Colors.white,
          size: 20,
          weight: FontWeight.bold,
        ),
      ),
      backgroundColor: kSecondaryColor,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(
                  child: CustomText(
                    text: errorMessage,
                    size: 16,
                    color: Colors.red,
                  ),
                )
              : appUsageInfo != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 180,
                              child: CustomText(
                                text: "Screen Time: ",
                                color: kRedColor,
                                size: 18,
                                weight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 180,
                              child: CustomText(
                                text:
                                    "${(int.parse(appUsageInfo!.totalTimeInForeground ?? "0") / 1000 / 60).toStringAsFixed(2)} min:sec",
                                size: 18,
                                weight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Center(
                      child: CustomText(
                        text: "No usage data available.",
                        size: 16,
                        color: Colors.grey,
                      ),
                    ),
    );
  }
}
