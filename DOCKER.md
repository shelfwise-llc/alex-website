# Docker Deployment Guide

This guide explains how to deploy the Alex Website application using Docker and Docker Compose.

## Prerequisites

- Docker and Docker Compose installed on your system
- Git to clone the repository

## Quick Start

1. Clone the repository:

   ```bash
   git clone <repository-url>
   cd alex_website
   ```

2. Set up environment variables:

   ```bash
   ./scripts/setup-env.sh
   ```
   This will create a `.env` file from the `.env.example` template. Edit the `.env` file to set your specific configuration.

3. Deploy the application:

   ```bash
   ./scripts/docker-deploy.sh
   ```

4. Access the application:
   - Phoenix application: [http://localhost:4000](http://localhost:4000)
   - Ghost CMS: [http://localhost:2368](http://localhost:2368)

## Configuration

### Environment Variables

The main configuration is stored in the `.env` file. Key variables include:

- `DATABASE_URL`: Connection string for the PostgreSQL database
- `SECRET_KEY_BASE`: Secret key for Phoenix
- `GHOST_CONTENT_API_KEY`: API key for Ghost CMS content API
- `GHOST_DB_PASSWORD`: Password for the Ghost MySQL database

### Docker Compose Services

The deployment includes the following services:

- `phoenix`: The Phoenix web application
- `db`: PostgreSQL database for Phoenix
- `ghost`: Ghost CMS
- `ghost_db`: MySQL database for Ghost CMS

## Development Workflow

For local development:

1. Start the services:

   ```bash
   docker-compose up -d
   ```

2. View logs:

   ```bash
   docker-compose logs -f phoenix
   ```

3. Stop the services:

   ```bash
   docker-compose down
   ```

## Production Deployment

For production deployment:

1. Update the `.env` file with production values
2. Set `PHX_HOST` to your domain name
3. Consider using a reverse proxy like Nginx for SSL termination
4. Deploy with:

   ```bash
   DOCKER_REGISTRY=your-registry IMAGE_TAG=prod ./scripts/docker-deploy.sh
   ```

## Troubleshooting

- **Database connection issues**: Ensure the database service is running and the connection string is correct
- **Ghost CMS not starting**: Check the MySQL service and verify the credentials
- **Phoenix application errors**: Check the logs with `docker-compose logs phoenix`

## Maintenance

- **Backup databases**:

  ```bash
  docker exec -t alex_website_db_1 pg_dump -U postgres alex_website_prod > backup.sql
  ```

- **Update images**:

  ```bash
  docker-compose pull
  docker-compose up -d
  ```
