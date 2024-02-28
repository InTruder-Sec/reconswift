import express from "express";
import addScan from "./controllers/addScan.js";
import deleteMessage from "./controllers/deleteQueue.js";
import completeScan from "./controllers/completeScan.js";

const endpoints = express.Router();

endpoints.get("/scanqueue", addScan);
endpoints.get("/delete", deleteMessage);
endpoints.get("/completescan", completeScan);

export default endpoints;
