const express = require('express');
const mongoose = require('mongoose');
require("dotenv").config();


const PORT = process.env.PORT || 3001;

const app = express();

const DBurl = process.env.DB_URL;

mongoose.connect(DBurl).then(() => {
 console.log("Connected with mongodb");
});


app.listen(PORT, "0.0.0.0", () => {
 console.log(`connected at port ${PORT}`);
});