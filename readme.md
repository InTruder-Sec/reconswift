# Reconswift Backend 

Bash script behind the Reconswift tool. A automated security reconnaissance framework that reduces manual effort for security researchers enumerating IP addresses and active subdomains 50% more accuretly. This is a multi-repo project and the independent NextJS frontend can be found [here](https://github.com/InTruder-Sec/reconswift-tool). The project uses Bash and AWS SQS for efficient scan management.

#### Back-End

> [!IMPORTANT]  
> You will require a `.env.local` file with the following values

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

> [!TIP]  
> We also have a docker environment available for backend.

```
docker build reconswift:v1 .
docker run -p 80:80 -p 443:443 reconswift:v1
```

#### Start Commands:

> [!WARNING]  
> Some tools require root privileges.
> 
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
