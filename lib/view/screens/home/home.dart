import 'package:flutter/material.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:installed_apps/app_info.dart';
import 'package:location/location.dart';
import 'package:parental_control_app/constants/app_colors.dart';
import 'package:parental_control_app/constants/app_styling.dart';
import 'package:parental_control_app/view/screens/Details/app_usage_details.dart'; // Updated import
import 'package:parental_control_app/view/widget/Custom_text_widget.dart';
import 'package:usage_stats/usage_stats.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});
  final String title;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Location location = new Location();

  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;
  @override
  void initState() {
    super.initState();
    getLocationDetails();
    getAllInstalledApps();
  }

  getAllInstalledApps() async {
    // Grant usage permission
    await UsageStats.grantUsagePermission();

    // Check if permission is granted
    bool isPermission = await UsageStats.checkUsagePermission() as bool;

    List<AppInfo> apps = await InstalledApps.getInstalledApps();

    print("LENGTH OF APPS: ${apps.length}");
  }

  getLocationDetails() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kSecondaryColor,
        appBar: AppBar(
          backgroundColor: kTealColor,
          title: Center(
            child: CustomText(
              text: widget.title,
              color: kSecondaryColor,
              size: 20,
              weight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          child: FutureBuilder(
              future: InstalledApps.getInstalledApps(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    decoration: BoxDecoration(),
                    child: Text(
                        "We don't have any apps installed on your device."),
                  );
                }
                List<AppInfo> apps = snapshot.data as List<AppInfo>;
                return Container(
                    child: ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: apps.length,
                  itemBuilder: (context, index) {
                    //     final app = apps[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return AppUsageDetails(application: apps[index]);
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
                            leading: (apps[index] as AppInfo).icon != null &&
                                    (apps[index] as AppInfo).icon!.isNotEmpty
                                ? Image.memory(
                                    (apps[index] as AppInfo).icon!,
                                    width: 48, // Set desired dimensions
                                    height: 48,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    width: 48,
                                    height: 48,
                                    color: Colors.grey, // Placeholder color
                                    child: Icon(
                                      Icons.apps, // Placeholder icon
                                      color: Colors.white,
                                    ),
                                  ),
                            title: SizedBox(
                              width: w(context, 180),
                              child: CustomText(
                                text: "${(apps[index] as AppInfo).name}",
                                size: 16,
                                weight: FontWeight.bold,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () async {
                                try {
                                  final app =
                                      apps[index] as AppInfo; // Type safety
                                  await InstalledApps.startApp(app.packageName);
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Could not open ${(apps[index] as AppInfo).name}'), // Safe fallback
                                    ),
                                  );
                                }
                              },
                              icon: const Icon(Icons.open_in_new),
                            ),
                          )),
                        ),
                      ),
                    );
                  },
                ));
              }),
        ));
  }
}
