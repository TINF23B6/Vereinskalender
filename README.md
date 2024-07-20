# Project: Vereinskalender

This repository contains the source code for Vereinskalender.

## Starting the Project via Docker Compose

To start the project, you'll need to have Docker installed on your machine. Here's how:

### Prerequisites

* Docker: Make sure you have [Docker](https://docs.docker.com/engine/install/) and Docker Compose installed and running on your machine. 
* Alternatively, you can use [Docker Desktop](https://www.docker.com/products/docker-desktop/) on Windows and Mac.

### Installation with Docker (recommended)
1. Create a folder where you want to store the project
2. Create a `docker-compose.yaml` file with the content from `docker-compose.yaml`
```bash
wget https://raw.githubusercontent.com/TINF23B6/Vereinskalender/main/docker-compose.yaml
```
3. Start the project using Docker Compose:
```bash
docker compose up -d
```
This will start the project in detached mode, which means it will run in the background and not take up a terminal window.

### Accessing the Project

Once the project is running, you can access it by visiting `https://localhost:8443` (or the port number specified in your `docker-compose.yaml` file) in your web browser (Optional, phpMyAdmin at `http://localhost:8090`).

### Local Building and Starting the Project with Docker

1. Clone this repository
2. Navigate into the project directory:
```bash
cd Vereinskalender
```
3. Build the project using Docker Compose:
```bash
docker compose build
```
This will download and install all the necessary dependencies for your projet.

4. Start the project using Docker Compose:
```bash
docker compose up -d
```
This will start the project in detached mode, which means it will run in the background and not take up a terminal window.

### Accessing the Project

Once the project is running, you can access it by visiting `https://localhost:8443` (or the port number specified in your `docker-compose.yaml` file) in your web browser (Optional, phpMyAdmin at `http://localhost:8090`).

### Stopping the Project

To stop the project, run:
```bash
docker compose down
```
This will stop the project and remove the containers.

> The default login credentials for the calender are:  
> **Username:** `admin`  
> **Password:** `admin`