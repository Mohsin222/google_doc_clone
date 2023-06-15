const User = require("../model/user_model");
const jwt = require("jsonwebtoken");
const bcrypt = require('bcryptjs')

exports.createUser =async(req,res)=>{

  try {
    const {email,password,name,profilePic}= req.body

   var encryptedPassword = await bcrypt.hash(password, 10);
    
    const userData = await User({
        email:email,
        password:encryptedPassword,
        name:name,
        profilePic:profilePic
    })

    
    const findEmail =await User.findOne({email:email})
    if(findEmail)
    return res.status(200).json({success:true, message:"Email already registered"})
    const token = jwt.sign({id:userData._id}, "passwordKey",
    secret, {
      expiresIn: "1hr"
  },
      // expiresIn: "2h",
    )

    userData.token =token;
 const newData =    await userData.save()



 res.status(200).json({success:true,data:newData})
  } catch (error) {
    console.log(error)
    res.status(500).json({success:false,error:error})
  }
}



//login user
exports.loginUser=async(req,res)=>{
    const data =req.body

   try{
    
    const findUser= await User.findOne({email:data.email})

    if(!findUser){
      return     res.status(400).json({success:false,error:'User not found'})
       
    }
    // bcrypt.compare(findUser.password, data.password, (err, result) => {

    //   if (err || !result) {
    //     return res.status(401).json({ message: 'Invalid password' });
    //   }
    // }
    //  )

    // if(findUser.password != data.password){
   
    
    // }

    const token = jwt.sign({id:findUser._id}, "passwordKey",{
      expiresIn: "2h",
    })

    findUser.token =token
   
// console.log(token)
    // res.status(200).json({success:true,data:findUser,token:token})
    res.status(200).json({success:true,data:findUser})
   }catch(error){
    console.log(error)
    res.status(500).json({success:false,error:error})
   
   }


  
 
}
   //get data if user has token
 

   exports.getUserData=  async (req, res) => {
    // const user = await User.findById(req.user);

    // user.token =req.token
    // res.json({ user, token: req.token });


    try {
      const user = await User.findById(req.user);
    
      user.token =req.token
      res.json({success:true, data:user, token: req.token });
    } catch (error) {
      res.json({success:false, data:error,  });
    }
  }

