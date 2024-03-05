const express = require("express");
const router = express.Router();
const { ObjectId } = require('mongodb');
const mongoose = require('mongoose');

const randomNames = require('./random_names');

const {
 
    Client,Antecedent,Treatement
    

} = require('../models');
const delay = (delayInms) => {
    return new Promise(resolve => setTimeout(resolve, delayInms));
  };
  

  var queryGlobal = {};
  var sortingGlobal = {}
  var isOne = 1;
router.get('/',async(req,res)=>{

  try{
     var searchString = req.query.searchString;
     var villes = req.query.ville ;  // [oran , alger];
      var sort = req.query.sort;
      var isInWaitingRoom = req.query.isInWaitingRoom;
      var lookUpSettings = req.query.lookUpSettings;
     
      var query = {};
  var sorting = {};
    if(isInWaitingRoom){
      
      query.isInWaitingRoom = { $in: isInWaitingRoom };
    }
    if(sort){

 /*   if (villes) {
      
 const villeArray = Array.isArray(villes) ? villes : [villes];

 // Add the 'ville' array to the query using $in operator
 query.ville = { $in: villeArray };
}*/
     sorting = {[sort]:isOne};
      //sorting.sort = isOne;
      if(isOne ==1){
        isOne =-1
      }else{
        isOne= 1
      }
      if(sort === 'appointements'){
    
      /*  query.appointement = { '$exists': true };
        query.appointement = { '$ne': null };*/
        query.$and = [
          ...(query.$and || []),
          { appointement: { $ne: null } }
        ];
        sorting = {'appointement':1}
      }else if(sort === 'date'){
        sorting = {'date':-1}
      }
      
    }
 
    if (searchString && lookUpSettings) {
      const regex = new RegExp(`^${searchString}`, 'i');

      // Use the $or array with a single field based on lookUpSettings
      query.$and = [
        ...(query.$and || []),
        { [lookUpSettings]: { $regex: regex } }
      ];
    
  }


    queryGlobal=query
    sortingGlobal = sorting
  /*  var query = {
      'appointements.date': {'\$exists': true}
    };*/
  // var clients = await Client.find(query).sort({'appointements.date':-1});
 // console.log("QQQQQQQQQQQQQQQQQQ");
console.log(`query ${query}`);
console.log(query);
   var clients = await Client.find(query).sort(sorting);

    updatedClients = await sortC(clients);
//console.log("UPDAATED CLIENTS");
//console.log(updatedClients);
      // await Antecendet.find({_id:req.query.id});
    
    return res.json(updatedClients);

  }catch(e){
    console.error(e);
    return res.status(500).json({ error: 'Internal Server Error' });
  }


})

/*router.get('/',async(req,res)=>{
    try {
      const villes = req.query.ville; // Get the 'ville' query parameter from the request
    let query = {};

    if (villes) {
      // If 'ville' parameter is provided, create an array of villes
      const villeArray = Array.isArray(villes) ? villes : [villes];

      // Add the 'ville' array to the query using $in operator
      query.ville = { $in: villeArray };
    }
    const nameStartLetters = req.query.searchLookUp; // Get the 'nameStartLetters' query parameter
  
    if (nameStartLetters) {
      console.log(nameStartLetters);
      // If 'nameStartLetters' parameter is provided, use $regex to search for names starting with specific letters
      query.$or = [
        { name: { $regex: `^${nameStartLetters}`, $options: 'i' } },
        { familyName: { $regex: `^${nameStartLetters}`, $options: 'i' } },
      ];
    }

    const clients = await Client.find().sort({ date: -1 });
     
       
        return res.json(clients);
      } catch (error) {
        console.error(error);
        return res.status(500).json({ error: 'Internal Server Error' });
      }
  
})*/

