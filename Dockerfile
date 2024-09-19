FROM kalilinux/kali-rolling

RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y sublist3r golang nodejs npm

RUN apt-get install curl host -y

ENV GOPATH=/root/go PATH=$PATH:/root/go/bin

RUN go install github.com/tomnomnom/httprobe@latest && \
    cp /root/go/bin/httprobe /usr/bin/httprobe

WORKDIR /reconswift

COPY . /reconswift

RUN npm install

EXPOSE 80 443

CMD ["npm", "start"]
