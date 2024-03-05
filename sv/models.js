const mongoose = require('mongoose');


const ClientSchema = new mongoose.Schema({
  
    name: {
      type: String,
      default:'temp'
    },
    familyName:{
      type:String,
      default:'temp'
    },
    phone:{
      type:String,
      default:'temp'
    },
    age:{
      type:Number,
      default:0
    },
    lastVisit:{
      type:String,
      default:'temp'
    },
    ville:{
      type:String,
      default:'temp'
    },
    antecedents:{
      type:Array
    },
    ordonnances:{
      type:Array
    },
     appointements:{
      type:Map
    },
    date:{
      type:Date,
     
    },
    isInWaitingRoom:{
      type:Boolean,
      default:false,
    },
    visits:{
      type:Array,
      default:[]
    }
    ,isAman:{
      type:Boolean,
      default:false,
    },
    birthdayDate:{
      type:String,
      default:null
    },
    appointement:{
      type:Number,
      default:null
    },
    assurance:{
      type:String
    },
    address:{
      type:String,
    },
    addressEmail:{
      type:String
    },
    consultations:{
      type:Array // list of treatement [{id: , date: },[{id: , date: }]
    } ,
    treatements:{
      type:Array,
    }
 
  });
  const AntecedentScheme = new mongoose.Schema({
    title: {
      type: String,
      default:'temp'
    },
    date:{
      type:Date,
    },
   

  });

  const TreatementScheme = new mongoose.Schema({
    name:{
      type:String,
      default:''
    },
    price:{
      type:Number,
      
    }
   

  });
  const Antecedent = mongoose.model('Antecedents',AntecedentScheme)
  const Client = mongoose.model('Clients', ClientSchema);
  const Treatement = mongoose.model('Treatements', TreatementScheme);

  module.exports = {
    Antecedent,
    Treatement,
    Client,
  
  };
  