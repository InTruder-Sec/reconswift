import express from "express";
import addScan from "./controllers/addScan.js";

const endpoints = express.Router();

endpoints.get("/scanqueue", addScan);

export default endpoints;
