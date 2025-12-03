import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:e_commerence/services/api_service.dart';
import 'package:e_commerence/widget/support_widget.dart';

class EditProduct extends StatefulWidget {
  final String id;
  final String image;
  final String name;
  final String price;
  final String category;
  final String detail;

  const EditProduct({
    super.key,
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.category,
    required this.detail,
  });

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final ImagePicker _picker = ImagePicker();

  XFile? selectedImage; // <-- Web image

  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController detailController;

  String? selectedCategory;

  final List<String> categories = [
    "Electronics",
    "Clothes",
    "Books",
    "Accessories",
    "Home Appliances",
  ];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    priceController = TextEditingController(text: widget.price);
    detailController = TextEditingController(text: widget.detail);
    selectedCategory = widget.category;
  }

  Future pickNewImage() async {
    final img = await _picker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      selectedImage = img; // <-- no File() for web
      setState(() {});
    }
  }

  void saveProduct() async {
    bool success = await ApiService.updateProduct(
      id: widget.id,
      name: nameController.text,
      price: priceController.text,
      detail: detailController.text,
      category: selectedCategory!,
      image: selectedImage, // optional
    );

    if (success) {
      showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(content: const Text("Product updated successfully")),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to update product")));
    }
  }

  // Load bytes from the selected XFile for Image.memory (works on web & mobile)
  Future<Uint8List?> _loadImageBytes() async {
    if (selectedImage == null) return null;
    try {
      return await selectedImage!.readAsBytes();
    } catch (e) {
      // If reading fails, return null so the FutureBuilder can handle it
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text("Edit Product", style: AppStyles.heading),
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
              onTap: pickNewImage,
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                ),

                child: selectedImage == null
                    // OLD IMAGE FROM SERVER (network)
                    ? Image.network(widget.image, fit: BoxFit.cover)
                    // NEW IMAGE SELECTED FROM FILE (WEB SAFE)
                    : FutureBuilder<Uint8List?>(
                        future: _loadImageBytes(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Image.memory(
                            snapshot.data!,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
              ),
            ),

            const SizedBox(height: 25),

            Text("Product Name", style: AppStyles.label),
            const SizedBox(height: 10),
            inputBox(nameController),

            const SizedBox(height: 25),

            Text("Product Price", style: AppStyles.label),
            const SizedBox(height: 10),
            inputBox(priceController, keyboard: TextInputType.number),

            const SizedBox(height: 25),

            Text("Product Detail", style: AppStyles.label),
            const SizedBox(height: 10),
            inputBox(detailController, maxLines: 3),

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
                  icon: const Icon(Icons.arrow_drop_down),
                  dropdownColor: const Color(0xffececfa),
                  items: categories.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item, style: AppStyles.subtitle),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() {
                    selectedCategory = value;
                  }),
                ),
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveProduct,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Save Changes",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget inputBox(
    TextEditingController controller, {
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
