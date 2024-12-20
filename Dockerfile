# Use the Kali Linux base image
FROM kalilinux/kali-rolling

# Update the package list and upgrade all packages
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y sublist3r golang nodejs npm curl host

# Set up Go environment variables
ENV GOPATH=/root/go PATH=$PATH:/root/go/bin

# Install httprobe using Go
RUN go install github.com/tomnomnom/httprobe@latest && \
    cp /root/go/bin/httprobe /usr/bin/httprobe

# Clone the repository
RUN git clone https://github.com/InTruder-Sec/reconswift /reconswift

# Set the working directory
WORKDIR /reconswift

# Install Node.js dependencies
RUN npm install

# Set environment variables
ENV AWS_ACCESS_KEY=REDACTED \
    AWS_SECRET_KEY=REDACTED \
    AWS_SQS_URL=REDACTED \
    PORT=5000 \
    DATABASE_URI=mongodb+srv://REDACTED:REDACTED@REDACTED.mongodb.net/?retryWrites=true&w=majority&appName=ReconSwift \
    CLOUD_NAME=REDACTED \
    CLOUDINARY_URL=REDACTED \
    CLOUD_API_KEY=REDACTED \
    CLOUD_API_SECRET=REDACTED

# Expose necessary ports
EXPOSE 80 443

# Start the application
CMD ["npm", "start"]
