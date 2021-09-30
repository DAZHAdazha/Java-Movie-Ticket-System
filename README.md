# Java-Movie-Ticket-System
This is a Java-based Movie Ticket ordering system, users could browse movies and order tickets.

# Design Document
## Software Structure

## Technologies that we used:
**Java EE and Java Spring**: The Spring Framework is an open source application framework and inversion of control container for the Java platform. The framework's core features can be used by any Java application, while providing extensions for building web applications on top of the Java EE (Enterprise Edition) platform.

**Java Spring MVC**: Model–view–controller is a software design pattern commonly used for developing user interfaces that divides the related program logic into three interconnected elements which mainly focus on separating internal representations of information from the ways information is presented to and accepted from the user

**Mybaits**: it is is a Java persistence framework that couples objects with stored procedures or SQL statements using an XML descriptor or annotations. 

**MySql**: MySQL is a open-source, medium weight database software, which has stand-alone clients that allow users to interact directly with a MySQL database using SQL statement. 

**Redis**: Redis (Remote Dictionary Server)is an in-memory data structure store, used as a distributed, in-memory key–value database, cache and message broker, with optional durability. which supports different kinds of abstract data structures, such as strings, lists, maps, sets, sorted sets, HyperLogLogs, bitmaps, streams, and spatial indexes.

**Layui**: Layui is a front-end UI framework which could provide a plenty of functionalities such as tables, layout, buttons and so on. 

## Functionalities:
**Register**: User could register by entering their email, username and password, and verification code. After registration, the user will be automatically logged in and store their logging information in the cookies of the browser and also the in the local storage, sessions in the server will also simultaneously store them accordingly.

**Verification code**: A CheckCodeUtil class is implemented to automatically generate verification code image by drawing four different characters and blocking lines randomly in Java server, this functionality is adopted in order to reduce malign registration by scripts or robots, thus enhance the security of the server.

**Login**: User could login after their registration, the cookies will be stored in browser while next time browser will automatically login for them. To be notice that there are many pages only available for login users, such as buyTicket.jsp, buySeat.jsp and so on.

**Logout**: After login, user could just click the top right button to logout, which would delete the cookies and local storage in the browser and sessions in the server. Show movies: In the main page, the latest eight films, the top nine movies for the box office and eight upcoming films were shown, using the font-end UI framework Layui, and we also drew inspiration from the design of Maoyan movies. The data is selected from database and sent to browser.

## Search:
**Movies**: User could select the movie mode, then directly type in movie names to search for the movies. Stars: User could select the star mode, then type in movie stars names to search for the movies that actor or actress in them.

**Theater**： User could select the theater mode, then directly type in theater names to search for
the available theater. 

**View Order information**: After login, user could go to their user page and chose My Order to browse their orders of tickets, they could also apply for Print, scanning QR code for information and refund. According to the user's ID, the order information of the user is searched from the database and displayed in the browser. When the user clicks QR code, the server will generate a QR code including the information about the movie and return it to the user.

**QR code**: This functionality can convert a string into a QR code. By using the package called zxing, the server could generate QR code according to the giving string. QR ticket: The information about the order will be converted into a string and the string is put into QR generator. Then the QR code is generated which includes the information about the order. After scanning the QR code by the phone: Print tickets:

**Download APK**: There is a QR code including the address about the APK for Android. And there also is a web page that APK can be downloaded.

## Recommend System:
The system will recommend movies based on the user's ticket records. If the user has never bought a ticket, it will recommend the movie with the highest score. The system gives different weights to movie types, directors, actors, and ratings, then calculates user preferences and recommends movies. For instance, if the user bought the movie “Hi, Mom” which Shen Teng is in this movie, and this movie is a comedy type. So, the movie “Crazy Alien” which is also a comedy and Shen Teng play a main role in it, will be recommend the first, along with other comedy films. Modify information: Users can modify and upload their avatar and Email.

**Modify password**: Users can modify the password by entering old password and reset the new password, which also require repeat for confirm. Account and balance: The user has an account from which the system will deduct money when he purchases movie tickets. Each user initially has 3000 yuan and can recharge. There is a table in the database representing the user's balance, and each user can only have one account. When the balance is insufficient, the user cannot buy movie tickets. They could use TOP UP functionality by typing integer to recharge balance in their account. 

**Movie details**: This page shows some movie information, including name, type, duration, region, release time, rating, introduction, actor and director, and some comments. This page shows some movie information, including name, type, duration, region, release time, rating, introduction, actor and director, and some comments.

**Comment**: User can comment the movie and these comments will be stored in the database. Movie list: This page will show all movies which is on show and there are filters (types, region, time) which can be used to choose the movie by user. Moreover, they could also sorted all the movies by popularity, by time and by ratings. The selection of the filter will generate an SQL to query the corresponding data in the database.

**Buy Tickets (Choose cinema)**: In this page, there are also some filters, but these filters are used to select cinemas. In this page, users can query movies in different cinemas and at different times, and further purchase movie tickets. First, a single movie information is queried from the database. Then query the corresponding cinema and match the corresponding movie number. 

**Buy tickets (Choose schedule)**: This page shows all the movie scenes of the corresponding movie and the corresponding cinema, where users can choose. And the time, language, hall, and price are shown here. Buy tickets (Choose seats): In this page, users can choose seats, but only four seats at most. There is a timer in this page. If the user cannot complete the selection within the specified time, he will be forced to exit. In addition, after the user selects the seat, the seat will be locked in a period of time. During this period, other users in the front cannot select this seat. First, an initialized seat table is passed from the back end, which contains the seat information that has been selected. Users are restricted to gray seats. 

