# reconswift

Bash script behind the Reconswift tool. Discover Assess and Secure Test the Web Safely with ReconSwift. ReconSwift the automated reconnaissance platform serves as an indispensable tool for bug bounty hunters by streamlining and expediting the initial phase of their security assessments.

**Front-End**

Please reffer https://github.com/InTruder-Sec/reconswift-tool

**Back-End**

_⚠️Note: You will require a `.env` file with the following values_

```
AWS_ACCESS_KEY=REDACTED
AWS_SECRET_KEY=REDACTED
AWS_SQS_URL=REDACTED
PORT=5000
DATABASE_URI=mongodb+srv://REDACTED:REDACTED@REDACTED.mongodb.net/?retryWrites=true&w=majority&appName=ReconSwift
CLOUD_NAME=REDACTED
CLOUDINARY_URL=REDACTED
CLOUD_API_KEY=REDACTED
CLOUD_API_SECRET=REDACTED
```

Start Commands:

_⚠️Note: We also have docker environment for the server!_

```
docker pull intrudersecurity/reconswift-server
docker run -p 80:80 -p 443:443 intrudersecurity/reconswift-server:v1
```

_⚠️Note: Some tools requires root previllages to run!_

```
sudo npm run preinstall
npm install
sudo npm start
```

### 🏗️ Project Architecture

<img width="100%" height="100%" src="https://lucid.app/publicSegments/view/ea3333a7-fca1-4b65-a6bc-e6c448db1876/image.png"/>

### 🛠️ Tech-Stack

> NODE, EXPRESS, MONGODB, AZURE CLOUD, BASH

### 🚀 Contribution Guidelines

I would ❤️ you to contribute to the Playifiyi and help make it better! Let's make open source contributing to be fun, enjoyable, and educational for anyone and everyone. All contributions are welcome, including issues, updates and more.
