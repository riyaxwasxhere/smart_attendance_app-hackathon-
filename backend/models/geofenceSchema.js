const mongoose = require("mongoose");
const geofencingSchema = new mongoose.Schema({
  className: {
    type: String,
    required: true,
  },
  dept: {
    type: String,
    required: true,
  },
  location: {
    type: {
      type: String,
      enum: ["Point"],
      required: true,
    },
    coordinates: {
      type: [Number],
      required: true,
    },
  },
});

geofencingSchema.index({ location: "2dsphere" });

const geofencing = mongoose.model("Geofencing", geofencingSchema);
module.exports = geofencing;
