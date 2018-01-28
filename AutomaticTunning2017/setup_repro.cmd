sqlcmd -E -irestore_wwi.sql -S%1
sqlcmd -E -isetup.sql -S%1