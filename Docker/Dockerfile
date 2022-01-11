FROM python
COPY . /
RUN apt update
RUN apt install -y redis
RUN pip install -r requirements.txt
RUN pip install tornado
ENV ENVIRONMENT=DEV
ENV HOST=localhost
ENV PORT=8000
ENV REDIS_HOST=localhost
ENV REDIS_PORT=6379
ENV REDIS_DB=0
RUN redis-server &
# RUN service redis-server status
RUN redis-cli ping
CMD ["python3", "./hello.py" ]