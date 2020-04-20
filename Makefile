IMAGE=renefritze/ngsolve_i-tutorials

NB_USER:=${USER}
NB_UID:=$(shell id -u)
TOKEN:=${PYMOR_JUPYTER_TOKEN}

build:
	docker build --build-arg NB_USER=$(NB_USER) \
		--build-arg NB_UID=$(NB_UID) \
		--build-arg PYMOR_JUPYTER_TOKEN=$(TOKEN) \
		-t $(IMAGE) -f Dockerfile .

run: build
	docker run -p 8888:8888 -ti $(IMAGE)
