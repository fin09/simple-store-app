import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:store_app/providers/product_provider.dart';
import 'package:store_app/providers/theme_provider.dart';
import 'package:store_app/screens/update_prodect_page.dart';
import 'package:store_app/widget/custom_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String id = 'home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Fetch products on initial load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page', style: TextStyle(fontSize: 18.sp)),
        actions: [
          IconButton(
            icon: Icon(
              Provider.of<ThemeProvider>(context).isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode,
              size: 20.sp,
            ),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.cartPlus, size: 18.sp),
            onPressed: () {
              Navigator.pushNamed(context, '/add_product');
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 65.h),
        child: Consumer<ProductProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (provider.error != null) {
              return Center(
                child: Text(
                  'Error: ${provider.error}',
                  style: TextStyle(fontSize: 14.sp),
                ),
              );
            } else if (provider.products.isEmpty) {
              return Center(
                child: Text(
                  'No products found',
                  style: TextStyle(fontSize: 14.sp),
                ),
              );
            } else {
              return GridView.builder(
                itemCount: provider.products.length,
                clipBehavior: Clip.none,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 100.h,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        UpdateProductPage.id,
                        arguments: provider.products[index],
                      );
                    },
                    child: CustomCard(product: provider.products[index]),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
