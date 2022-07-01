# Flutter Coding Challenge

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
