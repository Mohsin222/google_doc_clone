const express =require('express')
const User = require('../model/user_model')
const jwt = require("jsonwebtoken");
const authRouter = express.Router();
const userController = require('../controller/auth_controller')
const auth = require('../middleware/auth')
const userModel =require('../model/user_model')

authRouter.post('/signUp',userController.createUser),


authRouter.post('/login',userController.loginUser)

authRouter.get('/login',auth,userController.getUserData)






module.exports = authRouter;