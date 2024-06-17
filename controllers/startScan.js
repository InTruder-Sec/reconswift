import { exec } from "child_process";
import { SQS, paramsRecieveMessage, scanStatus } from "./../index.js";
import ScansData from "../model/UserScans.js";
import UserData from "../model/UserSchema.js";

let globalStartTime;

const startScan = async (data) => {
  console.log(data);
  if (data !== undefined) {
    scanStatus.status = true;
    const updateStatus = await ScansData.updateMany(
      { scanStatus: "Running" },
      { scanStatus: "Failed" }
    );

    const update = await ScansData.findOneAndUpdate(
      { scanId: data.scanId },
      { scanStatus: "Running" }
    );
    let url = data.url.split("//");
    const query = `./utils/script.sh ${url[1]} ${data.scanType} ${data.scanId}`;
    console.log(query);
    globalStartTime = new Date().getTime();

    const execution = exec(query);
    execution.stdout.on("data", function (data) {
      console.log(data);
    });



  } else {
    SQS.receiveMessage(paramsRecieveMessage, async (err, data) => {
      if (err) {
        console.log("Error", err);
      } else {
        if (data.Messages.length === 0) {
          scanStatus.status = false;
        } else {
          const body = await JSON.parse(data?.Messages[0]?.Body);
          SQS.deleteMessage(
            {
              QueueUrl: process.env.AWS_SQS_URL,
              ReceiptHandle: data.Messages[0].ReceiptHandle,
            },
            async (err, data) => {
              if (err) {
                console.log("Error", err);
              } else {
                console.log(body.scanId);
                const updateStatus = await ScansData.updateMany(
                  { scanStatus: "Running" },
                  { scanStatus: "Failed" }
                );
                const scan = await ScansData.findOneAndUpdate(
                  { _id: body.scanId },
                  { scanStatus: "Running" }
                );
                console.log(scan);
                scanStatus.status = true;
                let url = scan.url.split("//");
                const query = `./utils/script.sh ${url[1]} ${scan.scanType} ${scan.scanId}`;
                console.log(query);
                globalStartTime = new Date().getTime();
                
                const execution = exec(query);
                execution.stdout.on("data", function (data) {
                  console.log(data);
                });
              }
            }
          );
        }
      }
    });
  }
};

export default startScan;
export { globalStartTime}