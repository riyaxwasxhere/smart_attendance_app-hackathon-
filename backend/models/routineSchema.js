const mongoose = require('mongoose')

const routineSchema = new mongoose.Schema({
    teacherId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Teacher',
        required: true
    },
    day: {
        type: String,
        enum: [
            'Monday',
            'Tuesday',
            'Wednesday',
            'Thursday',
            'Friday'
        ],
        required: true
    },
    semester: {
        type: String,
        required: true,
    },
    section:{
        type: String,
        enum :[
            'A',
            'B'
        ],
        required: true
    },
    subject: [
        {
            subName: {
                type: String,
                required: true
            },
            startTime: {
                type: String,
                required: true
            },
            endTime:{
                type: String,
                required: true
            }
        }
    ]
})



const Routine = mongoose.model("Routine",routineSchema)

module.exports = Routine