import 'package:flutter/material.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:installed_apps/app_info.dart';
import 'package:parental_control_app/constants/app_colors.dart';
import 'package:parental_control_app/constants/app_styling.dart';
import 'package:parental_control_app/view/screens/Details/app_usage_details.dart'; // Updated import
import 'package:parental_control_app/view/widget/Custom_text_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<AppInfo> apps = [];
  bool isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    getAllInstalledApps();
  }

  Future<void> getAllInstalledApps() async {
    setState(() {
      isLoading = true;
      _errorMessage = '';
    });
    try {
      List<AppInfo> installedApps = await InstalledApps.getInstalledApps();
      setState(() {
        apps = installedApps;
      });
      print("LENGTH OF APPS: ${installedApps.length}");
    } catch (e) {
      _errorMessage = "Error fetching installed apps: $e";
      print("Error fetching installed apps: $e");
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        backgroundColor: kTealColor,
        title: Center(
          child: CustomText(
            text: "Screen Time Controller",
            color: kSecondaryColor,
            size: 20,
            weight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _errorMessage.isNotEmpty
              ? Center(
                  child: CustomText(
                    text: _errorMessage,
                    size: 16,
                    color: Colors.grey,
                  ),
                )
              : apps.isEmpty
                  ? Center(
                      child: CustomText(
                        text: "No apps with valid icons found on your device.",
                        size: 16,
                        color: Colors.grey,
                      ),
                    )
                  : ListView.builder(
                      itemCount: apps.length,
                      itemBuilder: (context, index) {
                        final app = apps[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return AppUsageDetails(
                                application: apps[index],
                              );
                            }));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: h(context, 60),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: kBeigeColor,
                              ),
                              child: Center(
                                child: ListTile(
                                  leading: apps[index].icon != null
                                      ? Image.memory(
                                          apps[index].icon!,
                                          width: w(context, 40),
                                          height: h(context, 40),
                                          fit: BoxFit.contain,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const Icon(Icons.android,
                                                size: 40);
                                          },
                                        )
                                      : const Icon(Icons.android, size: 40),
                                  title: CustomText(
                                    text: "${apps[index].name}",
                                    size: 16,
                                    weight: FontWeight.bold,
                                  ),
                                  trailing: IconButton(
                                    onPressed: () async {
                                      try {
                                        await InstalledApps.startApp(
                                            apps[index].packageName);
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Could not open ${app.name}',
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    icon: const Icon(Icons.open_in_new),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}
