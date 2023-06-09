const express =require('express')
const documentsRouter = express.Router();

const Documents = require('../model/documents');
const auth = require('../middleware/auth');


documentsRouter.get('/docs',auth,async(req,res)=>{


    try {

        // let documents =await Documents.find({uid:req.user})
        res.json({success:true,data:"documents"})
    } catch (error) {
        res.status(500).json({success:false,error:error})
    }
})

module.exports = documentsRouter;