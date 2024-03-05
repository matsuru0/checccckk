const express = require("express");
const router = express.Router();


const {
 
   Treatement
    

} = require('../models');

router.get('/',async(req,res)=>{

    try{
       
        const Treatements = await Treatement.find({}).sort({date:-1});
        
        console.log(Treatements);
      return res.json(Treatements);

    }catch(e){
      console.error(e);
      return res.status(500).json({ error: 'Internal Server Error' });
    }
  
  
  })


module.exports = router;