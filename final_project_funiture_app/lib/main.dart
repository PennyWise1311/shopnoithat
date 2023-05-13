import 'package:final_project_funiture_app/provider/banner_provider.dart';
import 'package:final_project_funiture_app/provider/category_provider.dart';
import 'package:final_project_funiture_app/provider/country_city_provider.dart';
import 'package:final_project_funiture_app/provider/order_provider.dart';
import 'package:final_project_funiture_app/provider/product_provider.dart';
import 'package:final_project_funiture_app/provider/user_provider.dart';
import 'package:final_project_funiture_app/screens/home.dart';
import 'package:final_project_funiture_app/services/DatabaseHandler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DatabaseHandler handler = DatabaseHandler();
  handler.initializeDB();
  //Stripe.publishableKey = stripePublishableKey;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryProvider>(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider<BannerProvider>(
          create: (context) => BannerProvider(),
        ),
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider<CountryCityProvider>(
          create: (context) => CountryCityProvider(),
        ),
        ChangeNotifierProvider<OrderProvider>(
          create: (context) => OrderProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Furniture App',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xfff2f9fe),
          textTheme: GoogleFonts.dmSansTextTheme().apply(displayColor: Colors.black),
          primaryColor: const Color(0xff410000),
          iconTheme: const IconThemeData(color: Colors.white),
          visualDensity: VisualDensity.adaptivePlatformDensity,

          appBarTheme: const AppBarTheme(
            color: Colors.transparent,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),

        ),
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}
