import 'package:e_commerence/pages/category_products.dart';
import 'package:e_commerence/services/api_service.dart';
import 'package:e_commerence/services/shared_pref.dart';
import 'package:e_commerence/widget/support_widget.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> categories = [
    "images/tv.webp",
    "images/laptop.webp",
    "images/headphones.webp",
    "images/stopwatch.webp",
    "images/digitalwatch.webp",
  ];

  final List<String> categoryNames = [
    "Electronics",
    "Clothes",
    "Books",
    "Accessories",
    "Home Appliances",
  ];

  List<dynamic> products = [];
  bool loading = true;
  Map<String, dynamic> oneProductPerCategory = {};

  String? name, image;

  getUserData() async {
    name = await SharedPreferenceHelper().getUserName();
    image = await SharedPreferenceHelper().getUserImage();
    setState(() {});
  }

  loadProducts() async {
    products = await ApiService.getAllProducts();
    setState(() {
      loading = false;
    });
  }

  loadOneCategoryProducts() async {
    products = await ApiService.getAllProducts();

    // pick first product per category
    for (var p in products) {
      String category = p["category"];
      if (!oneProductPerCategory.containsKey(category)) {
        oneProductPerCategory[category] = p;
      }
      if (oneProductPerCategory.length == 5) break; // only 5 categories
    }

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    loadProducts();
    loadOneCategoryProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: SafeArea(
        child: name == null
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Bar
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Welcome Back", style: AppStyles.subtitle),
                              Text(
                                "Hey ${name ?? "User"}",
                                style: AppStyles.heading,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade200,
                            image: DecorationImage(
                              image: image != null
                                  ? NetworkImage(image!)
                                  : const AssetImage("images/boy.webp")
                                        as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Search Bar
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
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
                      child: const TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search products...",
                          suffixIcon: Icon(Icons.search, color: Colors.grey),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Categories Grid
                    Text("Categories", style: AppStyles.heading),
                    const SizedBox(height: 10),

                    loading
                        ? const Center(child: CircularProgressIndicator())
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: oneProductPerCategory.length, // always 5
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 15,
                                  childAspectRatio: 0.9,
                                ),
                            itemBuilder: (context, index) {
                              String category = oneProductPerCategory.keys
                                  .elementAt(index);
                              var product = oneProductPerCategory[category];

                              return CategoryTile(
                                image: product["image"], // ✔ REAL IMAGE
                                category: category, // ✔ CATEGORY NAME
                              );
                            },
                          ),

                    const SizedBox(height: 25),

                    // Popular Products
                    Text("Popular", style: AppStyles.heading),
                    const SizedBox(height: 15),
                    loading
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                            height: 260,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: products.length > 10
                                  ? 10
                                  : products.length,
                              itemBuilder: (context, index) {
                                var product = products[index];
                                return Row(
                                  children: [
                                    PopularItem(
                                      image: product["image"] ?? "",
                                      name: product["name"] ?? "",
                                      price: product["price"].toString(),
                                      category: product["category"] ?? "",
                                    ),
                                    const SizedBox(width: 15),
                                  ],
                                );
                              },
                            ),
                          ),
                  ],
                ),
              ),
      ),
    );
  }
}

// Category Tile Widget
class CategoryTile extends StatelessWidget {
  final String image, category;
  const CategoryTile({super.key, required this.image, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CategoryProduct(category: category),
          ),
        );
      },
      child: Container(
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
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.network(
                image,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.image_not_supported,
                    size: 50,
                    color: Colors.grey,
                  );
                },
              ),
            ),
            const SizedBox(height: 5),
            Text(
              category,
              style: AppStyles.subtitle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Popular Item Widget
class PopularItem extends StatelessWidget {
  final String image, name, price, category;
  const PopularItem({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CategoryProduct(category: category),
          ),
        );
      },
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(15),
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
          children: [
            Expanded(
              child: Image.network(
                image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.image_not_supported,
                    size: 80,
                    color: Colors.grey,
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Text(name, style: AppStyles.subtitle, textAlign: TextAlign.center),
            const SizedBox(height: 5),
            Text("\$$price", style: AppStyles.heading),
          ],
        ),
      ),
    );
  }
}
