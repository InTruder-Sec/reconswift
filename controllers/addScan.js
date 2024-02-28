import {
  SQS,
  paramsSendMessage,
  scanStatus,
  paramsRecieveMessage,
} from "./../index.js";
import ScansData from "../model/UserScans.js";
import startScan from "./startScan.js";

export default async function addScan(req, res) {
  const id = req.query.id;

  if (!id) {
    return res.status(400).json({ message: "Missing id" });
  }

  const details = await ScansData.findOne({
    _id: id,
  });
  if (details) {
    // See if scan is currently running, if yes add the scan to the queue
    if (scanStatus.status) {
      // Add to queue
      console.log("Adding to queue");
      SQS.sendMessage(
        {
          MessageBody: JSON.stringify({
            target: details.url,
            scanId: id,
          }),
          QueueUrl: process.env.AWS_SQS_URL,
          MessageGroupId: "scan-group",
        },
        (err, data) => {
          if (err) {
            console.log("Error", err);
            return res.status(500).json({ message: "Internal server error" });
          }
          console.log("Success", data.MessageId);
          return res.status(200).json({ message: "Scan added to queue" });
        }
      );
    } else {
      // Call startScan with details
      console.log("Starting scan");
      startScan(details);
      res.json({ message: "Scan started" });
    }
  } else {
    return res
      .status(404)
      .json({ message: "Something went wrong! Please try again." });
  }
}
