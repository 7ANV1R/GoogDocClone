const express = require("express");
const Document = require("../model/document_model");
const auth = require("../middlewares/auth_mid");

const docRouter = express.Router();

docRouter.post("/doc/create", auth, async (req, res) => {
 try {
  const { createdAt } = req.body;
  let doc = new Document({
   uid: req.user,
   title: 'Untitled Document',
   createdAt,
  });

  doc = await doc.save();
  res.json(doc);
 } catch (error) {
  res.status(500).send({ msg: error });
  console.log(error);
 }
});


module.exports = docRouter;
