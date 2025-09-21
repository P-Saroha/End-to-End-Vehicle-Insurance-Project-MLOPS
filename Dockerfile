# Use an official Python 3.10 image from Docker Hub (latest stable)
FROM python:3.10-slim

# Set the working directory
WORKDIR /app

# Copy requirements and setup files
COPY requirements.txt setup.py pyproject.toml ./
COPY src/ ./src/

# Create a clean requirements file without the local package reference
RUN grep -v "^-e \.$" requirements.txt > requirements_clean.txt

# Install the local package in editable mode
RUN pip install --no-cache-dir -e .

# Install other dependencies
RUN pip install --no-cache-dir -r requirements_clean.txt

# Copy the rest of the application
COPY . .

# Expose the port FastAPI will run on
EXPOSE 5000

# Create a non-root user for security
RUN useradd --create-home --shell /bin/bash app \
    && chown -R app:app /app
USER app

# Command to run the FastAPI app
CMD ["python3", "app.py"]