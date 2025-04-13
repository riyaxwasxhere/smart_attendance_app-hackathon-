const express = require('express')
const bcrypt = require('bcrypt')

const jwt = require('jsonwebtoken')
const JWT_SECRET = 'its-a-secret-hehe'

const mongoose = require('mongoose')
const Teacher = require('../models/teacherSchema')

const router = express.Router()

router.post('/signUp', async(req,res)=>{
    const {name, email, password} = req.body
    try{
        const existingTeacher = await Teacher.findOne({email})
        if(existingTeacher){
            return res.status(200).json({message: "Email registered."})
        }
        const saltRounds = 10
        const hashedPassword = await bcrypt.hash(password,saltRounds)
        const newTeacher  = new Teacher({
            name,
            email,
            password: hashedPassword
        })
        await newTeacher.save()
        return res.status(201).json({message: "Teacher registered successfully."})
    }catch(error){
        return res.status(500).json({message: "Server Error",error: error.message})
    }
})

router.post('/login', async (req,res) => {
    const {email,password} = req.body
    try{
        const existingTeacher = await Teacher.findOne({email})
        if(!existingTeacher){
            return res.status(404).json({message: "User not found"})
        }
        const isMatch = await bcrypt.compare(password,existingTeacher.password)
        if(!isMatch){
            return res.status(400).json({message: "Invalid password."})
        }
        const token = jwt.sign({id: existingTeacher.id, role: existingTeacher.role}, JWT_SECRET, {expiresIn: '1h'})
        return res.status(200).json({message: "Login successful",token,existingTeacher})
    }catch(error){
        return res.status(500).json({message: "Server error",error})
    }
})

module.exports = router