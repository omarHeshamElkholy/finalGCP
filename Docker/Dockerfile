FROM python
COPY . /app
WORKDIR /app
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
RUN pip install tornado
EXPOSE 8000
ENV ENVIRONMENT=DEV
ENV HOST=localhost
ENV PORT=8000
ENV REDIS_HOST=redis
ENV REDIS_PORT=6379
ENV REDIS_DB=0
CMD ["python", "hello.py"]
