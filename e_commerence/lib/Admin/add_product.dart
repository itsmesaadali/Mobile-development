import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:e_commerence/widget/support_widget.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productDetailController = TextEditingController();

  String? selectedCategory;

  final List<String> categories = [
    "Electronics",
    "Clothes",
    "Books",
    "Accessories",
    "Home Appliances",
  ];

  Future pickImage() async {
    final img = await _picker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      selectedImage = File(img.path);
      setState(() {});
    }
  }

  void staticAddProduct() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.all(20),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.check_circle, color: Colors.green, size: 80),
            SizedBox(height: 15),
            Text(
              "Product Added (Static)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );

    // Clear fields
    productNameController.clear();
    productPriceController.clear();
    productDetailController.clear();
    selectedCategory = null;
    selectedImage = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text("Add Product", style: AppStyles.heading),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -------- IMAGE PICKER -------- //
            Text("Product Image", style: AppStyles.label),
            const SizedBox(height: 10),

            GestureDetector(
              onTap: pickImage,
              child: Container(
                height: 170,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: selectedImage == null
                    ? const Center(
                        child: Icon(
                          Icons.camera_alt,
                          size: 50,
                          color: Colors.grey,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          selectedImage!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 25),

            // -------- PRODUCT NAME -------- //
            Text("Product Name", style: AppStyles.label),
            const SizedBox(height: 10),
            buildInputField(controller: productNameController),

            const SizedBox(height: 25),

            // -------- PRODUCT PRICE -------- //
            Text("Product Price", style: AppStyles.label),
            const SizedBox(height: 10),
            buildInputField(
              controller: productPriceController,
              keyboard: TextInputType.number,
            ),

            const SizedBox(height: 25),

            // -------- PRODUCT DESCRIPTION -------- //
            Text("Product Detail", style: AppStyles.label),
            const SizedBox(height: 10),
            buildInputField(controller: productDetailController, maxLines: 3),

            const SizedBox(height: 25),

            // -------- CATEGORY DROPDOWN -------- //
            Text("Category", style: AppStyles.label),
            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: const Color(0xffececfa),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedCategory,
                  dropdownColor: const Color(0xffececfa),
                  icon: const Icon(Icons.arrow_drop_down),
                  items: categories.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item, style: AppStyles.subtitle),
                    );
                  }).toList(),
                  hint: Text("Select Category", style: AppStyles.subtitle),
                  onChanged: (value) => setState(() {
                    selectedCategory = value;
                  }),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // -------- ADD PRODUCT BUTTON -------- //
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: staticAddProduct,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Add Product",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- INPUT FIELD BUILDER ---------- //
  Widget buildInputField({
    required TextEditingController controller,
    int maxLines = 1,
    TextInputType keyboard = TextInputType.text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: const Color(0xffececfa),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        maxLines: maxLines,
        controller: controller,
        keyboardType: keyboard,
        decoration: const InputDecoration(border: InputBorder.none),
      ),
    );
  }
}
