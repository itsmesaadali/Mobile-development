import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:e_commerence/widget/support_widget.dart';
import 'package:e_commerence/services/api_service.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final ImagePicker _picker = ImagePicker();

  XFile? pickedFile; // file picked from web
  Uint8List? webImage; // preview bytes

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

  // 📌 Pick Image For Web
  Future pickImage() async {
    final img = await _picker.pickImage(source: ImageSource.gallery);

    if (img != null) {
      pickedFile = img;
      webImage = await img.readAsBytes(); // Web preview
      setState(() {});
    }
  }

  // 📌 Send To Backend
  void addProductToServer() async {
    if (pickedFile == null ||
        productNameController.text.isEmpty ||
        productPriceController.text.isEmpty ||
        productDetailController.text.isEmpty ||
        selectedCategory == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    bool success = await ApiService.addProduct(
      name: productNameController.text,
      price: productPriceController.text,
      detail: productDetailController.text,
      category: selectedCategory!,
      image: pickedFile!, // web file
    );

    if (success) {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          title: Text("Success"),
          content: Text("Product added successfully!"),
        ),
      );

      productNameController.clear();
      productPriceController.clear();
      productDetailController.clear();
      selectedCategory = null;
      pickedFile = null;
      webImage = null;
      setState(() {});
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to add product")));
    }
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
                child: webImage == null
                    ? const Center(
                        child: Icon(
                          Icons.camera_alt,
                          size: 50,
                          color: Colors.grey,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.memory(
                          webImage!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 25),

            Text("Product Name", style: AppStyles.label),
            const SizedBox(height: 10),
            buildInputField(controller: productNameController),

            const SizedBox(height: 25),

            Text("Product Price", style: AppStyles.label),
            const SizedBox(height: 10),
            buildInputField(
              controller: productPriceController,
              keyboard: TextInputType.number,
            ),

            const SizedBox(height: 25),

            Text("Product Detail", style: AppStyles.label),
            const SizedBox(height: 10),
            buildInputField(controller: productDetailController, maxLines: 3),

            const SizedBox(height: 25),

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
                  onChanged: (value) =>
                      setState(() => selectedCategory = value),
                ),
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: addProductToServer,
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
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboard,
        decoration: const InputDecoration(border: InputBorder.none),
      ),
    );
  }
}
