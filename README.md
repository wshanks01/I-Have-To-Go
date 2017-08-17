# README

Before running application

1. Bundle Install

2. Start Postgres server $ pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start

3. Create DB
- rake db:create
- rake db:migrate
- rake db:seed

4. Start Local Server
- Run: $ rails s

5. Enjoy!