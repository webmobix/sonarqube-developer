
.PHONE: build
build:
	docker build -t webmobix/sonarqube-developer:8.2.0 .

.PHONY: tag
tag:
	git tag v8.2.0
