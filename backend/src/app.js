const express = require("express");
const cors = require("cors");
const path = require("path");

const productRoutes = require("./routes/productRoutes");
const orderRoutes = require("./routes/orderRoutes");
const stripeRoutes = require("./routes/stripeRoutes");

const app = express();

app.use(cors());
app.use(express.json());

// 👉 Serve static files from /public (HTML, CSS, images, etc.)
app.use(express.static(path.join(__dirname, "..", "public")));

// API Routes
app.use("/api/products", productRoutes);
app.use("/api/orders", orderRoutes);
app.use("/api/stripe", stripeRoutes);

// ✅ Success page route
app.get("/success", (req, res) => {
  res.sendFile(path.join(__dirname, "..", "public", "success.html"));
});

// ❌ Cancel page route
app.get("/cancel", (req, res) => {
  res.sendFile(path.join(__dirname, "..", "public", "cancel.html"));
});

app.get("/", (req, res) => {
  res.send("E-commerce API running...");
});

module.exports = app;
