const express = require("express");
const http = require("http");
const { Server } = require("socket.io");
const mongoose = require("mongoose");
const cors = require("cors");
require("dotenv").config();

const attendanceRoutes = require("./routes/attendanceRoutes.js");
const studentRoutes = require("./routes/studentRoutes.js");

const app = express();
const server = http.createServer(app);
const io = new Server(server, { cors: { origin: "*" } });

const PORT = process.env.PORT || 3000;


app.use(express.json());
app.use(cors());


app.use("/api/students", studentRoutes);
app.use("/api/attendance", attendanceRoutes);


mongoose
  .connect(process.env.DBURL, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(() => {
    console.log("Connected to Database");
    server.listen(PORT, () => console.log(`Server started at PORT: ${PORT}`));
  })
  .catch((err) => {
    console.log("Connection failed", err);
  });

io.on("connection", (socket) => {
  console.log("Client connected:", socket.id);

  socket.on("update_is_in_class", async (data) => {
    try {
      const { roll, is_in_class } = data;
      console.log(`Received update: Roll - ${roll}, is_in_class - ${is_in_class}`);

      await require("./models/studentSchema").findOneAndUpdate(
        { roll },
        { is_in_class: is_in_class }
      );

      io.emit("is_in_class_updated", { roll, is_in_class });
    } catch (error) {
      console.error("Error updating is_in_class:", error);
    }
  });

  socket.on("disconnect", () => {
    console.log("Client disconnected:", socket.id);
  });
});

// Export io so it can be used in routes
module.exports = { io };

