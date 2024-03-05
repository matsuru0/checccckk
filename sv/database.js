const mongoose = require('mongoose');

async function connectDatabase() {
  try {
    await mongoose.connect('mongodb://127.0.0.1:27017/medapp', {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    console.log("Connected to MongoDB database!");
  } catch (error) {
    console.error("Error connecting to the database:", error);
    throw error;
  }
}

module.exports = {
  connectDatabase,
};