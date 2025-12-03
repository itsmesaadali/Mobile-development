const express = require("express");
const router = express.Router();
const upload = require("../middlewares/upload");


const {
  addProduct,
  getAllProducts,
  getByCategory,
  updateProduct,
  deleteProduct,
} = require("../controllers/productController");

// GET routes
router.get("/", getAllProducts);
router.get("/category/:category", getByCategory);

// Image upload route (Multer middleware)
router.post("/", upload.single("image"), addProduct);

router.put("/:id", upload.single("image"), updateProduct);

router.delete("/:id", deleteProduct);

module.exports = router;
