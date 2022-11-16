const mongoose = require("mongoose");

const docSchema = mongoose.Schema({
 uid: {
  type: String,
  required: true,
 },
 createdAt: {
  type: Number,
  required: true,
 },
 createdAt: {
  type: String,
  required: true,
  trim: true,
 },
 content: {
  type: Array,
  default: [],
 },
});

const Document = mongoose.model("Document", docSchema);

module.exports = Document;
