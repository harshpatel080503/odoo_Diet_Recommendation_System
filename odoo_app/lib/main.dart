import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:odoo_app/provider/rec_provider.dart';
import 'package:odoo_app/provider/recip.dart';
import 'package:odoo_app/screen/admin.dart';
import 'package:odoo_app/screen/homescreen.dart';
import 'package:odoo_app/screen/itme.dart';
import 'package:odoo_app/screen/serach_recp.dart';
import 'package:odoo_app/screen/login.dart';
import 'package:odoo_app/screen/user.dart';
import 'package:odoo_app/utils/firebase_options.dart';
import 'package:odoo_app/provider/Login_provider.dart';
import 'package:odoo_app/provider/homepage_provider.dart';
import 'package:odoo_app/utils/theme/color_theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Gemini.init(apiKey: 'AIzaSyCcLWJMgkqSXzYNF_ND9qWY1RIhiHYUDKU');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  await Hive.openBox('diet');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => LoginProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => RecProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => SearchProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => SignupProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData(
            colorScheme: flexSchemeDark,
            useMaterial3: true,
          ),
          theme: ThemeData(
            colorScheme: flexSchemeLight,
            useMaterial3: true,
          ),
          themeMode: ThemeMode.light,
          home: const Gate(),
        ));
  }
}

class Gate extends StatefulWidget {
  const Gate({super.key});

  @override
  State<Gate> createState() => _GateState();
}

class _GateState extends State<Gate> {
  @override
  Widget build(BuildContext context) {
    bool check() {
      bool login = Hive.box("diet").get("login") ?? false;

      if (login == true) {
        return true;
      } else {
        return false;
      }
    }

    bool admin() {
      bool login = Hive.box("diet").get("admin") ?? false;

      if (login == true) {
        return true;
      } else {
        return false;
      }
    }

    if (check() == true) {
      if (admin() == true) {
        return AdminPage();
      } else {
        return HomePage();
      }
      // return const HomePage();
    } else {
      return const LoginPage();
    }
  }
}
