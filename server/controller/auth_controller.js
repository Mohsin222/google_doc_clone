const User = require("../model/user_model");


exports.createUser =async(req,res)=>{

  try {
    const data= req.body
    const userData = await User({
        email:data.email,
        password:data.password,
        name:data.name,
        profilePic:data.profilePic
    })

    
    const findEmail =await User.findOne({email:data.email})
    if(findEmail)
    return res.status(200).json({success:true, message:"Email already registered"})

 const newData =    await userData.save( )

 res.status(200).json({success:true,data:newData})
  } catch (error) {
    res.status(500).json({success:false,error:error})
  }
}



//login user
exports.loginUser=async(req,res)=>{
    const data =req.body

    const findUser= await User.findOne({email:data.email})
    if(!findUser){
        res.status(400).json({success:false,error:'User not found'})
        return 
    }
    if(findUser.password != data.password){
        res.status(400).json({success:false,error:'password not correct'})
        return 
    }
    res.status(200).json({success:true,data:findUser})

 
}