# java-gradle-node-yarn-cypress

## Motivation
Building Single Page Application's (SPA) using the following tech stack:
- Java/Spring
- React/Typescript
- Cypress
- Gradle

I needed the ability to run my cypress journey tests in the pipeline for a gradle based app.

## Solution
Staring with a cypress browser image, this docker file installs image dependencies, cypress, yarn,
java and gradle on top

Dockerhub Location: https://hub.docker.com/repository/docker/medoror/java-gradle-node-yarn-cypress

## Tech Stack Versions
- Gradle: 7.2
- Node: 16.14.0
- Yarn: 1.22.4
- Java: 11.0.14.1
- Cypress: 9.5.3

## Build Commnad
`docker build -t medoror/java-gradle-node-yarn-cypress:latest .`

# TODO
- Docker Image size is too large.  Work to slim down the image