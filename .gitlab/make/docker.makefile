.PHONY: docker-init
docker-init:
	@touch VERSION
	@touch IMAGE

.PHONY: buildx-context
buildx-context:
	docker buildx create --name container-builder --use --platform linux/amd64,linux/arm64

.PHONY: buildx-clear
buildx-clear:
	docker buildx rm container-builder

.PHONY: build
build:
	docker buildx build --load . -t $(IMAGE)
	@docker buildx build --load . -t $(IMAGE_LATEST)

.PHONY: push
push:
	-make buildx-clear
	@make buildx-context
	docker buildx build --platform linux/amd64,linux/arm64 --push . -t $(IMAGE)
	@docker buildx build --platform linux/amd64,linux/arm64 --push . -t $(IMAGE_LATEST)

.PHONY: docker-release
docker-release:
	@yq e ".services.minecraft.image = \"$(IMAGE)\"" -i docker-compose.yaml
	@make push
