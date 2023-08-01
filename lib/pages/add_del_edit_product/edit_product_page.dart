import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kpop_shop/services/admin_service.dart';
import 'package:kpop_shop/utils/dimensions.dart';
import 'package:kpop_shop/pages/add_del_edit_product/add_product_text_field.dart';
import '../../models/album_model.dart';
import '../../utils/colors.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class EditProductScreen extends StatefulWidget {
  static const String routeName = '/edit-product';
  final Album album;

  const EditProductScreen({Key? key, required this.album}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  late TextEditingController productNameController;
  late TextEditingController descriptionController;
 late TextEditingController priceController;
  late TextEditingController quantityController;
  final _editProductFormKey = GlobalKey<FormState>();

  late Album _album;
  final AdminService adminService = AdminService();

  String status = 'Pre-order';
  String location = 'KR';
  String category = 'Albums';

  bool isNewArrival = true;
  bool isPopular = true;



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


  @override
  void initState() {
    productNameController = TextEditingController(text: widget.album.name);
    descriptionController = TextEditingController(text: widget.album.description);
    priceController = TextEditingController(text: widget.album.price.toString());
    quantityController = TextEditingController(text: widget.album.quantity.toString());
    _album = widget.album;
    super.initState();
  }

  void updateProduct() {
    if (_editProductFormKey.currentState!.validate()) {
      adminService.updateProduct(
          context: context,
          name: productNameController.text,
          description: descriptionController.text,
          price: double.parse(priceController.text),
          quantity: double.parse(quantityController.text),
          location: location,
          status: status,
          images: _album.images,
          isNewArrival: isNewArrival,
          isPopular: isPopular,
          category: category,
          id: _album.id!);
    }
  }

  void deleteProduct(){
    adminService.deleteProduct(context: context, album: _album);
//TODO: ДОБАВЬ ФУНКЦИЮ ОН СУКЕС. ПЕРЕДАВАЙ ИНДЕКС С ПРЕДЫДУЩЕЙ ПЕЙДЖ ЧТОБЫ ИЗ БИЛДЕРА УБРАТЬ
  //16.14.42
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(children: [
        Positioned(
            left: Dimensions.width20,
            top: Dimensions.height20 * 1.2,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: (){ Navigator.pop(context);},
                    child: AppIconButton(icon: Icons.arrow_back_ios_new, onPressed: (){Navigator.of(context).pop();},)),
                SizedBox(
                  width: Dimensions.width45 * 4,
                ),
                TextButton(
                    onPressed: ()=>deleteProduct(),
                    child: AppIconButton(icon: Icons.delete_outline, onPressed: (){
                      adminService.deleteProduct(context: context, album: _album);
                    },)),
              ],
            )),
        Positioned(
          left: Dimensions.width20,
          top: Dimensions.height45*1.5,
          right: Dimensions.width20,
          bottom: 0,
          child: SingleChildScrollView(
            child: Form(
              key: _editProductFormKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    CarouselSlider(
                      items: widget.album.images.map(
                        (item) {
                          return Builder(
                            builder: (BuildContext context) => Container(
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.white30,
                                image: DecorationImage(
                                  image: NetworkImage(item),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                      options: CarouselOptions(
                        viewportFraction: 1,
                        height: 200,
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
                          value: widget.album.status,
                          icon: const Icon(Icons.arrow_drop_down_rounded),
                          items: productStatus
                              .map((String item) => DropdownMenuItem(
                                  value: item,
                                  child: BigText(
                                    text: item,
                                    size: 15,
                                  )))
                              .toList(),
                          onChanged: (String? statusVal) {
                            setState(() {
                              status = statusVal!;
                            });
                          },
                        ),
                        // SizedBox(width: Dimensions.height40),
                        DropdownButton(
                          value: widget.album.location,
                          icon: const Icon(Icons.arrow_drop_down_rounded),
                          items: productLocation
                              .map((String item) => DropdownMenuItem(
                                  value: item,
                                  child: BigText(
                                    text: item,
                                    size: 15,
                                  )))
                              .toList(),
                          onChanged: (String? locationVal) {
                            setState(() {
                              location = locationVal!;
                            });
                          },
                        ),
                        // SizedBox(width: Dimensions.height40),
                        DropdownButton(
                          value: widget.album.category,
                          icon: const Icon(Icons.arrow_drop_down_rounded),
                          items: productCategory
                              .map((String item) => DropdownMenuItem(
                                  value: item,
                                  child: BigText(
                                    text: item,
                                    size: 15,
                                  )))
                              .toList(),
                          onChanged: (String? categoryVal) {
                            setState(() {
                              category = categoryVal!;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SizedBox(width: Dimensions.width20,),
                        BigText(
                          text: 'Add to Popular',
                          size: 15,
                        ),
                        Checkbox(
                            activeColor: AppColors.mainColor,
                            value: widget.album.isPopular,
                            onChanged: (newBool) {
                              setState(() {
                                widget.album.isPopular = newBool ?? false;
                                //productImages = [];
                              });
                            }),
                        SizedBox(
                          width: Dimensions.width15,
                        ),
                        BigText(
                          text: 'Add to NewArrival',
                          size: 15,
                        ),

                        Checkbox(
                            activeColor: AppColors.mainColor,
                            value: widget.album.isNewArrival,
                            onChanged: (newBool) {
                              setState(() {
                                widget.album.isNewArrival = newBool ?? false;
                              });
                            }),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print(widget.album.id);
                        print(widget.album.toJson());
                        updateProduct();
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
                        text: 'Save',
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
