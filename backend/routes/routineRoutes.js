const express = require('express')
const mongoose = require('mongoose')

const Routine = require('../models/routineSchema')
// const verifyToken = require('../middleware/verifyToken')
// const { verify } = require('jsonwebtoken')

const router = express.Router()

//gets whole week rotuine
router.get('/:teacherId/week', async (req,res)=>{
    try{
        const routines = await Routine.find({ teacherId: req.params.teacherId})
        if(!routines.length){
            return req.status(404).json({message: "No routine found for this teacher"})
        }
        return res.status(200).json({routines})
    }catch(error){
        return res.status(500).json({message: "Server error",error})
    }
})

//gets routine for a specific day
router.get('/:teacherId/:day', async (req,res)=>{
    try{
        const routine = await Routine.find({teacherId: req.params.teacherId, day: req.params.day})
        if(!routine.length){
            return res.status(404).json({message: "No routine found for this day"})
        }
        return res.status(200).json({routine})
    }catch(error){
        return res.status(500).json({message: "Server error",error})
    }
})

//creates routine for a specific day
router.post('/:teacherId/:day', async (req,res)=>{
    const {semester,section, subject} = req.body

    if(!semester || !section || !subject){
        return res.status(400).json({message: "All fields are required."})
    }
    try{
        const newRoutine = new Routine({
            teacherId: req.params.teacherId,
            day: req.params.day,
            semester,
            section,
            subject,
        })
        await newRoutine.save()
        return res.status(201).json({message: "Routine added successfully", routine:newRoutine})
    }catch(error){
        return res.status(500).json({error: error.message})
    }
})


//updates routine for a specific day
router.patch('/:teacherId/:day', async(req,res)=>{
    try{
        const updated = await Routine.findOneAndUpdate(
            {teacherId: req.params.teacherId,day : req.params.day},
            {$set: req.body},
            {new: true} 
        )
        if(!updated){
            return res.status(404).json({message: "Routine not found"})
        }
        return res.status(200).json({message: "Updated routine successfully!"})
    }catch(error){
        return res.status(500).json({message: "Server error",error})
    }
})

//delete routine for a specific day
router.delete('/:teacherId/:day', async (req, res)=>{
    try{
        const deleted = await Routine.findOneAndDelete({teacherId: req.params.id, day: req.params.day})
        if(!deleted){
            return res.status(404).json({message: "Routine not found"})
        }
        res.status(200).json({message: "Routine deleted successfully!"})
    }catch(error){
        res.status(500).json({message: "server error",error})
    }
})


module.exports = router