
FROM node:alpine
COPY ./ ./
RUN npm install
EXPOSE 8089
CMD ["npm", "start"]
