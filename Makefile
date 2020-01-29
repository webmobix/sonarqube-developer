
.PHONE: build
build:
	docker build -t webmobix/sonarqube-developer:8.1.0 .

.PHONY: tag
tag:
	git tag v8.1.0
