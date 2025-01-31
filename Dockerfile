FROM python:3.12

# Set the working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Poetry
RUN pip install --no-cache-dir poetry

# Copy project files
COPY pyproject.toml poetry.lock /app/

# Install dependencies using Poetry
RUN poetry config virtualenvs.create false \
    && poetry install --no-root --no-interaction --no-ansi

# Copy the rest of the application files
COPY . /app

# Set environment variables for Render
ENV PORT=10000

# Expose the port Flask runs on
EXPOSE 10000

# Set the entrypoint command
CMD ["poetry", "run", "flask", "run", "--host=0.0.0.0", "--port=10000"]
