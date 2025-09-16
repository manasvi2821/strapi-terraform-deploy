FROM node:18-bullseye-slim

# set workdir
WORKDIR /srv/app

# install dependencies

COPY package*.json ./
RUN apt-get update && apt-get install -y python3 build-essential && npm install --legacy-peer-deps

# copy code and build admin panel

COPY . .
RUN npm run build

# expose port and start app

EXPOSE 1337
CMD ["npm", "start"]
