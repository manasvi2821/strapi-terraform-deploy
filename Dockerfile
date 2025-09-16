FROM node:18-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install --production

COPY . .

RUN npm run build

ENV NODE_ENV=production
ENV PORT=1337

EXPOSE 1337

CMD ["npm","run", "develop"]