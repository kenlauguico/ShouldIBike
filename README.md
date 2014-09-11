Should I Bike?
===

<p align="center">
  <img src="http://i.imgur.com/GlhXsDE.png" />
</p>

Originally a web app created by [Victor Tolosa](http://victortolosa.com/bike/). I wanted to convert this to an iOS app from the ground up, creating an API that communicates with the iOS client side. You'll find the source for both the API and Xcode iOS 8 project.

<p align="center">
  <img src="http://victortolosa.com/portfolio/imgs/projectmockups/bikenow.png" />
</p>


ShouldIBikeApp
---
Contains the source for the ShouldIBike iOS 8 app.

<p align="center">
  <img src="http://i.imgur.com/niLQV53.png" />
</p>

**Should I Bike** simply grabs the phone's current location and, through some logic, determines whether or not it is appropriate to bike based on the weather conditions.

Future version will have the ability to input the zip code of a city to see if it's safe to bike there as well.


ShouldIBikeAPI
---
A custom wrapper around [Weather Underground](http://www.wunderground.com/) to get necesarry object calls for weather.

Contains two simple calls that the iOS app calls. These calls returns city details, answer, and weather as `BikeAnswer` object, containing `City`, `BikeAnswerType`, and `NextTenHours` of weather information.

```
[manager getShouldIBikeAnswerWithZip:(NSString *)zip callback:(NSDictionary *dictionary) {
  // handle response
}];

// or

[manager getShouldIBikeAnswerWithLocation:(CLLocation *)location callback:(NSDictionary *dictionary) {
  // handle response
}];
```

And this would be an example JSON response:

```
{
  "city": {
    "name": "South San Francisco",
    "zip": "94080",
    "lat": "37.65237808",
    "lng": "-122.42989349"
  },
  "answer_type": 1,
  "next_ten": {
    "0": {
      "weather_condition": "Partly Cloudy",
      "timestamp": "1409216321",
      "sunrise_timestamp": null,
      "sunset_timestamp": null,
      "temp_in_fahrenheit": 58.8,
      "humidity": "95%",
      "wind_direction": "NW",
      "wind_speed_in_mph": 4.7,
      "wind_chill": "NA",
      "precipitation": "0.00",
      "precipitation_per_hour": "-999.00"
    },
    "1": {
      "weather_condition": "Partly Cloudy",
      "timestamp": "1409216400",
      "temp_in_fahrenheit": "58"
    },
    "2": {
      "weather_condition": "Partly Cloudy",
      "timestamp": "1409220000",
      "temp_in_fahrenheit": "57"
    },
    "3": {
      "weather_condition": "Partly Cloudy",
      "timestamp": "1409223600",
      "temp_in_fahrenheit": "57"
    },
    //...
  }
}
```
