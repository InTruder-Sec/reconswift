import ScansData from "../model/UserScans.js";
import startScan from "./startScan.js";
import cloudinary from "cloudinary";
import { exec } from "child_process";


const completeScan = async (req, res) => {
  cloudinary.v2.config({
    cloud_name: process.env.CLOUD_NAME,
    api_key: process.env.CLOUD_API_KEY,
    api_secret: process.env.CLOUD_API_SECRET,
  });
  const Id = req.query.Id;
  console.log(Id);
  //   Upload file
  const report = "$basepath/report/report.txt";
  // const file = fs.readFileSync(report);
  cloudinary.v2.uploader
    .upload(report, {
      resource_type: "raw",
      public_id: `reports/${Id}`,
      overwrite: true,
    })
    .then(async (result) => {
      console.log(result);
      exec(`rm -rf $basepath/report`);
      await ScansData.findOneAndUpdate(
        { scanId: Id },
        { scanStatus: "Completed", reportUrl: result.url }
      );
      startScan();
      res.json({ message: "Scan completed" });
    })
    .catch((error) => {
      console.log(error);
      res.status(500).json({ message: "Internal server error" });
    });
};

export default completeScan;
