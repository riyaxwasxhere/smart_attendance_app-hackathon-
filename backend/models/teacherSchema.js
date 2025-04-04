const mongoose = require('mongoose')

const teacherSchema = mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    email: {
        type: String,
        required: true,
    },
    password: {
        type: String,
        required: true
    },
    role:{
        type: String,
        default: 'Teacher'
    }
})

const Teacher = mongoose.model("Teacher", teacherSchema)

module.exports = Teacher