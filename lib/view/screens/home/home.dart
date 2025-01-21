import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:installed_apps/app_info.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:parental_control_app/constants/app_colors.dart';
import 'package:parental_control_app/constants/app_styling.dart';
import 'package:parental_control_app/model/app_information.dart';
import 'package:parental_control_app/model/parent.dart';
import 'package:parental_control_app/view/screens/Details/app_usage_details.dart'; // Updated import
import 'package:parental_control_app/view/widget/Custom_text_widget.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:usage_stats/usage_stats.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title, required this.isParent});
  final String title;
  final bool isParent;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Location location = new Location();

  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;
  bool isSearchClicked = false;
  String? userId;
  UsageInfo? appUsageInfo;
  List<AppInformation> appInformations = [];
  String? docId;
  Parent? parent;
  @override
  void initState() {
    super.initState();
    parent = Parent('', '', '', '', [], '', '', '');
    getCurrentUser();
    getLocationDetails();
    getAllInstalledApps();
  }

  getCurrentUser() async {
    var user = await FirebaseAuth.instance.currentUser;
    print("UID OF THE PARENT ${user!.uid}");
    setState(() {
      parent!.userID = user.uid;
      docId = user.uid;
    });
  }

  getAllInstalledApps() async {
    appInformations = [];
    List<AppInfo> apps = await InstalledApps.getInstalledApps();

    print("LENGTH OF APPS: ${apps.length}");
    if (apps.isNotEmpty) {
      for (var element in apps) {
        AppInformation appInfo =
            AppInformation(element.name, element.packageName, "", "");
        setState(() {
          appInformations.add(appInfo);
        });
      }
    }
    setState(() {
      parent!.appInformations = appInformations;
    });
    print("LENGTH OF THE APP INFORMATION ${appInformations.length}");
    print("DOCID OF THE PARENT $docId");
    await updateParentInformation(docId!);
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
    await location.getLocation().then((value) {
      setState(() {
        _locationData = value;
        parent!.latitude = value.latitude.toString();
        parent!.longitude = value.longitude.toString();
      });
    });
    //_locationData = await location.getLocation();
    print(
        "DEVICE LOCATION LAT: ${_locationData!.latitude} : LONG ${_locationData!.longitude}");
  }

  updateParentInformation(String docID) async {
    await FirebaseFirestore.instance.collection("parents").doc(docID).update({
      "latitude": _locationData!.latitude,
      "longitude": _locationData!.longitude,
      "appInformations": appInformations.map((e) => e.toJSON()).toList(),
    }
        // {"appInformations": appInformations.map((e) => e.toJSON()).toList()}
        );
  }

  Future<String> checkParentCode(String parentCode) async {
    return await FirebaseFirestore.instance
        .collection("parents")
        .where('parentCode', isEqualTo: parentCode)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return parentCode;
      }
      return parentCode;
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
              text: widget.title,
              color: kSecondaryColor,
              size: 20,
              weight: FontWeight.bold,
            ),
          ),
          leading: Container(),
          actions: [
            IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.logout),
              color: kSecondaryColor,
            )
          ],
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: FlutterMap(
                      options: MapOptions(
                        initialCenter: _locationData != null
                            ? LatLng(_locationData!.latitude!,
                                _locationData!.longitude!)
                            : LatLng(0.0,
                                0.0), // Fallback to a default location if null
                        minZoom: 5,
                        maxZoom: 15,
                      ),
                      children: <Widget>[
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        ),
                        MarkerClusterLayerWidget(
                          options: MarkerClusterLayerOptions(
                            maxClusterRadius: 45,
                            size: const Size(40, 40),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(50),
                            maxZoom: 15,
                            markers: [
                              Marker(
                                  point: _locationData != null
                                      ? LatLng(_locationData!.latitude!,
                                          _locationData!.longitude!)
                                      : LatLng(0.0,
                                          0.0), // Fallback to default if null
                                  child: Container(
                                      height: h(context, 80),
                                      width: w(context, 80),
                                      child: Icon(Icons.location_on,
                                          color: Colors.deepPurple)))
                            ],
                            builder: (context, markers) {
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.blue),
                                child: Center(
                                  child: Text(
                                    markers.length.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )),
                ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.5),
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
                            //   final app = apps[index];
                            return GestureDetector(
                              onTap: () async {
                                await FirebaseFirestore.instance
                                    .collection("users_parental_controll")
                                    .add({'appName': apps[index].name});
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return AppUsageDetails(
                                      application: apps[index]);
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
                                    leading: (apps[index] as AppInfo).icon !=
                                                null &&
                                            (apps[index] as AppInfo)
                                                .icon!
                                                .isNotEmpty
                                        ? Image.memory(
                                            (apps[index] as AppInfo).icon!,
                                            width: 48, // Set desired dimensions
                                            height: 48,
                                            fit: BoxFit.cover,
                                          )
                                        : Container(
                                            width: 48,
                                            height: 48,
                                            color: Colors
                                                .grey, // Placeholder color
                                            child: Icon(
                                              Icons.apps, // Placeholder icon
                                              color: Colors.white,
                                            ),
                                          ),
                                    title: SizedBox(
                                      width: w(context, 180),
                                      child: CustomText(
                                        text:
                                            "${(apps[index] as AppInfo).name}",
                                        size: 16,
                                        weight: FontWeight.bold,
                                      ),
                                    ),
                                    trailing: IconButton(
                                      onPressed: () async {
                                        try {
                                          final app = apps[index]
                                              as AppInfo; // Type safety
                                          await InstalledApps.startApp(
                                              app.packageName);
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
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
                ),
              ],
            ),
          ),
        ));
  }
}
