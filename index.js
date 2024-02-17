import express from "express";
import mongoose from "mongoose";
import dotenv from "dotenv";
import cors from "cors";
import endpoints from "./routes.js";

dotenv.config();
const app = express();

const corsOptions = {
  origin: "http://localhost:3000",
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

app.listen(process.env.PORT || 8080, () => {
  console.log(`Server running on port ${process.env.PORT || 8080}`);
});
