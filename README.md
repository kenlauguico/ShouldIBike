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
  <img src="http://i.imgur.com/p49tQ7V.png" />
</p>

**Should I Bike** simply grabs the phone's current location and, through some logic, determines whether or not it is appropriate to bike based on the weather conditions.

Future version will have the ability to input the zip code of a city to see if it's safe to bike there as well.

ShouldIBikeAPI
---
A custom wrapper around SimpleNWS to get necesarry object calls for weather.

Contains two simple calls that the iOS app calls. These calls returns city details, answer, and weather as `BikeAnswer` object, containing `City`, `BikeAnswerType`, and `NextTenHours` of weather information. 

```
[manager getCityDetailsWithZip:(NSString *)zip callback:(NSDictionary *dictionary) {
  // handle response
}];

// or

[manager getCityDetailsWithLocation:(CLLocation *)location callback:(NSDictionary *dictionary) {
  // handle response
}];
```

And this would be an example JSON response:

```
{
  "city": {
    "name": "South San Francisco",
    "zip": "94080",
    "lat": 37.6531903,
    "lng": -122.4184108
  },
  "type": 1,
  "next_ten": {
    "0": {
      "weather_condition": "fog",
      "timestamp": 1408868154,
      "sunrise_timestamp": null,
      "sunset_timestamp": null,
      "temp_in_fahrenheit": 60,
      "humidity": null,
      "wind_direction": null,
      "wind_speed_in_mph": null,
      "wind_chill": null,
      "precipitation": null,
      "precipitation_per_hour": null
    },
    "1": {
      "weather_condition": "fog",
      "timestamp": 1408868154,
      "temp_in_fahrenheit": 60
    },
    "2": {
      "weather_condition": "fog",
      "timestamp": 1408878954,
      "temp_in_fahrenheit": 59
    },
    "3": {
      "weather_condition": "fog",
      "timestamp": 1408889754,
      "temp_in_fahrenheit": 61
    },
    //...
  }
}
```
