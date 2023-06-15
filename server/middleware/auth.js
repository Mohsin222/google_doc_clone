const jwt = require("jsonwebtoken");

const auth = async(req,res,next)=>{
    try {
        // const token = req.header("x-auth-token")
        //   const token = req.header('Authorization').replace('Bearer', '')
        // console.log(req.headers.authorization)
        const token = req.headers.authorization && req.headers.authorization.split(' ')[1];

        if(!token)
           { return res.status(401).json({message:"No auth token , access denied"})}
        const verified =jwt.verify(token,"passwordKey")

        if(!verified){
            return res.status(401).json({message:"Token verification failed, try again later"})
        }
// console.log(token)
  
            req.user = verified.id
            req.token =token;
        next()
    } catch (error) {
        res.status(500).json({success:false,error:error}) 
    }
}

// const auth = (req, res, next) =>{
//     const authHeader = req.headers.authorization;
//     if (!authHeader || !authHeader.startsWith('Bearer ')) {
//       return res.status(401).json({ message: 'Authentication token required' });
//     }
  
//     const token = authHeader.split(' ')[1];
//     jwt.verify(token,"passwordKey" , (err, user) => {
//       if (err) {
//         return res.status(403).json({ message: 'Invalid token' });
//       }
  
//       req.user = user;
//       next();
//     });
//   }



module.exports = auth