const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const authRouter = require('./routes/auth_api');
const docRouter = require('./routes/doc_api');
require("dotenv").config();


const PORT = process.env.PORT || 3001;

const app = express();


// middleware
app.use(cors());
app.use(express.json());
app.use(authRouter);
app.use(docRouter);

const DBurl = process.env.DB_URL;

mongoose.connect(DBurl).then(() => {
 console.log("yoo beautifully onnected with mongodb");
});


app.listen(PORT, "0.0.0.0", () => {
 console.log(`server is up and running at port ${PORT}`);
});