const Order = require("../models/Order");

// POST /api/orders  (user places order)
exports.createOrder = async (req, res) => {
  try {
    const { userEmail, userName, products, totalAmount } = req.body;

    if (!userEmail || !userName || !products || !totalAmount) {
      return res.status(400).json({ message: "Missing fields" });
    }

    const order = await Order.create({
      userEmail,
      userName,
      products,
      totalAmount,
    });

    res.status(201).json(order);
  } catch (err) {
    console.error("Create order error:", err);
    res.status(500).json({ message: "Server error" });
  }
};

// GET /api/orders/my/:email  (user's orders)
exports.getUserOrders = async (req, res) => {
  try {
    const orders = await Order.find({ userEmail: req.params.email }).sort({
      createdAt: -1,
    });
    res.json(orders);
  } catch (err) {
    console.error("Get user orders error:", err);
    res.status(500).json({ message: "Server error" });
  }
};

// GET /api/orders  (admin – all orders)
exports.getAllOrders = async (req, res) => {
  try {
    const orders = await Order.find().sort({ createdAt: -1 });
    res.json(orders);
  } catch (err) {
    console.error("Get all orders error:", err);
    res.status(500).json({ message: "Server error" });
  }
};

// PATCH /api/orders/:id/status  (admin – change status)
exports.updateOrderStatus = async (req, res) => {
  try {
    const { status } = req.body;
    const updated = await Order.findByIdAndUpdate(
      req.params.id,
      { status },
      { new: true }
    );
    if (!updated) return res.status(404).json({ message: "Order not found" });
    res.json(updated);
  } catch (err) {
    console.error("Update order status error:", err);
    res.status(500).json({ message: "Server error" });
  }
};
