const mongoose = require("mongoose");
const attendanceSchema = new mongoose.Schema(
  {
    studentName: {
      type: String,
      require: true,
    },

    studentRoll: {
      type: String,
      require: true,
      unique: false,
    },

    dept: {
      type: String,
      require: true,
    },

    className: {
      type: String,
      require: true,
    },

    subject: {
      type: String,
      require: true,
    },

    isPresent: {
      type: Boolean,
      default: false,
    },
  },
  {
    timestamps: true,
  }
);

const attendance = mongoose.model("Attendance", attendanceSchema);
module.exports = attendance;
