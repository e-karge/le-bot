REGISTRY?=docker.io
image=ekarge/lebot

all: clean
	buildah --name $(image) from --pull-always docker.io/alpine
	buildah run --net=host $(image) /bin/sh <install.sh
	buildah copy --chown root:root $(image) overlay/ /
	buildah config \
	  --volume /etc/lebot \
	  --volume /var/lib/lebot \
	  $(image)
	buildah commit --rm $(image) $(image):latest

push:
	buildah push --format v2s2 $(image):latest "$(REGISTRY)/$(image):latest"
	buildah tag $(image):latest "$(REGISTRY)/$(image):latest"

clean:
	-buildah rm $(image)
	-buildah rmi $(image)
