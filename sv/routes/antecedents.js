const express = require("express");
const router = express.Router();
const { ObjectId } = require('mongodb');
const mongoose = require('mongoose');

const {
 
   Antecedent
    

} = require('../models');

router.get('/',async(req,res)=>{

    try{
       
        const antecedents = await Antecedent.find({}).sort({date:-1});
        
        console.log(antecedents);
      return res.json(antecedents);
  
    }catch(e){
      console.error(e);
      return res.status(500).json({ error: 'Internal Server Error' });
    }
  
  
  })

  router.post('/edit',async(req,res)=>{
    var data = req.body; // hna gla3 title;
  

    
 

    try{
       
       await Antecedent.findByIdAndUpdate({_id:data._id},{...data});
      const antecedents = await Antecedent.find({}).sort({date:-1});
     
    return res.json(antecedents);

  }catch(e){
    console.error(e);
    return res.status(500).json({ error: 'Internal Server Error' });
  }
})


router.get('/delete/:id',async(req,res)=>{

  var id = req.params.id;
 
   try{
   await Antecedent.deleteOne({_id: id})
      
       const antecedents = await Antecedent.find({}).sort({date:-1});

       return res.status(200).json(antecedents);
     
   }catch(e){
       console.log(`e ${e}`);
       return res.status(404).json(e);
   }
   
   
 //  return res.status('200').json(clients);
 
})
  
router.get('/add',async(req,res)=>{

  // const client = await Client.insertMany({...data})
/*   const defaultClient = new Client(data);
   const client = await Client.insertMany([{...defaultClient._doc}], { position: 0 });*/
 try{

  
   const DefaultAntecedent = new Antecedent({ date: new Date()});
 
   await DefaultAntecedent.save();
   console.log(DefaultAntecedent);
  // const client = await defaultClient.save();
  const antecedents = await Antecedent.find({ }).sort({date:-1});
 
   return res.status(200).json(antecedents);
 }catch(e){
   console.log(`e ${e}`);
   return res.status(404).json(e);
}

  

})
module.exports = router;