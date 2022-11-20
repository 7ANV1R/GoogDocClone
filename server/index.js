const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const http = require("http");
const authRouter = require("./routes/auth_api");
const docRouter = require("./routes/doc_api");
const Document = require("./model/document_model");
require("dotenv").config();

const PORT = process.env.PORT || 3001;

const app = express();
var server = http.createServer(app);
var io = require("socket.io")(server);

// middleware
app.use(cors());
app.use(express.json());
app.use(authRouter);
app.use(docRouter);

const DBurl = process.env.DB_URL;

mongoose.connect(DBurl).then(() => {
 console.log("yoo beautifully onnected with mongodb");
});

io.on("connection", (socket) => {
 console.log("connection opened");
 socket.on("join", (documentId) => {
  socket.join(documentId);
  console.log("joineddddddd");
 });

 socket.on("typing", (data) => {
  socket.broadcast.to(data.room).emit("changes", data);
 });
 socket.on("save", (data) => {
  saveData(data);
 });
});

const saveData = async (data) => {
 let document = await Document.findById(data.room);
 document.content = data.delta;
 document = await document.save();
};

server.listen(PORT, "0.0.0.0", () => {
 console.log(`server is up and running at port ${PORT}`);
});
