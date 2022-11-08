const express = require("express");
const User = require("../model/user_model");

const authRouter = express.Router();

authRouter.post("/api/signup", async (req, res) => {
 try {
  const { email, name, profilePic } = req.body;
  let user = await User.findOne({ email });
  if (!user) {
   user = new User({ email, name, profilePic });
   user = await user.save();
  }

  res.json({ user });
 } catch (error) {
  console.log(error);
 }
});

authRouter.get("/api/welcome", (req, res) => {
 try {


  res.status(200).send('Hello');
 } catch (error) {
  console.log(error);
 }
});
module.exports = authRouter;