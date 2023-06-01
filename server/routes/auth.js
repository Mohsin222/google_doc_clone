const express =require('express')
const User = require('../model/user_model')
const jwt = require("jsonwebtoken");
const authRouter = express.Router();
const userController = require('../controller/auth_controller')


authRouter.post('/signUp',userController.createUser),


authRouter.post('/login',userController.loginUser)


module.exports = authRouter;