import express from "express";
import mongoose from "mongoose";
import dotenv from "dotenv";
import cors from "cors";
import endpoints from "./routes.js";
import AWS from "aws-sdk";
import https from "https";
import fs from "fs";

dotenv.config();
const app = express();

let scanStatus = {
  status: false,
};

const SQS = new AWS.SQS({
  apiVersion: "2012-11-05",
  region: "ap-south-1",
  accessKeyId: process.env.AWS_ACCESS_KEY,
  secretAccessKey: process.env.AWS_SECRET_KEY,
});

const paramsSendMessage = {
  MessageBody: JSON.stringify({
    type: "event-live-status",
  }),
  QueueUrl: process.env.AWS_SQS_URL,
};

const paramsRecieveMessage = {
  QueueUrl: process.env.AWS_SQS_URL,
  WaitTimeSeconds: 0,
};

const corsOptions = {
  origin: "https://reconswift.vercel.app",
  credentials: true,
};

app.use(cors(corsOptions));

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Use the routers
app.use("/api/v1", endpoints);


await mongoose.connect(process.env.DATABASE_URI).catch((error) => {
  console.error("Error connecting to the database: ", error);
});

// Https server

const certKey = fs.readFileSync('./private.key');
const certi = fs.readFileSync('./certificate.crt')

const httpsServer = https.createServer({
	key: certKey,
	cert: certi
}, app);

httpsServer.listen(443, () => {
    console.log('HTTPS Server running on port 443');
});


app.listen(process.env.PORT || 8080, () => {
  console.log(`Server running on port ${process.env.PORT || 8080}`);
});

export { scanStatus, SQS, paramsSendMessage, paramsRecieveMessage };
