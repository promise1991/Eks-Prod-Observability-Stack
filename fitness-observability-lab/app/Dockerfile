FROM public.ecr.aws/docker/library/node:18-alpine
WORKDIR /app
COPY package.json ./
RUN npm install --omit=dev
COPY build ./build
COPY server ./server
EXPOSE 80
CMD ["node", "server/index.js"]
