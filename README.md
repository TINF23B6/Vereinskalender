# Projekt: Vereinskalender

This repository contains the source code for Vereinskalender.

## Building and Starting the Projekt via Docker Compose

To build and start the projekt, you'll need to have Docker installed on your machine. Here's how:

### Prerequisites

* Docker: Make sure you have [Docker](https://docs.docker.com/engine/install/) and Docker Compose installed and running on your machine. 
* Alternatively, you can use [Docker Desktop](https://www.docker.com/products/docker-desktop/) on Windows and Mac.

### Building and Starting the Projekt

1. Clone this repository
2. Navigate into the project directory:
```bash
cd Vereinskalender
```
3. Build the projekt using Docker Compose:
```bash
docker compose build
```
This will download and install all the necessary dependencies for your projet.

4. Start the projekt using Docker Compose:
```bash
docker compose up -d
```
This will start the projekt in detached mode, which means it will run in the background and not take up a terminal window.

### Accessing the Projekt

Once the projekt is running, you can access it by visiting `https://localhost:8443` (or the port number specified in your `docker-compose.yml` file) in your web browser (Optional, phpMyAdmin at `http://localhost:8090`).

### Stopping the Projekt

To stop the projekt, run:
```bash
docker compose down
```
This will stop the project and remove the containers.

> The default login credentials for the calender are:  
> **Username:** `admin`  
> **Password:** `admin`