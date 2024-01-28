VENV_NAME?=venv
PYTHON=python3
VERSION?=latest
APP_NAME=py-demo

dep: venv
	@pip install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple

venv:
	${PYTHON} -m venv venv
	source $(VENV_NAME)/bin/activate

test: venv
	${PYTHON} -m pytest

lint: venv
	${PYTHON} -m pylint
	${PYTHON} -m mypy

run: venv
	${PYTHON} main.py

docker-build:
	docker build -t ${APP_NAME}:${VERSION} .

docker-test:
	docker run --rm -it -v $(shell pwd):/app ${APP_NAME}:${VERSION}

clean:
	@find . -name '*.pyc' -delete
	@find . -name '__pycache__' -type d | xargs rm -fr
	@find . -name '.pytest_cache' -type d | xargs rm -fr