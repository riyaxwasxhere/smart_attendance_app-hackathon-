const mongoose = require('mongoose')

const sessionSchema = new mongoose.Schema({
    teacherId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Teacher',
        required: true
    },
    day: {
        type: String,
        enum: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'],
        required: true
    },
    department: {
        type: String
    },
    semester: {
        type: String,
        required: true,
    },
    section: {
        type: String,
        required: true
    },
    subject: {
        type: String,
        required: true
    },
    startTime: {
        type: String,
    },
    endTime: {
        type: String,
    },
    status: {
        type: [String],
        enum: ['classStarted', 'cancelled','attendanceGiven'],
        default: []
    },
    lastUpdated: {
        type: Date,
        default: null
    }
})

const Session = mongoose.model("Session", sessionSchema)

module.exports = Session
