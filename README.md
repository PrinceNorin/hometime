# Start application with Docker

1. Follow the instruction on how to install [docker](https://docs.docker.com/get-docker/) and [docker-compose](https://docs.docker.com/compose/install/)

2. Update `.env` file
```SH
$ cp .env.sample .env
```

```
DATABASE_URL=postgresql://hometime:secret123@postgres?sslmode=disable
```

3. Start development server
```SH
$ docker-compose up
```

4. Create & migrate database
```SH
$ docker-compose exec hometime bundle exec rake db:create
$ docker-compose exec hometime bundle exec rake db:migrate
```

# Or setting up manually
1. Install Ruby 2.7.1, it is recommended to use version manager like `rvm` or `rbenv` to manage multiple ruby versions
2. Install PostgreSQL server and it's development library a.k.a `libpq-dev` on Debian or Ubuntu
3. Update `.env` file
```SH
$ cp .env.sample .env
```

Change `username` and `password` to your postgres user and password
```
DATABASE_URL=postgresql://[username]:[password]@localhost?sslmode=disable
```

5. Install gem & dependencies
```SH
$ gem install bundler # skip if you already have bundler installed
$ bundle install
```

4. Create & migrate database
```SH
$ rake db:create
$ rake db:migrate
```

5. Start development server
```SH
$ rails s
```

# Test API Endpoint
Open the web browser and go to `http://localhost:3000/docs`, the endpoint is documented using swagger ui.
