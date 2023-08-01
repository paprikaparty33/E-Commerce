import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:kpop_shop/services/admin_service.dart';
import 'package:kpop_shop/utils/dimensions.dart';
import 'package:kpop_shop/helper/error_handling.dart';
import 'package:kpop_shop/utils/image_picker.dart';
import 'package:kpop_shop/pages/add_del_edit_product/add_product_text_field.dart';

import '../../utils/colors.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';

  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  final AdminService adminService = AdminService();
  String status = 'Pre-order';
  String location = 'KR';
  String category = 'Albums';
  bool isNewArrival = true;
  bool isPopular = true;
  List<File> productImages = [];
  final _addProductFormKey = GlobalKey<FormState>();

  // @override
  // void dispose() {
  //   super.dispose();
  //   productNameController.dispose();
  //   descriptionController.dispose();
  //   priceController.dispose();
  //   quantityController.dispose();
  // }

  List<String> productStatus = ['Pre-order', 'In stock', 'Sold out'];
  List<String> productLocation = ['KR', 'RU'];
  List<String> productCategory = ['Albums', 'Photocards', 'Merch'];


  void selectImages() async{
    var res = await pickImages();
    setState(() {
      productImages = res;
    });
  }

  void sellProduct(){
    if(_addProductFormKey.currentState!.validate() && productImages.isNotEmpty){
      adminService.sellProduct(context: context,
          name: productNameController.text,
          description: descriptionController.text,
          price: double.parse(priceController.text),
          quantity: double.parse(quantityController.text),
          location: location,
          status: status,
          images: productImages,
          isNewArrival: isNewArrival,
          isPopular:  isPopular,
      category: category);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        // Positioned(
        //     left: Dimensions.width20,
        //     top: Dimensions.height20 * 1.5,
        //     right: Dimensions.width20,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         AppIcon(icon: Icons.arrow_back_ios_new),
        //         SizedBox(
        //           width: Dimensions.width45 * 4,
        //         ),
        //         AppIcon(icon: Icons.home_outlined),
        //       ],
        //     )),
        Positioned(
          left: Dimensions.width20,
          top: Dimensions.height40 ,
          right: Dimensions.width20,
          bottom: 0,
          child: SingleChildScrollView(
            child: Form(
              key: _addProductFormKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    productImages.isNotEmpty
                        ? CarouselSlider(
                            items: productImages.map(
                              (i) {
                                return Builder(
                                  builder: (BuildContext context) => Image.file(
                                    i,
                                    fit: BoxFit.cover,
                                    height: 200,
                                  ),
                                );
                              },
                            ).toList(),
                            options: CarouselOptions(
                              viewportFraction: 1,
                              height: 200,
                            ),
                          )
                        : GestureDetector(
                            onTap: selectImages,
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(10),
                              dashPattern: const [10, 4],
                              strokeCap: StrokeCap.round,
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.folder_open,
                                      size: 40,
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      'Select Product Images',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    SizedBox(height: Dimensions.height20),
                    AddProductTextField(
                      textEditingController: productNameController,
                      hintText: 'Product Name',
                    ),
                    SizedBox(height: Dimensions.height10),
                    AddProductTextField(
                      textEditingController: descriptionController,
                      hintText: 'Description',
                      maxLines: 7,
                    ),
                    SizedBox(height: Dimensions.height10),
                    AddProductTextField(
                      textEditingController: priceController,
                      hintText: 'Price',
                    ),
                    SizedBox(height: Dimensions.height10),
                    AddProductTextField(
                      textEditingController: quantityController,
                      hintText: 'Quantity',
                    ),
                    SizedBox(height: Dimensions.height20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //SizedBox(width: Dimensions.height20),
                        DropdownButton(
                          value: status,
                          icon: const Icon(Icons.arrow_drop_down_rounded),
                          items: productStatus
                              .map((String item) =>
                                  DropdownMenuItem(
                                      value: item,
                                      child:BigText(text: item, size: 15,)))
                              .toList(),
                          onChanged: (String? statusVal){
                            setState(() {
                              status = statusVal!;
                            });
                          },
                        ),
                       // SizedBox(width: Dimensions.height40),
                        DropdownButton(
                          value: location,
                          icon: const Icon(Icons.arrow_drop_down_rounded),
                          items: productLocation
                              .map((String item) =>
                              DropdownMenuItem(
                                  value: item,
                                  child: BigText(text: item, size: 15,)))
                              .toList(),
                          onChanged: (String? locationVal){
                            setState(() {
                              location = locationVal!;
                            });
                          },
                        ),
                       // SizedBox(width: Dimensions.height40),
                        DropdownButton(
                          value: category,
                          icon: const Icon(Icons.arrow_drop_down_rounded),
                          items: productCategory
                              .map((String item) =>
                              DropdownMenuItem(
                                  value: item,
                                  child: BigText(text: item, size: 15,)))
                              .toList(),
                          onChanged: (String? categoryVal){
                            setState(() {
                              category = categoryVal!;
                            });
                          },
                        ),

                      ],),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                           // SizedBox(width: Dimensions.width20,),
                            BigText(text: 'Add to Popular', size: 15,),
                            Checkbox(
                              activeColor: AppColors.mainColor,
                                value: isPopular, onChanged: (newBool){

                              setState(() {
                                isPopular = newBool ?? false;
                                //productImages = [];
                              });


                            }),
                            SizedBox(width: Dimensions.width15,),
                            BigText(text: 'Add to NewArrival', size: 15,),

                            Checkbox(

                                activeColor: AppColors.mainColor,
                                value: isNewArrival, onChanged: (newBool){

                              setState(() {
                                isNewArrival = newBool ?? false;
                              });


                            }),
                          ],
                        ),
                    ElevatedButton(
                      onPressed: () {
                        sellProduct();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius30),
                        ),
                        minimumSize: Size(
                          Dimensions.screenWidth * 0.5,
                          Dimensions.screenHeight / 12,
                        ),
                      ),
                      child: BigText(
                        text: 'Sell',
                        size: Dimensions.font20 * 1.5,
                      ),
                    ),
                    SizedBox(height: Dimensions.height20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
