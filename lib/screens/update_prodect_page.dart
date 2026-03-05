import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/providers/product_provider.dart';
import 'package:store_app/providers/theme_provider.dart';
import 'package:store_app/widget/custom_button.dart';
import 'package:store_app/widget/custom_text_f.dart';

// ignore: must_be_immutable
class UpdateProductPage extends StatefulWidget {
  UpdateProductPage({super.key});
  String? productName, price, image, description, category;
  static const String id = 'update_product';

  @override
  State<UpdateProductPage> createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  bool inAsyncCall = false;

  @override
  Widget build(BuildContext context) {
    ProductModel product =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    return ModalProgressHUD(
      inAsyncCall: inAsyncCall,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Update Product', style: TextStyle(fontSize: 18.sp)),
          actions: [
            IconButton(
              icon: Icon(
                Provider.of<ThemeProvider>(context).isDarkMode
                    ? Icons.light_mode
                    : Icons.dark_mode,
                size: 20.sp,
              ),
              onPressed: () {
                Provider.of<ThemeProvider>(
                  context,
                  listen: false,
                ).toggleTheme();
              },
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextF(
                  inputType: TextInputType.text,
                  text: 'Product Name',
                  onChanged: (data) {
                    widget.productName = data;
                  },
                ),
                SizedBox(height: 10.h),
                CustomTextF(
                  inputType: TextInputType.number,
                  text: 'Product Price',
                  onChanged: (data) {
                    widget.price = data;
                  },
                ),
                SizedBox(height: 10.h),
                CustomTextF(
                  inputType: TextInputType.url,
                  text: 'Product Image',
                  onChanged: (data) {
                    widget.image = data;
                  },
                ),
                SizedBox(height: 10.h),
                CustomTextF(
                  inputType: TextInputType.text,
                  text: 'Product Description',
                  onChanged: (data) {
                    widget.description = data;
                  },
                ),
                SizedBox(height: 10.h),
                CustomTextF(
                  inputType: TextInputType.text,
                  text: 'Category',
                  onChanged: (data) {
                    widget.category = data;
                  },
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  text: 'Update Product',
                  onTap: () async {
                    try {
                      setState(() {
                        inAsyncCall = true;
                      });
                      await updateProduct(product);
                      if (!mounted) return;
                      setState(() {
                        inAsyncCall = false;
                      });
                      Navigator.pop(context);
                    } catch (e) {
                      debugPrint(e.toString());
                      if (!mounted) return;
                      setState(() {
                        inAsyncCall = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Update failed: $e')),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateProduct(ProductModel product) async {
    await Provider.of<ProductProvider>(context, listen: false).updateProduct(
      title: widget.productName ?? product.title,
      price: widget.price ?? product.price.toString(),
      description: widget.description ?? product.description,
      image: widget.image ?? product.image,
      productID: product.id,
      category: widget.category ?? product.category,
    );
  }
}
