Hybrid Framework Best Practises
===============================

A framework for Umbraco with some examples

It runs on SQL CE, but there is also a SQL Server .bak file which can be used.


Username: admin

Password: framework123!

This video demos how to use the Hybrid Framework Best Practises: http://www.screenr.com/TM4H

During development, you might find that you want to disable the DonutOutputCache, this is easily done by setting the Duration to 0 on line 24 of DefaultController.cs as the cache is only refreshed when a event takes place in Umbraco (e.g. Publish) so if you edit a view you will not see a change until a event takes place.
