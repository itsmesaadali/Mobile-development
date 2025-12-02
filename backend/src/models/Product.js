const mongoose = require("mongoose");

const productSchema = new mongoose.Schema(
  {
    name: { type: String, required: true },
    price: { type: Number, required: true },
    detail: { type: String, required: true },
    category: { type: String, required: true },
    image: { type: String, required: true }, // URL of product image
  },
  { timestamps: true }
);

module.exports = mongoose.model("Product", productSchema);
