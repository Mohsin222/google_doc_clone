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
        const { createdAt, content } = req.body;
        let document = new Document({
          uid: req.user,
          title: '!@#aaaa',
          createdAt,
          content:content
        });
    
        document = await document.save();
        res.json(document);
    } catch (error) {
        res.status(500).json({success:false,error:error})
    }
})




documentsRouter.post('/create/title',auth,async(req,res)=>{


    try {
        const { id, title } = req.body;
        const document = await Document.findByIdAndUpdate(id, { title },
        {
            new:true  
        }
            );
    
        res.status(200).json({success:true, data:document});
        // res.json({success:true,data:document})
    } catch (error) {
        res.status(500).json({success:false,error:error})
    }
})


documentsRouter.get('/docs/:id',auth,async(req,res)=>{


    try {
const docs  = await Document.findById(req.params.id)
console.log('data');
        // let document =await Document.find({uid:req.user})
        return res.status(200).json({success:true,data:docs})
    } catch (error) {
        return res.status(500).json({success:false,error:error})
    }
})


documentsRouter.get('/pp',async(req,res)=>{
return res.status(200).json({data:''})
})
module.exports = documentsRouter;