The countdown function is completed by JS. The seat lock is implemented by Zedis. When a user selects seats, a hash value will be passed to Zedis, which will time the hash. During the time, these seats cannot be selected by other users. Buy tickets (Payment): This page also has a timer. If the payment is not completed before the end of the timer, it will be forced to exit. And the details of this order are shown here.

On this page, Zedis will re time and then cancel the time when the transaction is completed. After payment, the system will prompt the user for the balance. User Management: All users are showed in this part. First, input a username to search for users. Secondly, the user's data can be selected for viewing. Next, the data can be stored as two formats, Csv and Excel. Next point is that the data can be print as PDF format.

Last, the administrator can modify the user's password and E-mail. Movie management: The movie can be added from here, it needs to fill in some basic information such as Movie Name, Movie English Name, Director, Actors/Actrsses which can add many staff, Movie Details, Movie Length, Movie Type, Launch Time, District, and a poster.
Then all the movies are shown here. And the administrator can modify and remove these movies. 

**Modify: Remove**:
Launch Time Management: All the movie schedules are showed in this part. The number of movies is managed in this place, which includes all the operations of user management, such as search, print, save, filter and modify. At the same time, it also has the function of adding and displaying dropping off. Function of adding needs input some information including movie name, theater, hall, launch time and price. 

**Comment managemen**t: All comments are showed in this part. The number of movies is managed in this place, which includes all the operations of user management, such as search, print, save, filter and modify. But administrators can delete inappropriate comments. 

**Order management**: All orders are showed in this part.
The number of movies is managed in this place, which includes all the operations of user management. And you can view the refund application and choose whether to approve the user's refund application. Ticket Office Statistics: This page shows the box office details. The first is the sales comparison of different types of films and detailed values can be seen and downloaded.

Secondly, there is a tickets office rank which lists the top ten movies at the box office and can switch to two charts: bar chart and line chart. Similarly, details and download functions are implemented. Zedis Zedis is a module that we implemented to emulate Redis as a hash-stored remote server, which used to store the queuing information to solve the concurrent problem when multiple users booking the same seat. This module used TCP Server-Client model to handle user’s request. Database For the database, we choose MySql which is a medium weight database software, and there are 8 tables in total (comment, hall, cinema, movie, orderinfo, user, schedule, card), there are a variety of filed types along with different length limitations, such as varchar (20), varchar (150), varchar (30), varchar (50), datetime, int, bigint, double.

## Security Data Encryption

The field of password in user table for datable model is encrypted generate password through 64 Base Encoder method, while checking password function is also defined, by carry on identical encryption process to handle requested raw password, then comparing to values stored in database, which could avoid storage of cleartext password. When view functions need to check password, they could just simply call the check function. By this means, password stored in database is encrypted, which means no cleartext passwords are stored in database. SQL Injection To avoid malign attackers that use SQL statement to hack the server, PrepareStatement is introduced to replace all susceptible code, which use “?” question mark as placeholder for the search SQL statement, and dynamically generate the query request, secure the system. Version control We use Github as our version control tools with two branch in total, 111 commits along with Wiki Pages.

## For the front end design
### Function Overview
Multi-city, multi-theater movie booking options.

User login (including cell phone verification code login and password login), pull off personal
information, including reviews, favorite movies, recommended movie information, ticketing
information, etc.
Seat selection, ticket purchase and payment process in different cinemas.
Review and scoring system.
Two-dimensional code ticket checking.
Order management, display individual user orders, and in the front end can be operated to
refund tickets, etc.

**Home pages**
The home page mainly to show all the movie in local cinema and you can searching the
films and cinema and Show some information
Search bar for both films and cinema wihich have show or plan to show in the local cinema
Show Top 6 now in theaters films
Show 2 of cinemas with short distance with the your location
Show Top 3 Coming soon films
Show 3 films with system push to you.

**Like pages**
This page is to show the films which you are liked or marked
For the liked films you can jump to buy pages if have ticket.
For the marked films will show detail of films.

**Ticket information**
The QR code is add to the system for check the ticket, I order to realize the features, I add a status
code I the table t_order so that can show the status can be recognize the status, If the ticket is not
used or the order is canceled the status will show the ticket is not available.

**The my pages**
In this page is mainly to manage the user information and orders, user can set the password after
they log in with the SMS code.
Also can cancel the order by yourself before 15 min the movie begin.

**Interaction Logic**
The api used in front-end
In order to compatible with the website system and backend management so, I use node.js
written some api for the mobile app, so that it can be used in the front-end to get same data with
the website and using same data layer.

**API Funtures**
/api/getPhoneCode Get the SMS code for log in

/api/captcha Generate the captcha for the sign in and sign up

/api/phoneLogin Using SMS login

/api/pwdLogin Using password and user name to log in

/api/getUserInfo Get user information for the current user.

/api/updateUserAvatar Update user avatar

/api/updateUserName Update user name

/api/updateUserPwd Change account's password

/api/getMovieList Get local cinema movies' information

/api/getMovieDetail Loading film's information

/api/getUserComment Get a movie's comment.

/api/getCurrentCinemaDetail Loading a cinema's information.

/api/getScheduleById Get a detail of a movie's schedule.

/api/order Submit a order
