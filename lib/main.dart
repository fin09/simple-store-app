import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:store_app/providers/product_provider.dart';
import 'package:store_app/providers/theme_provider.dart';
import 'package:store_app/screens/home_page.dart';
import 'package:store_app/screens/update_prodect_page.dart';
import 'package:store_app/theme/app_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: Provider.of<ThemeProvider>(context).themeMode,
          home: const HomePage(),
          routes: {
            HomePage.id: (context) => const HomePage(),
            UpdateProductPage.id: (context) => UpdateProductPage(),
          },
        );
      },
    );
  }
}
