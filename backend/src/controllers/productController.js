const Product = require("../models/Product");
const cloudinary = require("../config/cloudinary");
const streamifier = require("streamifier");

exports.addProduct = async (req, res) => {
  try {
    const { name, price, detail, category } = req.body;

    if (!req.file) {
      return res.status(400).json({ message: "Image is required" });
    }

    // Cloudinary upload using stream
    const uploadStream = cloudinary.uploader.upload_stream(
      { folder: "products" },
      async (error, result) => {
        if (error) {
          console.log(error);
          return res.status(500).json({ message: "Upload failed" });
        }

        const product = await Product.create({
          name,
          price,
          detail,
          category,
          image: result.secure_url,
        });

        return res.status(201).json(product);
      }
    );

    streamifier.createReadStream(req.file.buffer).pipe(uploadStream);

  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Server error" });
  }
};


// 📌 GET ALL PRODUCTS
exports.getAllProducts = async (req, res) => {
  try {
    const items = await Product.find().sort({ createdAt: -1 });
    res.json(items);
  } catch (err) {
    res.status(500).json({ message: "Server error" });
  }
};

// 📌 GET BY CATEGORY
exports.getByCategory = async (req, res) => {
  try {
    const products = await Product.find({ category: req.params.category });
    res.json(products);
  } catch (err) {
    res.status(500).json({ message: "Server error" });
  }
};


exports.updateProduct = async (req, res) => {
  try {
    let updateData = req.body;

    // If new image uploaded → replace
    if (req.file) {
      updateData.image = req.file.path;
    }

    const updated = await Product.findByIdAndUpdate(
      req.params.id,
      updateData,
      { new: true }
    );

    if (!updated) return res.status(404).json({ message: "Product not found" });

    res.json(updated);
  } catch (err) {
    console.error("Update product error:", err);
    res.status(500).json({ message: "Server error" });
  }
};


// 📌 DELETE PRODUCT
exports.deleteProduct = async (req, res) => {
  try {
    const product = await Product.findByIdAndDelete(req.params.id);
    if (!product)
      return res.status(404).json({ message: "Product not found" });

    res.json({ message: "Product deleted successfully" });
  } catch (err) {
    res.status(500).json({ message: "Server error" });
  }
};
