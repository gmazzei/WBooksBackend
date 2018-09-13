# WBooksBackend
Backend for the Swift training

## Documentation
You will find all the information necessary to interact with the API here: https://wbooksbackend.docs.apiary.io/

## Remote URL

https://powerful-waters-21107.herokuapp.com/

## Running locally

1) Install PostgreSQL
<pre>
brew install postgres
rm -r /usr/local/var/postgres
initdb /usr/local/var/postgres
psql -U postgres -c "CREATE USER postgres SUPERUSER"
psql -U postgres -c "CREATE DATABASE wbooks WITH OWNER postgres"
</pre>

2) Clone and start the app
<pre>
git clone git@github.com:gmazzei/WBooksBackend.git
cd WBooksBackend
swift build
swift run
</pre>

