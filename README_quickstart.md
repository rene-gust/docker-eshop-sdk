# Docker SDK Quickstart
for full docs read README.md

# setup
- cp .env.dist .env
- edit .env and put values that fit your local system and project
- run setup-docker.sh on host
    - recipes/oxid-6.5/setup-docker.sh
- go into container
    - docker compose exec php bash
- run setup-docker.sh on container
    - recipes/oxid-6.5/setup-oxid.sh
- open https://oxideshop.local/Setup
  - database settings:
    - host: mysql
    - database: example
    - user: root
    - password: root
