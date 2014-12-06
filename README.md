## About

IRC Browse is a web service for browsing IRC logs. The [IRC Browse site is here](http://ircbrowse.net/).

## Database setup

Create the PostgreSQL database:

    $ sudo su postgres --command 'createuser ircbrowse -P'
    $ sudo su postgres --command 'createdb ircbrowse -O ircbrowse'

Update the database to the latest migration:

    $ dist/build/ircbrowse/ircbrowse ircbrowse.conf --create-version

If that doesn't work try this:
    $ psql -d ircbrowse         at prompt type this:

## CREATE TABLE version (
key_id serial PRIMARY KEY,
type int,
version int);
\d    
to show created table
\q    to quit


## Stackage version

GHC 7.4

    remote-repo: stackage:http://www.stackage.org/stackage/bcd05bfac24db21c8d25b1069765e3d4d7037ee3

## Adding a channel

* Add to VNC's join list
* Add to Ircbrowse.TypesImport
* Add to Ircbrowse.Import's importRecent
* Insert an entry into entry_count
