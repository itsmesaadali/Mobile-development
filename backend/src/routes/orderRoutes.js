const express = require("express");
const router = express.Router();
const {
  createOrder,
  getUserOrders,
  getAllOrders,
  updateOrderStatus,
} = require("../controllers/orderController");

// User
router.post("/", createOrder);
router.get("/my/:email", getUserOrders);

// Admin
router.get("/", getAllOrders);
router.patch("/:id/status", updateOrderStatus);

module.exports = router;
