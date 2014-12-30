# Flight Booker App

Project Source: http://www.theodinproject.com/ruby-on-rails/building-advanced-forms

**Odin's Notes:** In this project, you'll get a chance to tackle some more advanced forms. This is the kind of thing you'll have to work with when handling user orders for anything more complicated than an e-book. In this case, we'll build the first three steps of a typical checkout process for booking a one-way flight:

A typical airline booking flow:

1. Enter desired dates / airports and click "Search"
2. Choose from among a list of eligible flights
3. Enter passenger information for all passengers

## Screenshots

Here are some screenshots of the site, as it's not on Heroku:

**Search Flights**

A simple form letting you pick departure and arrival airports, number of passengers and the date. 
![index](https://github.com/craftykate/odin-project/blob/master/Chapter_04-Advanced_Rails/flight-booker/app/assets/images/flight-1.png)

**Pick a Flight**

After entering in search criteria and clicking "Find Flights", you'll see a list of applicable flights to pick from. 
![index](https://github.com/craftykate/odin-project/blob/master/Chapter_04-Advanced_Rails/flight-booker/app/assets/images/flight-2.png)

**Book Flight**

After choosing a flight and clicking "Select Flight", you'll be taken to a booking page with the flight info and a form to enter in the passenger info.
![index](https://github.com/craftykate/odin-project/blob/master/Chapter_04-Advanced_Rails/flight-booker/app/assets/images/flight-3.png)

**Confirmation**

After clicking "Book Flight", you'll see a success message, along with a "ticket" with the flight data and passenger info.  
![index](https://github.com/craftykate/odin-project/blob/master/Chapter_04-Advanced_Rails/flight-booker/app/assets/images/flight-4.png)