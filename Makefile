
.PHONE: build
build:
	docker build -t webmobix/sonarqube-developer:8.3.1 .

.PHONY: tag
tag:
	git tag v8.3.1

.PHONY: stack
stack:
	docker-compose -d
