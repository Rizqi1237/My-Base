FROM nikolaik/python-nodejs:latest

RUN apt-get update && \
  apt-get install -y \
  neofetch \
  chromium \
  ffmpeg \
  wget \
  mc \
  imagemagick && \
  rm -rf /var/lib/apt/lists/*

COPY package.json .
RUN npm install -g npm@latest
RUN npm install
RUN npm instal pm2 -g
RUN npm install ytdl-core@latest
RUN npm install yt-search@latest
#RUN npm install -g npm-check-updates
#RUN ncu --upgrade
ENV PM2_PUBLIC_KEY hh73adnvlt9kan1
ENV PM2_SECRET_KEY p0d57w4v1swtkx5

RUN mkdir /My-Base
WORKDIR /My-Base
COPY . /My-Base
RUN python3 -m pip install -r /My-Base/requirements.txt
ENV TZ=Asia/Jakarta
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN ls

EXPOSE 5000

CMD ["pm2-runtime", "index.js"]`
