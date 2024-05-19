# Stage 1: Build stage
FROM python:3 AS builder

WORKDIR /app

COPY . .

# Install dependencies including Django
RUN pip install django==3.2

# Run migrations
RUN python manage.py migrate

# Stage 2: Production stage
FROM python:3-slim AS production

WORKDIR /app

# Copy only necessary files from the build stage
COPY --from=builder /app .

# Install Django for production
RUN pip install django==3.2

# Expose port
EXPOSE 8000

# Command to run the server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
