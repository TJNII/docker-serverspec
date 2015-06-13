Docker-ServerSpec
=================

This is a container for testing other containers.
This container contains all the ServerSpec deps required to run ServerSpec against a Docker container.
It is intended to be called against the target container's source tree.

Prereqs
-------

- World readable / docker group readable source container tree
- Source container tree mapped in at /source
- Docker daemon socket mapped in at /var/run/docker.sock

Running
-------

```
# cd to the container build tree to test
cd some_container_tree_to_test

# Build the container to seed the cache
docker build .

# Run the test container (tjnii/serverspec) against the current container
docker run -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):/source --rm -ti tjnii/serverspec
```

Authors
=======

Tom Noonan II <tom@tjnii.com>
