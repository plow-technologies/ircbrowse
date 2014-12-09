## About

IRC Browse is a web service for browsing IRC logs. The [IRC Browse site is here](http://ircbrowse.net/).

## Database setup

Create the PostgreSQL database:

    $ sudo su postgres --command 'createuser ircbrowse -P'
    $ sudo su postgres --command 'createdb ircbrowse -O ircbrowse'

Update the database to the latest migration:

    $ psql ircbrowse < ircbrowse-schema.sql
    $ psql -d ircbrowse
    ircbrowse=# DELETE FROM version;
    ircbrowse=# insert into version (16);
    ircbrowse=# \q

    dist/build/ircbrowse/ircbrowse ircbrowse.conf complete-import
    dist/build/ircbrowse/ircbrowse

    use ZNC version 1.2
    use sphinx 2.0.6
    ./configure --without-mysql --with-pgsql \\
    --with-pgsql-includes=/usr/include/postgresql/ \\
    --with-pgsql-lib=/usr/lib/postgresql/8.3/lib/ --prefix=/opt/sphinx/
    $ make


    use psql 9.3
    

## Stackage version

GHC 7.4

    remote-repo: stackage:http://www.stackage.org/stackage/bcd05bfac24db21c8d25b1069765e3d4d7037ee3

## Adding a channel

* Add to VNC's join list
* Add to Ircbrowse.TypesImport
* Add to Ircbrowse.Import's importRecent
* Insert an entry into entry_count
