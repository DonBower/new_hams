These two scripts will import an FCC Download into an sqlite database, and query out all the Technicians.

Go to https://wireless2.fcc.gov/UlsApp/UlsSearch/searchAmateur.jsp and enter California for the state, Grant Date for the "Date Type" and then select a date range, like the last 180 days.

then run ./importDownload.sh to import the date into the database, and ./listNewHams.sh to get a .csv file

You are off to the races!

