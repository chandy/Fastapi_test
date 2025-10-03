# Lambda Python base image
FROM public.ecr.aws/lambda/python:3.12

# Copy the AWS Lambda Web Adapter as an extension
COPY --from=public.ecr.aws/awsguru/aws-lambda-adapter:0.9.1 /lambda-adapter /opt/extensions/lambda-adapter

# Copy uv/uvx from the official uv image
COPY --from=ghcr.io/astral-sh/uv:0.8.22 /uv /usr/local/bin/uv
COPY --from=ghcr.io/astral-sh/uv:0.8.22 /uvx /usr/local/bin/uvx

WORKDIR /var/task

# Copy only project manifest first to leverage Docker layer cache
COPY pyproject.toml ./

# Resolve and install runtime deps into a local .venv (no dev deps)
RUN uv sync --no-dev

# Copy application code
COPY app ./app

# Make the venv binaries available and configure the adapter
ENV PATH="/var/task/.venv/bin:${PATH}"
ENV PORT=8080
ENV AWS_LWA_READINESS_CHECK_PATH=/

# Start ASGI server with uv; adapter will proxy to 127.0.0.1:8080
CMD [
  "uv", "run", "uvicorn", "app.main:app",
  "--host", "127.0.0.1",
  "--port", "8080"
]
