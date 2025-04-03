const express = require("express");
const mongoose = require("mongoose");
let cors = require("cors");
const attendanceRoutes = require("./routes/attendanceRoutes.js");

const app = express();
const PORT = 3000;

app.use("/api/attendance", attendanceRoutes);
app.use(express.json());
app.use(cors());

mongoose
  .connect(
    "mongodb+srv://Rajdeepcr7:Rajdeepcr7@cluster0.ylidhnx.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"
  )
  .then(() => {
    console.log("Connected to Database");
    app.listen(PORT, () => console.log(`Server Started at PORT:${PORT}`));
  })
  .catch(() => {
    console.log("Connection failed");
  });
