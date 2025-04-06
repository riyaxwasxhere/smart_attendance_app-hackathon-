const express = require("express");
const router = express.Router();
const geofencing = require("../models/geofenceSchema.js");

// To get geospatial coordinates-working
router.get("/:dept/:className", async (req, res) => {
  try {
    const { dept, className } = req.params;
    const geofenceData = await geofencing.findOne({ dept, className });
    if (!geofenceData) {
      res.status(404).json({ message: "Geofence data not found" });
    }
    res.send(geofenceData.location.coordinates);
  } catch (err) {
    res.status(500).json({ err: err.message });
  }
});

// To store geospatial coordinates- working
router.post("/", async (req, res) => {
  try {
    const { className, dept, location } = req.body;
    const [longitude, latitude] = location.coordinates;
    if (!longitude || !latitude) {
      return res
        .status(400)
        .json({ error: "latitude and longitude are required" });
    }

    const newLocation = new geofencing({
      className,
      dept,
      location: {
        type: "Point",
        coordinates: [longitude, latitude],
      },
    });

    await newLocation.save();
    res
      .status(201)
      .json({ message: "Location added successfully", data: newLocation });
  } catch (err) {
    res.status(500).json({ err: err.message });
  }
});

module.exports = router;
