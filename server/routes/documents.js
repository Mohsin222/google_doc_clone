const express =require('express')
const documentsRouter = express.Router();

const Document = require('../model/documents');
const auth = require('../middleware/auth');


documentsRouter.get('/docs',auth,async(req,res)=>{


    try {
const docs  = await Document.find({uid:req.user})
        // let document =await Document.find({uid:req.user})
        res.status(200).json({success:true,data:docs})
    } catch (error) {
        res.status(500).json({success:false,error:error})
    }
})


documentsRouter.post('/create',auth,async(req,res)=>{


    try {
const {createdAt} = req.body
        // let documents =await Document.find({uid:req.user})
        let document = new Document({uid:req.user,
        
        title:"Untitled Documents",
        createdAt,
        })

    document=    await document.save()
        // res.json({success:true,data:document})
    } catch (error) {
        res.status(500).json({success:false,error:error})
    }
})
module.exports = documentsRouter;