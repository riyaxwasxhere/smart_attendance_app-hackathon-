const express = require("express");
const router = express.Router();
const attendance = require("../models/attendanceSchema.js");

// Get all attendance records
router.get("/", async (req, res) => {
  try {
    const allRecords = await attendance.find({});
    res.status(200).json(allRecords);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});


// Delete all attendance records
router.delete("/", async (req, res) => {
  try {
    const result = await attendance.deleteMany({});
    res.status(200).json({ message: "All attendance records deleted", deletedCount: result.deletedCount });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});


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

//To get all the attendance record of a particular student of a particular subject
router.get("/:dept/:studentRoll/:subject", async (req, res) => {
  try {
    const { dept, studentRoll, subject } = req.params;
    const record = await attendance.find({ dept, studentRoll, subject });
    res.status(200).json(record);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

//To get all student record for a particular subject for today
router.get("/:dept/:className/:subject/today", async (req, res) => {
  try {
    const { dept, className, subject } = req.params;
    const startOfDay = new Date();
    startOfDay.setHours(0, 0, 0, 0);
    const endOfDay = new Date();
    endOfDay.setHours(23, 59, 59, 999);
    const record = await attendance.find({
      dept,
      className,
      subject,
      createdAt: { $gte: startOfDay, $lte: endOfDay },
    });
    res.status(200).json(record);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

//To get all student record for a particular subject for last7days
router.get("/:dept/:className/:subject/lastweek", async (req, res) => {
  try {
    const { dept, className, subject } = req.params;
    const startDate = new Date();
    startDate.setDate(startDate.getDate() - 7);
    startDate.setHours(0, 0, 0, 0);
    const endDate = new Date();
    const record = await attendance.find({
      dept,
      className,
      subject,
      createdAt: { $gte: startDate, $lte: endDate },
    });
    res.status(200).json(record);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// to get total classes of a subject
router.get("/totalClasses/:dept/:className/:subject", async (req, res) => {
  try {
    const { dept, className, subject } = req.params;
    const totalClasses = await attendance.aggregate([
      { $match: { dept: dept, className: className, subject: subject } },
      {
        $group: {
          _id: {
            dateTime: {
              $dateToString: {
                format: "%Y-%m-%d %H:%M:%S",
                date: "$createdAt",
              },
            },
          },
        },
      },
      {
        $count: "totalClasses",
      },
    ]);
    res.status(200).json({ totalClasses: totalClasses[0]?.totalClasses || 0 });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// to add attendance-working
router.post("/", async (req, res) => {
  try {
    const {
      studentName,
      studentRoll,
      dept,
      className,
      subject,
      isPresent,
      createdAt // grab createdAt from body if it exists
    } = req.body;

    const attendanceData = await attendance.create({
      studentName,
      studentRoll,
      dept,
      className,
      subject,
      isPresent,
      ...(createdAt && { createdAt: new Date(createdAt) }) // only include if provided
    });

    res.status(201).json(attendanceData);
  } catch (err) {
    res.status(500).json({ err: err.message });
  }
});


module.exports = router;
