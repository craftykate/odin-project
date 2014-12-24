# Private Events

Project Source: http://www.theodinproject.com/ruby-on-rails/associations

**Odin's Notes** You want to build a site similar to a private Eventbrite which allows users to create events and then manage user signups. Users can create events and send invitations and parties (sound familiar?). Events take place at a specific date and at a location (which you can just store as a string, like "Andy's House").

A user can create events. A user can attend many events. An event can be attended by many users. This will require you to model many-to-many relationships and also to be very conscious about your foreign keys and class names (hint: you won't be able to just rely on Rails' defaults like you have before).

## A few screenshots

This site isn't live on Heroku, so here are a few screenshots of what it looks like:

**The home page**
![index](https://github.com/craftykate/odin-project/blob/master/Chapter_04-Advanced_Rails/private_events/app/assets/images/index.png)

**The login page**
![index](https://github.com/craftykate/odin-project/blob/master/Chapter_04-Advanced_Rails/private_events/app/assets/images/login.png)

**A user's profile page**

When you're visiting your own page it says "you". If a user is visiting **another** user's profile page "you" will say the other user's name. 

![index](https://github.com/craftykate/odin-project/blob/master/Chapter_04-Advanced_Rails/private_events/app/assets/images/profile.png)

**Event page for an event you haven't signed up for**

Note the handy "Attend!" button

![index](https://github.com/craftykate/odin-project/blob/master/Chapter_04-Advanced_Rails/private_events/app/assets/images/not_attending.png)

**Event page for an event you HAVE signed up for**

The "Attend!" button is now a message saying you are attending.

![index](https://github.com/craftykate/odin-project/blob/master/Chapter_04-Advanced_Rails/private_events/app/assets/images/attending.png)
