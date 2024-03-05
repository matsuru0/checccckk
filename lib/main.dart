import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_prototype/features/appointement_screen/view/appointement_screen.dart';
import 'package:table_prototype/features/ordonnance_screen/view/ordonnance_screen.dart';
import 'package:table_prototype/features/patients_screen/repository/clients_repo.dart';
import 'package:table_prototype/features/patients_screen/view/patient_screen.dart';
import 'package:table_prototype/features/settings_screen/view/settings_screen.dart';
import 'package:table_prototype/models/client_model.dart';

import 'package:table_prototype/features/patients_screen/view/patient_screen.dart';
import 'package:flutter/rendering.dart';
import 'package:table_prototype/theme/pallete.dart';

import 'core/common/left_bar.dart';
import 'package:context_menus/context_menus.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  // debugPaintSizeEnabled = true;
  /*WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    title: 'YOO',
    minimumSize: Size(800, 600),
    center: true,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });*/
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Med plus',
        theme: ThemeData(
          fontFamily: 'Inter0',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: ContextMenuOverlay(child: HomePage()),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;
  void setSelectedIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  // GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isDrawerOpen = false;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenHeight = mediaQueryData.size.height;
    double screenWidth = mediaQueryData.size.width;
    //print(screenWidth);
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = PatientScreen(setSelectedIndex);

        break;
      case 1:
        page = AppointementScreen(setSelectedIndex);
        break;
      case 2:
        page = OrdonnanceScreen(null, null);
        break;
      case 3:
        page = Text('case 3');
        break;

      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return Scaffold(
        key: _key,
        floatingActionButton: screenWidth < 1000
            ? FloatingActionButton(
                onPressed: () {
                  _key.currentState!.openDrawer();
                },
                child: Icon(Icons.menu),
              )
            : null,
        drawer: screenWidth < 1000
            ? Drawer(child: LeftBar(setSelectedIndex, selectedIndex))
            : null,
        body: Center(
          child: Row(children: [
            screenWidth >= 1000
                ? LeftBar(setSelectedIndex, selectedIndex)
                : SizedBox(),
            Expanded(
                child: Container(
                    padding: EdgeInsets.only(
                        top: 50, right: 70, left: 70, bottom: 50),
                    color: Pallete.bgColor,
                    child: page))
          ]),
        ));
  }
}
