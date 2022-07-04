# Flutter Coding Challenge

Reviewer, please refer to [write-up section](#write-up) for my overview on the developed application for the coding challenge.

:blue_heart: If you're here, it means we've decided to move forward with your application!

:rocket: Next, you should complete the following challenge that demonstrates your skills as a developer. You have ​**one week** to do it - take your time and do things nicely. There will be no commercial use of your code and it will only be used to assess your abilities as a software engineer.

:slightly_smiling_face: This project should take approximately ~8 hours of pure development time, so you can complete it within a day.

### :cupcake: We can give you some advice beforehand:

- Be tidy with your code.
- We like clean code over here.
- You may use any plugin you desire, just do not use it for every simple task.
- Feature completion is equally important as code quality and architecture.
- For navigation, please use Nav2. (You’re allowed to use packages)
- Your app should be hosted in a private Git repository and shared with @soheilnikbin once it is ready.
- Avoid over-engineering things but make sure to show solid software engineering knowledge.
- Please organise, design, test and document your code as if it were going into production.

###### Description:

We have created a bare-bones Flutter app which displays a list of users and a details screen. Nevertheless, it has been implemented in a rush and does not include API integration.
The objective of this task is to refactor the existing app so that it is both performant and clean (think production-ready) as well as meeting all the acceptance criteria.

###### Acceptance criteria:

Following [the design](https://www.figma.com/file/iT4JJpx8KFD2F1kjcVaAbK/OWWN-Coding-Challenge), the app should behave as follows:

###### Screen 1 - Authentication

- It is up to you how this page looks.
- The Auth API must be called on this page in order to obtain an access token.
- The user must be directed back to this page if both the access token and the refresh token have expired.

###### Screen 2 - Users List

- The app bar at the top should have the ability to scroll and have a parallax effect when the user scrolls up. You can use any image you like.
- The list of users should be grouped by Active and Inactive status and pagination should be supported.
- Each item should display an avatar with the user's name initials, username, and email.
- In addition, when a user is tapped, the avatar, the name, and the email should be animated to transition to the third Screen.

###### Screen 3 - User Details

- In the avatar, a gender indicator should be displayed.
- The name and email fields can be edited by tapping them.
- In the edit mode, a cancel button (x) should be displayed at the top.
- By pressing the save button, the user's details are updated locally, and the changes are reflected in the user list.
- The line chart at the bottom displays (with animation) the user's last month's data.
- By panning the chart, the user should be able to see past values displayed above the pointer.

###### Test

You are provided with two empty tests to implement.

## API details

You can import the JSON file located in the project's root directory into Postman.

Base URL: `https://ccoding.owwn.com/hermes`

There are three endpoints that you must access:

**Auth Endpoint: /auth**

> To begin, you will need your access token, which can be obtained through the ApiKey, and your email address.
> Credentials:

```
Email: flutter-challenge@owwn.com
API Key: owwn-challenge-22bbdk
```

```
Header: X-API-KEY

Body
{
   "email": "youremail@email.com"
}

Response:
{
   "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTU5Nzg1NTcsImlkZW50aXR5IjoiNTg3NTE0ODMtODE4ZS00YWVjLWI0YmYtZWMwZjFiODkyNWI1IiwidmFyaWV0eSI6IkFVVEgifQ.5EWR34YJOJPxRBQh7np12woSZZJ8ERcsD_BEkrWkMFM",
   "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTU5Nzg4NTcsImlkZW50aXR5IjoiNTg3NTE0ODMtODE4ZS00YWVjLWI0YmYtZWMwZjFiODkyNWI1IiwidmFyaWV0eSI6IlJFRlJFU0hfQVVUSCJ9.curbnireZmH9zcTTUYr7VVkQa-CLOWuf7JKKW7Av_hY"
}
```

**Refresh Endpoint: /refresh**

> Secondly, you will need to refresh your access token whenever it expires. To do this, you can use the following API.

```
Body
{
   "refresh_token": "REFRESH TOKEN"
}

Response:
{
   "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTU5Nzg1NTcsImlkZW50aXR5IjoiNTg3NTE0ODMtODE4ZS00YWVjLWI0YmYtZWMwZjFiODkyNWI1IiwidmFyaWV0eSI6IkFVVEgifQ.5EWR34YJOJPxRBQh7np12woSZZJ8ERcsD_BEkrWkMFM",
   "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTU5Nzg4NTcsImlkZW50aXR5IjoiNTg3NTE0ODMtODE4ZS00YWVjLWI0YmYtZWMwZjFiODkyNWI1IiwidmFyaWV0eSI6IlJFRlJFU0hfQVVUSCJ9.curbnireZmH9zcTTUYr7VVkQa-CLOWuf7JKKW7Av_hY"
}
```

**Users List Endpoint: /users?limit=10&page=1**

> Lastly, you’ll need to pass your Access Token as the Authentication header, and the endpoint accepts 2 query parameters for pagination purposes: limit and page.

Response: (\*optional)

```
{
   "users": [
       {
           "id": "f66f258d-8047-42ef-96e0-94df79f36474",
           "name": "Kenneth Harper",
           "gender": "male",
           "status": "active",
          *"email": "kenneth.harper@gmail.com",
           "partner_id": "58751483-818e-4aec-b4bf-ec0f1b8925b5",
           "created_at": "2022-06-23T11:56:17.887865+02:00",
          *"statistics": [12,196]
       }
   ],
   "total": 121
}
```


## Write-up

The developed application follows a layered-like architecture and uses the bloc library for managing app state. It was written taking in consideration several Software Engineering principles (e.g., SRP, KISS, Dependency Injection, Dependency Inversion, Responsibility Segregation), as well common practices within the Flutter community (e.g., trailling commas usage, barrel files). The folder structure is as follows:

- `blocs`, which composes all needed blocs to mantain the app state;
- `core`, which defines several classes and functions that serve as the app foundations and that are of general purpose usage within the app;
- `data`, which defines every piece of code that allows the connection of the application with several data layers, through the use of repositories and networking clients;
- `logging`, which provides logging functionalities such as logging bloc transition states;
- `models`, which maps business and data layer entities/concepts in Dart classes;
- presentation, which contains every piece of UI code (e.g., widgets, pages).

I like to follow and adapt this architecture for two reasons: everything is tightly seggregated, which promotes composability and easy refactoring/minimal API changes, and fits well with Flutter architecture/environment, as we can see the architecture as a widget tree:

~~~
App:
   -> Presentation
      -> Blocs
         -> Repositories (data access points)
            -> Models
               -> Networking Clients (API Services integrators)
                  -> HTTP, Websockets
~~~

To promote testability, bug and side effect reduction, I've also decided to promote some of Functional Programming core principles, such as Monads and dependency injection. Monads in theory are complex to understand, but they allows us to express through an elegant API how the code should behave in terms of functions. I use them a lot in the data layer to translate exceptions in models. This way we don't need to worry a lot of the app crashing due to an unhandled exception, as monads will make sure that no exception is thrown.

**Dependencies**

As all things in life, we should not be very dependant of external packages/plugins in our application, as one bug/breaking change might cause the app to start behaving incorrectly, as well as the performance & app size to get worse. However, we should not or even try to reinvent the wheel on something that has already been developed and tested, which creates a dillema: when is it not acceptable to depend on a library?

Despite the application being small, some of the things it is required to do are complex (e.g., line chart render). In order to meet the requirements and lay the application foundations/architecture, I've decided to depend on the following dependencies:

|Name|Reason|
|----|------|
|`dartz`|Dartz is the `catz` library port for Dart. The app uses for monads application and transformation.|
|`fl_chart`|There are several chart libraries which one can use, but I tend to always use fl_chart as it is powerful, performant and simples to use.|
|`flutter_bloc`|The flutter_bloc package does an amazing job in state management using the concept of BLoC - Business Logic over Components.|
|`http + networking`|The `networking` package is a custom package that I've developed, which provides a simple but useful HTTP client. It is built on top of `http`, hence this package is also required in the app. If `dio` was needed to be used, one just needs to implement a networking client that uses it.|
|`intl`|This package helps achieving app localization (l10n)|
|`jwt_io`|To check if an user session has expired or is about to, I needed to parse the API JWT Tokens. This package achieves this requirement very easily.|
|`lumberdash`|Lumberdash is a logging library that provides the 4 common logging functions as top level functions.|
|`lumberdash`|Lumberdash is a logging library that provides the 4 common logging functions as top level functions.|
|`shared_preferences`|To allow multiple sessions using the same authentication tokens, it was required to store this in the user device.|

**Difficulties Felt**

While developing the application I've felt some difficulties due to not being used to use `Navigator 2.0` and `Slivers`. I'm used to Navigator imperative API and the only official way to achieve such for the new Navigator, was by the use of `Router`. However, Router seems to be too complex to integrate on the app for achieving such simple things like `push` and `pop`. Given this, I've decided to merge both declarative and imperative navigation styles by defining and centralizing pages logic on `AppNavigator`. Then through the usage of the static `of` API, when the app needs to change the current page, the custom navigator class provides a method that will update the inner navigator widget state and therefore and update the pages stack.

To achieve the parallax effect I've used the `SliverAppBar` and `SliverList` sliver widgets, which together work very well and achieve most of the proposed requirements. However, in the Figma design files, the background image seems to be on the back of the list, which I found very hard to achieve in Flutter.

On the testing side, three tests were proposed to implement. Unfortunately, I was only able to implement one of them, as the other ones require a non mocking setup (with my navigator architecture). The last test required to validate that the panned chart showed the correct value. To achieve such, I believe a good approach is to use golden tests as it allows to not only check that the value is being shown but also the correct one.