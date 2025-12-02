const express = require("express");
const app = express();
const cors = require("cors");
const { v4: uuid } = require("uuid");

app.use(cors());
app.use(express.json({ limit: "10mb" }));

let activities = [];

app.get('/', (req, res) => {
    res.json("hello world server run")
})

app.post("/activity", (req, res) => {
    const id = uuid();
    const activity = { id, ...req.body };
    activities.push(activity);
    res.json({ success: true, activity });
});

app.get("/activity", (req, res) => {
    res.json(activities);
});

app.delete("/activity/:id", (req, res) => {
    const id = req.params.id;
    activities = activities.filter(a => a.id !== id);
    res.json({ success: true });
});

app.listen(3000, () => console.log("API running on port 3000"));
