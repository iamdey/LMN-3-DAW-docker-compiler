prepare:
	docker run --privileged --rm tonistiigi/binfmt --install arm64,arm
	docker build -f base.Dockerfile -t lmn-3-daw/base .

build_armv7:
	docker build -f rpi-armv7-cross-compiler.Dockerfile -t iamdey/lmn-3-daw_compiler:armv7 .

build_arm64:
	docker build -f rpi-arm64-cross-compiler.Dockerfile -t iamdey/lmn-3-daw_compiler:arm64 .

build_amd64:
	docker build -f linux-amd64-compiler.Dockerfile -t iamdey/lmn-3-daw_compiler:amd64 .

tag_arm64:
	docker tag docker.io/iamdey/lmn-3-daw_compiler:arm64 iamdey/lmn-3-daw-docker-compiler:arm64
	docker tag docker.io/iamdey/lmn-3-daw_compiler:arm64 iamdey/lmn-3-daw-docker-compiler:arm64-0.4.x
	docker push iamdey/lmn-3-daw-docker-compiler:arm64
	docker push iamdey/lmn-3-daw-docker-compiler:arm64-0.4.x

push_armv7:
	docker tag docker.io/iamdey/lmn-3-daw_compiler:armv7 iamdey/lmn-3-daw-docker-compiler:armv7
	docker tag docker.io/iamdey/lmn-3-daw_compiler:armv7 iamdey/lmn-3-daw-docker-compiler:armv7-0.4.x
	docker push iamdey/lmn-3-daw-docker-compiler:armv7
	docker push iamdey/lmn-3-daw-docker-compiler:armv7-0.4.x
