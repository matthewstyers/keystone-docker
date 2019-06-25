# uses an alpine linux image with node/npm pre-installed
FROM mhart/alpine-node:11

# copy files
COPY ./keystone/.babelrc /app/keystone/.babelrc
COPY ./keystone/build.js /app/keystone/build.js
COPY ./keystone/index.js /app/keystone/index.js
COPY ./keystone/package.json /app/keystone/package.json
 
# copy dirs
COPY ./keystone/admin /app/keystone/admin
COPY ./keystone/fields /app/keystone/fields
COPY ./keystone/lib /app/keystone/lib
COPY ./keystone/server /app/keystone/server
COPY ./keystone/templates /app/keystone/templates


# on build, the working directory will be /app/keystone
WORKDIR /app/keystone

# adds the bare necessities to run npm and installs node_modules
RUN apk add --no-cache make gcc g++ git python krb5-dev && \
npm i && \
npm run build && \
rm -rf node_modules

# on build, /app/keystone on this image (i.e. this directory) will
# be mapped to the dependent image at the same location
VOLUME /app/keystone