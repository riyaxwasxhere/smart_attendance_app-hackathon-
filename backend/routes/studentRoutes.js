const express = require("express");
const bcrypt = require("bcrypt");
const Student = require("../models/studentSchema"); // Corrected model reference

const router = express.Router();

// Get all students
router.get("/", async (req, res) => {
  try {
    const studentAll = await Student.find().sort({ roll: 1 });
    res.status(200).json(studentAll);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Delete all students
router.delete("/", async (req, res) => {
  try {
    const result = await Student.deleteMany({});
    res.status(200).json({ message: "All students deleted", deletedCount: result.deletedCount });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});


// Get students by department and class name
router.get("/:dept/:className", async (req, res) => {
  try {
    const { dept, className } = req.params;
    const studentList = await Student.find({ dept, className }).sort({ roll: 1 });
    res.status(200).json(studentList);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Signup (Register Student)
router.post("/signup", async (req, res) => {
  try {
    let { name, roll, className, dept, email, password } = req.body;
    const hashedPassword = await bcrypt.hash(password, 10);

    const studentAdd = new Student({ name, roll, className, dept, email, password: hashedPassword });
    await studentAdd.save();

    res.status(200).json({ message: "Student registered successfully!" });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Update Student by Roll Number
router.patch("/update/roll/:roll", async (req, res) => {
  try {
    const { name, dept, className } = req.body;
    const studentUpdate = await Student.findOneAndUpdate(
      { roll: req.params.roll },
      { name, dept, className },
      { new: true }
    );

    if (!studentUpdate) return res.status(404).json({ message: "Student not found" });

    res.status(200).json(studentUpdate);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});


router.delete("/delete/roll/:roll", async (req, res) => {
  try {
    const studentDelete = await Student.findOneAndDelete({ roll: req.params.roll });

    if (!studentDelete) return res.status(404).json({ message: "Student not found" });

    res.status(200).json({ message: "Student deleted successfully" });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.post("/login", async (req, res) => {
    try {
      const { email, password, fcmToken } = req.body;
  
      const user = await Student.findOne({ email });
  
      if (!user) return res.status(400).json({ message: "Invalid email or password" });
  
      const isMatch = await bcrypt.compare(password, user.password);
  
      if (!isMatch) return res.status(400).json({ message: "Wrong password" });
  
      if (fcmToken) {
        user.fcmToken = fcmToken;
        await user.save();
      }
  
      res.status(200).json({ message: "Login successful", user });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  });
  


module.exports = router;