router.get('/delete/:id',async(req,res)=>{

   var id = req.params.id;

    try{
         const client =await Client.deleteOne({_id: id})
   
        const clients = await Client.find(queryGlobal).sort(sortingGlobal);
      
        return res.status(200).json(clients);
      
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
    const randomIndex = Math.floor(Math.random() * randomNames.length);
    const randomIndex2 = Math.floor(Math.random() * randomNames.length);

   
    const defaultClient = new Client({ date: new Date(),name:randomNames[randomIndex] ,familyName:randomNames[randomIndex2]});
  
    await defaultClient.save();
   // const client = await defaultClient.save();
   const clients = await Client.find({ }).sort({date:-1});
  
    return res.status(200).json(clients);
  }catch(e){
    console.log(`e ${e}`);
    return res.status(404).json(e);
}

   

})
router.post('/edit', async (req, res) => {
  try {
    var data = req.body;
  
    data.antecedents.forEach(antecedent => {
      delete antecedent.title;
  
      var antecedentHistory = antecedent.history;
  
      var newDate = new Date();
      var timestamp = newDate.getTime().toString();
      
      var newHistoryObj = {'date':timestamp,'value':antecedent.value,'_id':new ObjectId().toString()};
      if(antecedentHistory != null){
        if(antecedentHistory.length > 0){
          if(antecedentHistory[antecedentHistory.length-1].hasOwnProperty('value')){
            if(  antecedentHistory[antecedentHistory.length-1].value.toString() !== antecedent.value.toString() && antecedent.value.toString() !== '' ){ //means we got a new value
             
               antecedent.history.push(newHistoryObj);
             }
          }
        }else if(antecedent.value.toString() !== ''){
          antecedent.history.push(newHistoryObj);
        }
       
       
      }
    });

     
   

    
    await Client.findByIdAndUpdate({ _id: data._id }, { ...data });

    const clients = await Client.find(queryGlobal).sort(sortingGlobal); 
  // var clients = await Client.find(query).sort({ 'appointements.date': 1}); //no sorting here

    updatedClients =  await sortC(clients);
    return res.status(200).json(updatedClients);
  } catch (error) {
    console.error(error);
    return res.status(500).send('Internal Server Error');
  }
});


async function sortC(clients){

  const updatedClients = await Promise.all(clients.map(async (client) => {
    const antecedents = client.antecedents;
    const visits = client.visits;

    const updatedVisits = await Promise.all(visits.map(async (visit) => {
      var visitTreat = visit.treatements;
    
      const updatedTreatements = await Promise.all(visitTreat.map(async (treat) => {
        if (mongoose.Types.ObjectId.isValid(treat._id)) {
          const foundTreatement = await Treatement.findById(treat._id);
          if (foundTreatement) {
            // Update the treatement's name in the visit
            treat.name = foundTreatement.name;
            treat.price= foundTreatement.price;
          } else {
            // Handle the case when treatement is not found
            // For example, you may choose to log an error or take appropriate action
          }
        }
    
        return treat;
      }));
    
      // Update the treatements array in the visit
      visit.treatements = updatedTreatements;
    
      return visit;
    }));

    const updatedAntecedents = await Promise.all(antecedents.map(async (antec) => {
      if (mongoose.Types.ObjectId.isValid(antec._id)) {
        const Antecedents = await Antecedent.findById(antec._id);
        if (Antecedents) {
          antec.title = Antecedents.title;
        } else {
        
          const clientToUpdate = await Client.findById(client._id);

  // Filter out the antecedent to be removed
  const updatedAntecedents = clientToUpdate.antecedents.filter(antecedent => antecedent._id.toString() !== antec._id);

  // Update the client with the new antecedents array
  clientToUpdate.antecedents = updatedAntecedents;



  // Save the updated client
  await clientToUpdate.save();
        
    
          return null;
        }
      }

      return antec;
    }));

    // Filter out null values (antecedents that don't exist)
    const filteredAntecedents = updatedAntecedents.filter(antec => antec !== null);

    return {
      ...client.toObject(),
      antecedents: filteredAntecedents,
      visits:updatedVisits
    };
  }));
  return updatedClients;
}

module.exports = router;