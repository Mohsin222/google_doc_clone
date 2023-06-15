const express =require('express')
const mongoose = require('mongoose')
const cors= require('cors')
const PORT =process.env.port || 3000
const app = express()
app.use(cors())
app.use(express.json());


const DB="mongodb+srv://mohsin:123@cluster0.xgm3y.mongodb.net/google_docs_clone";
mongoose.connect(DB).then(()=>{
    console.log('Connection Success')
}).catch((error)=>{
    console.log(error)
})

app.get('/',(req,res)=>{
    res.send('aaaaaa')
})



const authRouter = require('./routes/auth');
app.use('/auth',authRouter);

const documentRoutes = require('./routes/documents');
app.use('/document',documentRoutes);
app.listen(PORT,"0.0.0.0",()=>{
console.log(`Server is running onaa ${PORT}`)
})