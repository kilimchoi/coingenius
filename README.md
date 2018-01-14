# Coingenius

# Setup

```bash
bin/setup
```

# Usage

- Install `foreman`

```bash
gem install foreman
```

- Run it with `Procfile.dev-server`. It will start rails server, complile assets through webpack and start sidekiq worker as well.

```bash
foreman start -f Procfile.dev-server
```

# Deploy

- Setup branches for each heroku application:

```bash
heroku git:remote --remote heroku-staging -a coingenius-staging-app // staging
heroku git:remote --remote heroku -a coingenius // production
```

-  Run script:

```
bin/heroku_deploy staging
```

or

```
bin/heroku_deploy production
```
