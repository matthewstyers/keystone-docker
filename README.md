## Migrating to 4.0.0-rc.0

1. Make the following changes in the project-level Dockerfile:

> **NOTE:** non-changing lines may be different from project to project. Only make changes as noted by diffs.
```diff
- FROM styers/keystone:4.0.0-rc.0
+ FROM styers/keystone:4.0.0-beta.8.0.1

ADD ./src /app/server
COPY ./package.json /app/server/package.json

RUN npm i -g forever && \
cd /app && \
cp server/package.json . && \
- npm i && \
- npm link keystone && \
+ npm i

+ # Only copy over the node pieces we need from the above image
+ FROM alpine:3.6
+ COPY --from=0 /usr/bin/node /usr/bin/forever /usr/bin/
+ COPY --from=0 /usr/lib/node_modules /usr/lib/libgcc* /usr/lib/libstdc* /usr/lib/
+ WORKDIR /app
+ COPY --from=0 /app .
```

## Changelog
### 4.0.0-rc.0
- removed `npm link` that ran on build to help facilitate downstream multi-stage builds