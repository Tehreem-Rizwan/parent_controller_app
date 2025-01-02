import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';
import 'package:intl/intl.dart';
import 'package:parental_control_app/constants/app_colors.dart';
import 'package:parental_control_app/constants/app_styling.dart';
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
    DateTime endDate = DateTime.now();
    DateTime startDate =
        DateTime(endDate.year, endDate.month, endDate.day, 0, 0, 0);

    try {
      List<UsageInfo> usageStats =
          await UsageStats.queryUsageStats(startDate, endDate);

      if (usageStats.isNotEmpty) {
        for (var element in usageStats) {
          if (element.packageName == widget.application.packageName) {
            setState(() {
              appUsageInfo = element;
            });
            break;
          }
        }
      }

      if (appUsageInfo == null) {
        setState(() {
          errorMessage = "No usage data found for this application.";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error fetching usage data: $e";
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getUsage();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
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
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (errorMessage.isNotEmpty) {
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
        body: Center(
          child: CustomText(
            text: errorMessage,
            size: 16,
            color: Colors.red,
          ),
        ),
      );
    }

    if (appUsageInfo == null) {
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
        body: Center(
          child: CustomText(
            text: "No usage information available.",
            size: 16,
            color: Colors.grey,
          ),
        ),
      );
    }

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
      body: Column(
        children: [
          SizedBox(height: h(context, 15)),
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
          SizedBox(height: h(context, 10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 180,
                child: CustomText(
                  text: "Last Used Time: ",
                  color: kRedColor,
                  size: 18,
                  weight: FontWeight.bold,
                ),
              ),
              SizedBox(height: h(context, 10)),
              Container(
                width: 180,
                child: CustomText(
                  text: appUsageInfo!.lastTimeUsed != null
                      ? "${DateFormat('dd-MM-yyyy hh:mm:ss').format(DateTime.fromMillisecondsSinceEpoch(int.parse(appUsageInfo!.lastTimeUsed!)))}"
                      : "N/A",
                  size: 18,
                  weight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
