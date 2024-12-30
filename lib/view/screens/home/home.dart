import 'package:flutter/material.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:installed_apps/app_info.dart';
import 'package:parental_control_app/constants/app_colors.dart';
import 'package:parental_control_app/constants/app_styling.dart';
import 'package:parental_control_app/view/widget/Custom_text_widget.dart';
import 'dart:typed_data';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<AppInfo> apps = [];

  @override
  void initState() {
    super.initState();
    getAllInstalledApps();
  }

  Future<void> getAllInstalledApps() async {
    try {
      List<AppInfo> installedApps = await InstalledApps.getInstalledApps();
      setState(() {
        apps = installedApps;
      });
      print("LENGTH OF APPS: ${installedApps.length}");
    } catch (e) {
      print("Error fetching installed apps: $e");
    }
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
      body: apps.isEmpty
          ? Center(
              child: CustomText(
                text: "No installed apps found on your device.",
                size: 16,
                color: Colors.grey,
              ),
            )
          : ListView.builder(
              itemCount: apps.length,
              itemBuilder: (context, index) {
                final app = apps[index];
                Uint8List? iconData;
                try {
                  iconData = app.icon;
                } catch (e) {
                  iconData = null;
                }
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(
                    height: h(context, 65),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: kBeigeColor,
                    ),
                    child: Center(
                      child: ListTile(
                        leading: iconData != null
                            ? Image.memory(
                                iconData,
                                width: 40,
                                height: 40,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.android,
                                    size: 40,
                                    color: Colors.grey,
                                  );
                                },
                              )
                            : Icon(
                                Icons.android,
                                size: 40,
                                color: Colors.grey,
                              ),
                        title: CustomText(
                          text: app.name,
                          size: 16,
                          weight: FontWeight.bold,
                        ),
                        trailing: IconButton(
                          onPressed: () async {
                            try {
                              await InstalledApps.startApp(app.packageName);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
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
                );
              },
            ),
    );
  }
}
