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
  UsageInfo? appusageInfo;
  getUsage() async {
    DateTime endDate = new DateTime.now();
    DateTime startDate =
        DateTime(endDate.year, endDate.month, endDate.day, 0, 0, 0);

    UsageStats.grantUsagePermission();

    // check if permission is granted
    bool isPermission = UsageStats.checkUsagePermission() as bool;
    // query usage stats
    List<UsageInfo> usageStats =
        await UsageStats.queryUsageStats(startDate, endDate);
    // // query events
    // List<EventUsageInfo> events =
    //     await UsageStats.queryEvents(startDate, endDate);

    // query eventStats API Level 28
    // List<EventInfo> eventStats =
    //     await UsageStats.queryEventStats(startDate, endDate);

    // // query configurations
    // List<ConfigurationInfo> configurations =
    //     await UsageStats.queryConfiguration(startDate, endDate);

    // // query aggregated usage statistics
    // Map<String, UsageInfo> queryAndAggregateUsageStats =
    //     await UsageStats.queryAndAggregateUsageStats(startDate, endDate);

    // // query network usage statistics
    // List<NetworkInfo> networkInfos = await UsageStats.queryNetworkUsageStats(
    //     startDate, endDate,
    //     networkType: NetworkType.all);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kTealColor,
        title: CustomText(
          text: "${widget.application.name}",
          color: kSecondaryColor,
          size: 20,
          weight: FontWeight.bold,
        ),
      ),
      backgroundColor: kSecondaryColor,
      body: Center(
        child: CustomText(
          text: "Details for ${widget.application.name}",
        ),
      ),
    );
  }
}
