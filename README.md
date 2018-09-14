# WBooksBackend
Backend for the Swift training
<br/><br/>

## Documentation
You will find all the information necessary to interact with the API here: <br/>
https://wbooksbackend.docs.apiary.io/
<br/><br/>


## API
The app is now running on Heroku. You can interact with it through this URL: <br/>
https://powerful-waters-21107.herokuapp.com/
<br/>

### Example
<pre>
curl https://powerful-waters-21107.herokuapp.com/books
</pre>
<br/>

## Running locally

1) Install PostgreSQL
<pre>
brew install postgres
brew services start postgresql
</pre>

<br/>

2) Prepare DB
<pre>
psql createdb wbooks_test
psql wbooks_test
CREATE USER postgres SUPERUSER;
CREATE DATABASE wbooks WITH OWNER postgres;
\q
psql dropdb wbooks_test
psql wbooks
</pre>
<br/>

2) Clone and start the app
<pre>
git clone git@github.com:gmazzei/WBooksBackend.git
cd WBooksBackend
swift build
psql wbooks
INSERT INTO "User" (id, username, password) 
VALUES (1, 'admin', '$2b$12$44XOBLDrVm11Na2hhhJguefW8TilXkruOG8PIlNL3Y2bNkRHZXqBG');
sh create_db
\q
swift run
</pre>
