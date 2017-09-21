# uses an alpine linux image with node/npm pre-installed
FROM mhart/alpine-node:latest

# adds current directory to image at /app/keystone
ADD ./keystone /app/keystone

# issues some final instructions to prep for build
# on build, the working directory will be /app/keystone
WORKDIR /app/keystone

# on build, /app/keystone on this image (i.e. this directory) will
# be mapped to the dependent image at the same location
VOLUME /app/keystone

# adds some instructions to execute at the beginning of the dependent image's
# build process.
# At build time, we'll pull down the minimum system modules required to execute
# keystone's pre/post install scripts. Then, we'll install keystone and create a
# link we reference when building the dependent image.


ONBUILD RUN apk add --no-cache make gcc g++ python && \
npm i && \
npm run build && \
npm link
