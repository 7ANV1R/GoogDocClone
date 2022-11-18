const express = require("express");
const Document = require("../model/document_model");
const auth = require("../middlewares/auth_mid");

const docRouter = express.Router();


// create doc

docRouter.post("/doc/create", auth, async (req, res) => {
 try {
  const { createdAt } = req.body;
  let doc = new Document({
   uid: req.user,
   title: "Untitled Document",
   createdAt,
  });

  doc = await doc.save();
  res.json(doc);
 } catch (error) {
  res.status(500).send({ msg: error });
  console.log(error);
 }
});


// all documents

docRouter.get("/doc/u/all", auth, async (req, res) => {
 try {
  let doc = await Document.find({ uid: req.user })

  res.json(doc);

 } catch (error) {
  res.status(500).send({ msg: error });
  console.log(error);
 }
});

docRouter.get("/doc/:id", auth, async (req, res) => {
 try {
  const doc = await Document.findById(req.params.id);


  res.json(doc);

 } catch (error) {
  res.status(500).send({ msg: error });
  console.log(error);
 }
});

// change title

docRouter.post("/doc/title", auth, async (req, res) => {

 try {
  const { id, title } = req.body;
  const document = await Document.findByIdAndUpdate(id, { title });
  res.json(document);

 } catch (error) {
  res.status(500).send({ msg: error });
  console.log(error);
 }
});

module.exports = docRouter;
