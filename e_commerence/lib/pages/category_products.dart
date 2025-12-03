import 'package:e_commerence/pages/product_detail.dart';
import 'package:e_commerence/services/api_service.dart';
import 'package:e_commerence/widget/support_widget.dart';
import 'package:flutter/material.dart';

class CategoryProduct extends StatefulWidget {
  final String category;
  const CategoryProduct({super.key, required this.category});

  @override
  State<CategoryProduct> createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
  List<dynamic> products = [];
  bool loading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadCategoryProducts();
  }

  Future<void> _loadCategoryProducts() async {
    try {
      final data = await ApiService.getProductsByCategory(widget.category);

      setState(() {
        products = data;
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
        errorMessage = "Failed to load products";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      appBar: AppBar(
        backgroundColor: const Color(0xfff2f2f2),
        elevation: 0,
        title: Text(widget.category, style: AppStyles.heading),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : (products.isEmpty
                  ? Center(
                      child: Text(
                        "No products found in ${widget.category}",
                        style: AppStyles.subtitle,
                      ),
                    )
                  : GridView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.62,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                          ),
                      itemBuilder: (context, index) {
                        final product = products[index];

                        final String name = product["name"] ?? "No name";
                        final String detail =
                            product["detail"] ?? "No details available";
                        final String image = product["image"] ?? "";
                        final String price =
                            product["price"]?.toString() ?? "0";

                        return Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Product Image
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ProductDetail(
                                          image: image,
                                          name: name,
                                          price: price,
                                          detail: detail,
                                        ),
                                      ),
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      image,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => const Icon(
                                        Icons.image_not_supported,
                                        size: 80,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 8),

                              // Product Name
                              Text(
                                name,
                                style: AppStyles.subtitle,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                              const Spacer(),

                              // Price + Cart Button
                              Row(
                                children: [
                                  Text("\$$price", style: AppStyles.heading),
                                  const Spacer(),

                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => ProductDetail(
                                            image: image,
                                            name: name,
                                            price: price,
                                            detail: detail,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(6),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.4),
                                            blurRadius: 6,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.add_shopping_cart,
                                        color: Color(0xFFfd6f3e),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    )),
      ),
    );
  }
}
