FROM python:3.10-slim-buster

WORKDIR /app

COPY . /app

RUN echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster main non-free contrib" > /etc/apt/sources.list && \
    echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main non-free contrib" >> /etc/apt/sources.list && \
    echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main non-free contrib" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y postgresql-client && \
    pip install --no-cache-dir -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple

CMD ["python3", "main.py"]