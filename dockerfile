FROM node:20.9.0-slim

WORKDIR /usr/src/app
COPY . .

RUN npm install
RUN npm run build

EXPOSE 3100
CMD [ "npm", "run", "start" ]