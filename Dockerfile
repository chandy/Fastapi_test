# Lambda Python base image
FROM public.ecr.aws/lambda/python:3.12

# Copy the AWS Lambda Web Adapter as an extension
COPY --from=public.ecr.aws/awsguru/aws-lambda-adapter:0.9.1 /lambda-adapter /opt/extensions/lambda-adapter

# Install application dependencies
WORKDIR /var/task
COPY requirements.txt ./
RUN python -m pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY app ./app

# Configure the web server for the adapter
ENV PORT=8080
ENV AWS_LWA_READINESS_CHECK_PATH=/

# Start ASGI server; adapter will proxy to 127.0.0.1:8080
CMD [
  "python", "-m", "uvicorn", "app.main:app",
  "--host", "127.0.0.1",
  "--port", "8080"
]
