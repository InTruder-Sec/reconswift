import ScansData from "../model/UserScans.js";
import startScan from "./startScan.js";
import cloudinary from "cloudinary";
import { exec } from "child_process";
import { globalStartTime } from "./startScan.js";
import fs from "fs";
import UserData from "../model/UserSchema.js";

const completeScan = async (req, res) => {
  const endTime = new Date().getTime();
  // get the time difference in minutes

  const timeTaken = Math.ceil((endTime - globalStartTime) / 60000);

  cloudinary.v2.config({
    cloud_name: process.env.CLOUD_NAME,
    api_key: process.env.CLOUD_API_KEY,
    api_secret: process.env.CLOUD_API_SECRET,
  });
  const Id = req.query.Id;
  console.log(Id);
  console.log("Uploading file!");
  //   Upload file
  const report = ".temp/report/report.txt";
  console.log(process.cwd());
  const file = fs.readFileSync(report);
  cloudinary.v2.uploader
    .upload(report, {
      resource_type: "raw",
      public_id: `reports/${Id}`,
      overwrite: true,
    })
    .then(async (result) => {
      console.log(result, "Report uploaded");
      exec(`rm -rf ./.temp/report`);
      console.log("File deleted");
      const scanData = await ScansData.findOneAndUpdate(
        { scanId: Id },
        { scanStatus: "Completed", reportUrl: result.url }
      );
      // find the user by scanId and add scanTime to previous scanTime
      const updateTime = await UserData.findOneAndUpdate(
        { scanHistory: scanData._id },
        { $inc: { scanTime: timeTaken } }
      );
      console.log(updateTime);

      startScan();
      res.json({ message: "Scan completed" });
    })
    .catch((error) => {
      console.log(error);
      res.status(500).json({ message: "Internal server error" });
    });
};

export default completeScan;
