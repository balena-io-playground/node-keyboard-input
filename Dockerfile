FROM resin/raspberrypi3-node:6-slim

RUN apt-get update && apt-get install -yq \
    python build-essential libusb-1.0-0-dev \
    libudev-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

COPY package.json package.json

RUN JOBS=MAX npm install -g node-gyp
RUN JOBS=MAX npm install node-hid --build-from-source
RUN JOBS=MAX npm install --production --unsafe-perm && npm cache clean && rm -rf /tmp/*

COPY . ./

CMD ["npm", "start"]
