
.PHONE: build
build:
	docker build -t webmobix/sonarqube-developer:8.4.0 .

.PHONY: tag
tag:
	git tag v8.4.0

.PHONY: stack
stack:
	docker-compose up -d
