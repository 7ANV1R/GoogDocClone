const express = require("express");
const User = require("../model/user_model");
const jwt = require('jsonwebtoken');
const authMid = require("../middlewares/auth_mid");

const authRouter = express.Router();

authRouter.post("/api/signup", async (req, res) => {
 try {
  const { email, name, profilePic } = req.body;
  let user = await User.findOne({ email });
  if (!user) {
   user = new User({ email, name, profilePic });
   user = await user.save();
  }

  const token = jwt.sign({ id: user._id }, "passKey")

  res.json({ user, token });
 } catch (error) {
  console.log(error);
 }
});

authRouter.get('/user', authMid, async (req, res) => {
 const user = await User.findById(req.user);
 res.json({ user, token: req.token });


});

authRouter.get("/", (req, res) => {
 try {


  res.status(200).send('Hello');
 } catch (error) {
  res.status(500).send({ "msg": error });
  console.log(error);
 }
});
module.exports = authRouter;