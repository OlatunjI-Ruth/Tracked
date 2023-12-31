import 'package:flutter/material.dart';
import 'package:tracked/screens/auth/signup.dart';
import 'package:tracked/screens/task_view/task_list_view.dart';
import 'package:tracked/screens/startup_view/startupview.dart';
import 'package:tracked/services/dialog_service.dart';
import 'package:tracked/services/navigation_service.dart';
import 'package:tracked/constants/route_names_asigning.dart';
import 'package:tracked/utils/dialog_manager.dart';
import 'package:tracked/utils/locator_setup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'router_generated_routes.dart' as router;

 Future main() async{
    WidgetsFlutterBinding.ensureInitialized();
    setupLocator();
    await Firebase.initializeApp();
  runApp( const Tracked());
}

class Tracked extends StatefulWidget {
  const Tracked({super.key});

  @override
  State<Tracked> createState() => _TrackedState();
}

class _TrackedState extends State<Tracked> {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tracked',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      builder: (context, child)=>Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings)=>MaterialPageRoute(builder: (context)=>DialogManager(child: child)),
      ),
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: router.Router.generateRoute,
      initialRoute: startupRoute,
       // onGenerateRoute: (RouteSettings){},
    );
  }  
}



