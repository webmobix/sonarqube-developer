
.PHONE: build
build:
	docker build -t webmobix/sonarqube-developer:8.4.1 .

.PHONY: tag
tag:
	git tag v8.4.1

.PHONY: stack
stack:
	docker-compose up -d
