
const express = require("express");
const app = express();
const cors = require('cors') 
const clientsRouter = require('./routes/clients');
const antecedentsRouter = require('./routes/antecedents');
const treatementsRouter = require('./routes/treatements');
const {connectDatabase} = require('./database');

app.use(express.json());
app.use(express.urlencoded({extended: false}));


console.log(cors);

  
app.use(cors()) 
  

async function startServer() {
    try {
        await connectDatabase(); 
       
        setupRoutes();
        app.listen(5000, () => {
            console.log("Server app listening on port 5000");
        });
    } catch (error) {
        console.error("Error starting the server:", error);
        process.exit(1); 
    }
}
function setupRoutes() {
  
    app.use('/api/clients', clientsRouter);
     
    app.use('/api/antecedents', antecedentsRouter);
    app.use('/api/treatements', treatementsRouter);
    /*app.use('/api/foods', foodsRouter);
    app.use('/uploads', uploadRouter);
    app.use('/temp', express.static(path.join(__dirname, 'temp')));
    app.use('/uploads', express.static(path.join(__dirname, 'uploads')));*/

}

startServer();