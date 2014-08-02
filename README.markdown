#Mckinley
![Mount Mckinley](mckinley.jpeg)

###Technology Stack
* ruby 2.1.2
* Rails 4.1
* Postgres 9.3

###Tasks
* Run 'foreman start' to start the server and go to http://localhost:5000
* Run 'foreman run rails c' to start the rails console
* Run 'foreman run rspec' to run your test suite

###Setup
* rvm install ruby 2.1.2
* rvm use --default ruby 2.1.2
* Install the Mac Postgres App http://postgresapp.com/ and set it to automatically start on login
* Add export PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH" to .profile in your root (~) directory
* Restart your machine
* type 'which psql' which should return something like '/Applications/Postgres.app/Contents/MacOS/bin/psql'
* Clone this repository
* Get the .env file that is not in git from a team member
* Gem install foreman
* Run bundle
* Run 'rake db:create db:migrate db:seed' and 'RAILS_ENV=test rake db:create db:migrate db:seed'
* Run 'foreman run rspec' and all tests should pass
