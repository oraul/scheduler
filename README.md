# Scheduler

It's a restful API for controlling your schedules on each room.

## System dependencies

* Ruby

* Rails

* JWT

* Posgresql

* Swagger

## Requirements

* Docker

* Docker Compose


## Setup

First we should initialize our database

```sh
docker compose run --rm app bin/setup
```

Now we can start our app

```sh
docker compose up
```

## Testing

We've rspec and rswag testing

```sh
docker compose run --rm app bin/ci.sh
```

## Running

Let's generate our dev jwt token! (It's a dev test)

```sh
docker compose run --rm app bin/rails dev:generate_jwt_token
```

Access swagger to access the application, authorize your jwt token (You can't forget to add "Bearer" before the token)

```sh
https://localhost:3000/api-docs
```
