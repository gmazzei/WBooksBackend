# WBooksBackend
Backend for the Swift training
<br/><br/>

## Requirements
<ul><li>Swift 4.1</li></ul>
<br/>

## Documentation
You will find all the information necessary to interact with the API here: <br/>
https://wbooksbackend.docs.apiary.io/
<br/><br/>


## API
The app is now running on Heroku. You can interact with it through this URL: <br/>
<pre>
https://powerful-waters-21107.herokuapp.com/
</pre>
<br/>

### Example
<pre>
curl https://powerful-waters-21107.herokuapp.com<b>/books</b>
</pre>
<br/>


## DER

![alt text](https://raw.githubusercontent.com/gmazzei/WBooksBackend/master/DER.png)
<br/>

## Running locally

1) Install Vapor
<pre>
brew install vapor/tap/vapor
</pre>
<br/>

2) Install PostgreSQL
<pre>
brew install postgres
brew services start postgresql
</pre>
<br/>

3) Prepare DB
<pre>
createdb wbooks_test
psql wbooks_test
CREATE USER postgres SUPERUSER;
CREATE DATABASE wbooks WITH OWNER postgres;
\q
dropdb wbooks_test
</pre>
<br/>

4) Clone and start the app
<pre>
git clone git@github.com:gmazzei/WBooksBackend.git
cd WBooksBackend
vapor update -y
swift build
swift run
</pre>
<br/>

5) Open another terminal and run the following code to add data into the DB:
<pre>
psql wbooks
INSERT INTO "User" (id, username, password) 
VALUES (1, 'admin', '$2b$12$44XOBLDrVm11Na2hhhJguefW8TilXkruOG8PIlNL3Y2bNkRHZXqBG');
\q
sh Scripts/create_db
</pre>
