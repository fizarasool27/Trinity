# Trinity
A 3-in-1 app which lets the user enjoy 3 functionalities within a single app - do messaging, check the weather and make a To-do List.
The backend of the messaging feature is on Firebase.
The weather is fetched with the help of networking using URLSession() and Apple's CoreLocation to fetch the user's current location.
The ToDo List is persisted on the device using Realm, in which we can add categories of our work, and within those categories, we can add items and check them as we complete them.
