# Trinity

## Introduction ##
Why download three different apps for three tasks as important as messaging, checking the weather and making a ToDo list when you can do all of this at one place? 
Trinity is a 3-in-1 app which lets the user enjoy 3 functionalities within a single app - do messaging, check the weather and make a To-do List.
 * The backend of the messaging feature is on Firebase.
 * The weather is fetched with the help of networking using URLSession() and Apple's CoreLocation to fetch the user's current location.
 * The ToDo List is persisted on the device using Realm, in which we can add categories of our work, and within those categories, we can add items and check and uncheck them as we complete them and vice versa.
 
 ## Steps to run ##
 * Clone the app from the repository.
 * After the launchscreen, there are two options - to either register if you are a new user, or login with your credentials.
 * After the authentication is complete, you will be taken to the `TabBarController` where you will have three options - either do messaging, check the weather at your location, or any other city in the world with the help of the search bar above, or make your own customized TodoList in the third option.
 * For making a Todo List, you can divide them into categories of your choice, say work or home or studies. After you add a category, you can tap on that category to add the Todos in that particular category. The categories let us streamline all our work without any clutter.
 * Check the ToDos as you complete your tasks, or uncheck them if you feel there is still something left to complete for that task.
 
 ## Features to test ##
 * Firebase Authentication
 * Messaging functionality
 * Checking the weather of any city in the world
 * Making a ToDo List which are divided according to your own categories.
 
 
