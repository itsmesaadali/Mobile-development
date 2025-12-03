const mongoose = require("mongoose");

const productSchema = new mongoose.Schema(
  {
    name: { type: String, required: true },
    price: { type: Number, required: true },
    detail: { type: String, required: true },
    category: { type: String, required: true },
    image: { type: String, required: true }, // Cloudinary URL
  },
  { timestamps: true }
);

module.exports = mongoose.model("Product", productSchema);
