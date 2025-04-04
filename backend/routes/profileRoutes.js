const express = require('express')

const router = express.Router()

const Teacher = require('../models/teacherSchema')

router.get('/:teacherId', async(req,res)=>{
    try{
        const teacher = await Teacher.findById(req.params.teacherId)
        if(!teacher){
            return res.status(404).json({message: "Teacher not found"})
        }
        res.status(200).json(teacher)
    }catch(error){
        res.status(500).json({message: "Server error",error})
    }
})

module.exports = router