# Project99

> After analyzing the app requirements, I have chosen next strategy:

1 . Obtaining stock ids with the "/favorites" api call.

2 . If having successful response (online mode):

- make concurrent api calls with endpoint "/favorites/stock_id" by using DispatchGroup. 
    
- Once I have an array that contains all stock objects in DataManager, store it by using CoreData in local database.
    
- Send the stocks array to view model.
    
3 . If having failure response (offline mode):

- Retrieving stock objects from local database
    
** With this implementation, it is not necessary for the detail stock module to have a data manager. Stocks list module having it is enough.

--------
