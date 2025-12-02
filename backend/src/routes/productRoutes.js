const express = require("express");
const router = express.Router();
const {
  addProduct,
  getAllProducts,
  getByCategory,
  updateProduct,
  deleteProduct,
} = require("../controllers/productController");

// PUBLIC (for now) – later protect some with admin middleware
router.get("/", getAllProducts);
router.get("/category/:category", getByCategory);

// ADMIN ONLY (later)
router.post("/", addProduct);
router.put("/:id", updateProduct);
router.delete("/:id", deleteProduct);

module.exports = router;
