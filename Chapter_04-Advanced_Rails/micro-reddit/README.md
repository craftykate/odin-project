# Sample Reddit App

Project Source: http://www.theodinproject.com/ruby-on-rails/building-with-active-record

**Odin's Notes:** Let's build Reddit. Well, maybe a very junior version of it called micro-reddit. In this project, you'll build the data structures necessary to support link submissions and commenting. We won't build a front end for it because we don't need to... you can use the Rails console to play around with models without the overhead of making HTTP requests and involving controllers or views.

**My Notes:** Seriously, it's basic. No front end. But the database associations are all there. 
- Users have usernames (no logging in for this app)
- Users usernames have to be unique
- User can create posts
- Posts are associated with the user who created it
- Users can comment on posts
- Comments are associated with the posts they were posted to and the user who created them