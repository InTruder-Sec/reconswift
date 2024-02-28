import { SQS, paramsRecieveMessage } from "../index.js";

const deleteMessage = () => {
  SQS.receiveMessage(paramsRecieveMessage, (err, data) => {
    if (err) {
      console.log("Error", err);
    } else {
      SQS.deleteMessage(
        {
          QueueUrl: process.env.AWS_SQS_URL,
          ReceiptHandle: data.Messages[0].ReceiptHandle,
        },
        (err, data) => {
          if (err) {
            console.log("Error", err);
          } else {
            console.log("Success", data);
          }
        }
      );
    }
  });
};

export default deleteMessage;
