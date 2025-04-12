const express = require("express");
const router = express.Router();
const attendance = require("../models/attendanceSchema.js");


// To get particular attendance of a student for today-working
router.get("/:subject/:studentRoll/today", async (req, res) => {
  try {
    const { subject, studentRoll } = req.params;
    const startOfDay = new Date();
    startOfDay.setHours(0, 0, 0, 0);
    const endOfDay = new Date();
    endOfDay.setHours(23, 59, 59, 999);
    const studentAttendance = await attendance.find({
      subject,
      studentRoll,
      createdAt: { $gte: startOfDay, $lte: endOfDay },
    });
    res.send(studentAttendance);
  } catch (err) {
    res.status(500).json({ err: err.message });
  }
});

// To get a particular attendance of a student for last week
router.get("/:subject/:studentRoll/lastweek", async (req, res) => {
  try {
    const { subject, studentRoll } = req.params;

    const startDate = new Date();
    startDate.setDate(startDate.getDate() - 7);
    startDate.setHours(0, 0, 0, 0);
    const endDate = new Date();

    const studentAttendance = await attendance.find({
      subject,
      studentRoll,
      createdAt: { $gte: startDate, $lte: endDate },
    });

    res.send(studentAttendance);
  } catch (err) {
    res.status(500).json({ err: err.message });
  }
});

// To get a particular attendance of a student for last 30 days
router.get("/:subject/:studentRoll/last30days", async (req, res) => {
  try {
    const { subject, studentRoll } = req.params;

    const startDate = new Date();
    startDate.setDate(startDate.getDate() - 30);
    startDate.setHours(0, 0, 0, 0);
    const endDate = new Date();

    const studentAttendance = await attendance.find({
      subject,
      studentRoll,
      createdAt: { $gte: startDate, $lte: endDate },
    });

    res.send(studentAttendance);
  } catch (err) {
    res.status(500).json({ err: err.message });
  }
});

// to add attendance-working
router.post("/", async (req, res) => {
  try {
    const { studentName, studentRoll, dept, className, subject, isPresent } =
      req.body;
    const attendanceData = await attendance.create({
      studentName,
      studentRoll,
      dept,
      className,
      subject,
      isPresent,
    });
    res.status(201).json(attendanceData);
  } catch (err) {
    res.status(500).json({ err: err.message });
  }
});

module.exports = router;
