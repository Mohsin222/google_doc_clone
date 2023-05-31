const express =require('express')
const mongoose = require('mongoose')
const PORT =process.env.port || 8000


const app = express()
const DB="mongodb+srv://mohsin:123@cluster0.xgm3y.mongodb.net/google_docs_clone";
mongoose.connect(DB).then(()=>{
    console.log('Connection Success')
}).catch((error)=>{
    console.log(error)
})

app.listen(PORT,"0.0.0.0",()=>{
console.log(`Server is running on ${PORT}`)
})