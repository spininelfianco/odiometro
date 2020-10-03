## Dockerfile for building development image
FROM node:14.12-alpine3.12
LABEL maintainer "Igor Pellegrini <igor.pellegrini@live.com>"

USER node

ENV NODE_ENV=development \
    PORT=3000

# Install system dependencies
# bzip2 to install phantomjs; bash to run entrypoint
USER root
RUN apk update && apk add --no-cache --upgrade bash bzip2

WORKDIR /home/node/app
RUN chown node:node -R /home/node/app

# Install application
USER node

# copy installation manifests fist (to allow caching NPM installation)
COPY --chown=node:node ./package.json /home/node/app/package.json
COPY --chown=node:node ./public/package.json /home/node/app/public/package.json
RUN npm install
RUN cd public && npm install

# copy the rest of the application code
COPY --chown=node:node . /home/node/app

RUN chmod +x entrypoint.sh

# RUN ./home/node/app/public/node_modules/grunt/bin/grunt

# set user to run NPM scripts
# USER root
# RUN npm config set user node

# USER node

EXPOSE 3000

ENTRYPOINT ["/home/node/app/entrypoint.sh"]
CMD ["/home/node/app/entrypoint.sh", "npm", "start"]
